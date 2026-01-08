import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TalentsService } from './talents.service';
import { TalentProfile } from './talent-profile.entity';
import { User } from '../users/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([TalentProfile, User])],
  providers: [TalentsService],
  exports: [TalentsService],
})
export class TalentsModule {}
