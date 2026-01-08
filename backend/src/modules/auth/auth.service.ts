import {
  Injectable,
  UnauthorizedException,
  BadRequestException,
  ConflictException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import * as bcrypt from 'bcrypt';
import { User, UserStatus, UserRole } from '../users/user.entity';
import { TalentProfile, KycStatus } from '../talents/talent-profile.entity';
import { Otp, OtpType } from './otp.entity';
import { RegisterDto, LoginDto, VerifyOtpDto } from './dto/auth.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(TalentProfile)
    private talentProfileRepository: Repository<TalentProfile>,
    @InjectRepository(Otp)
    private otpRepository: Repository<Otp>,
    private jwtService: JwtService,
    private configService: ConfigService,
  ) {}

  async register(dto: RegisterDto, tenantId: string) {
    // Check if user already exists
    const existingUser = await this.userRepository.findOne({
      where: { email: dto.email },
    });

    if (existingUser) {
      throw new ConflictException('Email sudah terdaftar');
    }

    // Hash password
    const passwordHash = await bcrypt.hash(dto.password, 10);

    // Create user
    const user = this.userRepository.create({
      email: dto.email,
      phone: dto.phone,
      passwordHash,
      role: dto.role,
      tenantId,
      desaId: dto.desaId || null,
      status: UserStatus.PENDING,
    });

    await this.userRepository.save(user);

    // Create talent profile if role is talenta
    if (dto.role === UserRole.TALENTA) {
      const profile = this.talentProfileRepository.create({
        userId: user.id,
        fullName: dto.fullName,
        kycStatus: KycStatus.PENDING,
      });
      await this.talentProfileRepository.save(profile);
    }

    // Generate and send OTP
    const otp = await this.generateOtp(user.id, OtpType.EMAIL_VERIFICATION);

    // TODO: Send OTP via email/SMS
    console.log(`OTP for ${user.email}: ${otp.code}`);

    return {
      userId: user.id,
      email: user.email,
      message: 'Registrasi berhasil. Silakan cek email untuk verifikasi OTP.',
    };
  }

  async login(dto: LoginDto) {
    const user = await this.userRepository.findOne({
      where: { email: dto.email },
    });

    if (!user) {
      throw new UnauthorizedException('Email atau password salah');
    }

    const isPasswordValid = await bcrypt.compare(dto.password, user.passwordHash);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Email atau password salah');
    }

    if (!user.emailVerified) {
      throw new UnauthorizedException('Email belum terverifikasi');
    }

    if (user.status !== UserStatus.ACTIVE) {
      throw new UnauthorizedException('Akun Anda tidak aktif');
    }

    // Update last login
    user.lastLogin = new Date();
    await this.userRepository.save(user);

    // Generate JWT tokens
    const tokens = await this.generateTokens(user);

    return {
      user: {
        id: user.id,
        email: user.email,
        role: user.role,
        tenantId: user.tenantId,
      },
      ...tokens,
    };
  }

  async verifyOtp(email: string, dto: VerifyOtpDto) {
    // Find user by email
    const user = await this.userRepository.findOne({ where: { email } });

    if (!user) {
      throw new BadRequestException('User tidak ditemukan');
    }

    const otp = await this.otpRepository.findOne({
      where: {
        userId: user.id,
        code: dto.code,
        type: OtpType.EMAIL_VERIFICATION,
        isUsed: false,
      },
    });

    if (!otp) {
      throw new BadRequestException('Kode OTP tidak valid');
    }

    if (new Date() > otp.expiresAt) {
      throw new BadRequestException('Kode OTP sudah kadaluarsa');
    }

    // Mark OTP as used
    otp.isUsed = true;
    await this.otpRepository.save(otp);

    // Update user status
    user.emailVerified = true;
    user.status = UserStatus.ACTIVE;
    await this.userRepository.save(user);

    return {
      message: 'Email berhasil diverifikasi',
    };
  }

  async resendOtp(email: string) {
    const user = await this.userRepository.findOne({ where: { email } });

    if (!user) {
      throw new BadRequestException('User tidak ditemukan');
    }

    if (user.emailVerified) {
      throw new BadRequestException('Email sudah terverifikasi');
    }

    const otp = await this.generateOtp(user.id, OtpType.EMAIL_VERIFICATION);

    // TODO: Send OTP via email
    console.log(`Resend OTP for ${user.email}: ${otp.code}`);

    return {
      message: 'Kode OTP baru telah dikirim ke email Anda',
    };
  }

  private async generateOtp(userId: string, type: OtpType) {
    const code = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresIn = this.configService.get('OTP_EXPIRES_IN', 300); // 5 minutes

    const otp = this.otpRepository.create({
      userId,
      code,
      type,
      expiresAt: new Date(Date.now() + expiresIn * 1000),
    });

    return this.otpRepository.save(otp);
  }

  private async generateTokens(user: User) {
    const payload = {
      sub: user.id,
      email: user.email,
      role: user.role,
      tenantId: user.tenantId,
    };

    const accessToken = this.jwtService.sign(payload, {
      expiresIn: this.configService.get('JWT_EXPIRES_IN', '7d'),
    });

    const refreshToken = this.jwtService.sign(payload, {
      secret: this.configService.get('JWT_REFRESH_SECRET'),
      expiresIn: this.configService.get('JWT_REFRESH_EXPIRES_IN', '30d'),
    });

    return {
      accessToken,
      refreshToken,
    };
  }
}
