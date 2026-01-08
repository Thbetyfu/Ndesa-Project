import {
  Injectable,
  NotFoundException,
  BadRequestException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TalentProfile, KycStatus } from './talent-profile.entity';
import { User } from '../users/user.entity';

@Injectable()
export class TalentsService {
  constructor(
    @InjectRepository(TalentProfile)
    private talentProfileRepository: Repository<TalentProfile>,
    @InjectRepository(User)
    private userRepository: Repository<User>,
  ) {}

  async getProfile(userId: string) {
    const profile = await this.talentProfileRepository.findOne({
      where: { userId },
      relations: ['user'],
    });

    if (!profile) {
      throw new NotFoundException('Profile tidak ditemukan');
    }

    return profile;
  }

  async updateProfile(userId: string, updates: Partial<TalentProfile>) {
    const profile = await this.getProfile(userId);

    Object.assign(profile, updates);
    return this.talentProfileRepository.save(profile);
  }

  async uploadKtp(userId: string, ktpUrl: string, nik: string) {
    const profile = await this.getProfile(userId);

    profile.ktpUrl = ktpUrl;
    profile.nik = nik;
    profile.kycStatus = KycStatus.PENDING;

    return this.talentProfileRepository.save(profile);
  }

  async uploadSelfie(userId: string, selfieUrl: string) {
    const profile = await this.getProfile(userId);

    profile.selfieUrl = selfieUrl;

    // Auto-verify if both KTP and selfie uploaded
    if (profile.ktpUrl && profile.selfieUrl) {
      profile.kycStatus = KycStatus.VERIFIED;
    }

    return this.talentProfileRepository.save(profile);
  }
}
