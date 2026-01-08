import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './user.entity';
import { UpdateProfileDto, Gender } from './dto/update-profile.dto';
import { UploadKtpDto } from './dto/upload-ktp.dto';
import { TalentProfile, KycStatus } from '../talents/talent-profile.entity';

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(TalentProfile)
    private talentProfileRepository: Repository<TalentProfile>,
  ) {}

  async findById(id: string): Promise<User | null> {
    return this.userRepository.findOne({
      where: { id },
      // Don't load desa relation here - it's not needed for JWT validation
      // and causes column mapping issues with TypeORM
      relations: ['tenant', 'talentProfile'],
    });
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.userRepository.findOne({
      where: { email },
    });
  }

  async findAll(tenantId: string, page: number = 1, limit: number = 20) {
    const [users, total] = await this.userRepository.findAndCount({
      where: { tenantId },
      skip: (page - 1) * limit,
      take: limit,
      order: { createdAt: 'DESC' },
    });

    return {
      data: users,
      meta: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async getProfile(userId: string): Promise<any> {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['tenant', 'desa', 'talentProfile'],
      select: {
        id: true,
        email: true,
        phone: true,
        role: true,
        status: true,
        emailVerified: true,
        phoneVerified: true,
        createdAt: true,
      },
    });

    if (!user) {
      throw new NotFoundException('User tidak ditemukan');
    }

    return {
      id: user.id,
      email: user.email,
      phone: user.phone,
      role: user.role,
      status: user.status,
      emailVerified: user.emailVerified,
      phoneVerified: user.phoneVerified,
      tenant: user.tenant
        ? {
            id: user.tenant.id,
            name: user.tenant.name,
            type: user.tenant.type,
          }
        : null,
      desa: user.desa
        ? {
            id: user.desa.id,
            namaDesa: user.desa.namaDesa,
            kecamatan: user.desa.kecamatan,
          }
        : null,
      talentProfile: user.talentProfile
        ? {
            id: user.talentProfile.id,
            fullName: user.talentProfile.fullName,
            dateOfBirth: user.talentProfile.dateOfBirth,
            gender: user.talentProfile.gender,
            address: user.talentProfile.address,
            nik: user.talentProfile.nik,
            ktpUrl: user.talentProfile.ktpUrl,
            selfieUrl: user.talentProfile.selfieUrl,
            kycStatus: user.talentProfile.kycStatus,
            bio: user.talentProfile.bio,
            avatarUrl: user.talentProfile.avatarUrl,
          }
        : null,
      createdAt: user.createdAt,
    };
  }

  async updateProfile(
    userId: string,
    dto: UpdateProfileDto,
  ): Promise<any> {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['talentProfile'],
    });

    if (!user) {
      throw new NotFoundException('User tidak ditemukan');
    }

    // Update user phone if provided
    if (dto.phone) {
      user.phone = dto.phone;
      await this.userRepository.save(user);
    }

    // Update or create talent profile
    if (user.talentProfile) {
      // Update existing profile
      if (dto.fullName) user.talentProfile.fullName = dto.fullName;
      if (dto.dateOfBirth) user.talentProfile.dateOfBirth = new Date(dto.dateOfBirth);
      if (dto.gender) {
        // Map Gender enum to database values
        user.talentProfile.gender = dto.gender === Gender.MALE ? 'male' : 'female';
      }
      if (dto.address) user.talentProfile.address = dto.address;
      if (dto.bio) user.talentProfile.bio = dto.bio;

      await this.talentProfileRepository.save(user.talentProfile);
    } else {
      // Create new profile
      const newProfile = this.talentProfileRepository.create({
        user: user, // Use 'user' relation instead of 'userId'
        userId: user.id,
        fullName: dto.fullName || '',
        dateOfBirth: dto.dateOfBirth ? new Date(dto.dateOfBirth) : null,
        gender: dto.gender ? (dto.gender === Gender.MALE ? 'male' : 'female') : null,
        address: dto.address,
        bio: dto.bio,
        kycStatus: KycStatus.PENDING,
      });

      await this.talentProfileRepository.save(newProfile);
    }

    return this.getProfile(userId);
  }

  async uploadKtp(
    userId: string,
    file: any, // Multer file object
    dto: UploadKtpDto,
  ): Promise<any> {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['talentProfile'],
    });

    if (!user) {
      throw new NotFoundException('User tidak ditemukan');
    }

    if (!user.talentProfile) {
      throw new BadRequestException('Profile belum dibuat');
    }

    // TODO: Upload to S3/MinIO (Sprint 2 - will implement)
    const ktpUrl = `/uploads/ktp/${file.filename}`;

    // Update talent profile with KTP data
    user.talentProfile.nik = dto.nik;
    user.talentProfile.fullName = dto.fullName;
    user.talentProfile.address = dto.address;
    user.talentProfile.ktpUrl = ktpUrl;

    await this.talentProfileRepository.save(user.talentProfile);

    return {
      message: 'KTP berhasil diupload',
      ktpUrl,
      nik: dto.nik,
      fullName: dto.fullName,
      address: dto.address,
    };
  }

  async uploadSelfie(
    userId: string,
    file: any, // Multer file object
  ): Promise<any> {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['talentProfile'],
    });

    if (!user) {
      throw new NotFoundException('User tidak ditemukan');
    }

    if (!user.talentProfile) {
      throw new BadRequestException('Profile belum dibuat');
    }

    // TODO: Upload to S3/MinIO (Sprint 2 - will implement)
    const selfieUrl = `/uploads/selfie/${file.filename}`;

    // Update talent profile with selfie
    user.talentProfile.selfieUrl = selfieUrl;

    // If both KTP and selfie uploaded, keep status as PENDING for review
    if (user.talentProfile.ktpUrl && selfieUrl) {
      user.talentProfile.kycStatus = KycStatus.PENDING;
    }

    await this.talentProfileRepository.save(user.talentProfile);

    return {
      message: 'Selfie berhasil diupload',
      selfieUrl,
      kycStatus: user.talentProfile.kycStatus,
    };
  }
}
