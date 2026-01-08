import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  OneToOne,
  JoinColumn,
  Index,
} from 'typeorm';
import { Exclude } from 'class-transformer';
import { Tenant } from '../common/entities/tenant.entity';
import { Desa } from '../desa/desa.entity';
import { TalentProfile } from '../talents/talent-profile.entity';

export enum UserRole {
  TALENTA = 'talenta',
  PEMDES_ADMIN = 'pemdes_admin',
  MITRA_ADMIN = 'mitra_admin',
  DPMD = 'dpmd',
  INSPEKTORAT = 'inspektorat',
  SUPER_ADMIN = 'super_admin',
}

export enum UserStatus {
  ACTIVE = 'active',
  SUSPENDED = 'suspended',
  PENDING = 'pending',
}

@Entity('users')
@Index('idx_user_email', ['email'])
@Index('idx_user_phone', ['phone'])
@Index('idx_user_tenant', ['tenantId'])
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ name: 'tenant_id', type: 'uuid' })
  tenantId: string;

  @Column({ name: 'desa_id', type: 'uuid', nullable: true })
  desaId: string | null;

  @Column({ type: 'varchar', length: 255, unique: true })
  email: string;

  @Column({ type: 'varchar', length: 20, nullable: true })
  phone: string | null;

  @Column({ name: 'password_hash', type: 'varchar', length: 255 })
  @Exclude()
  passwordHash: string;

  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.TALENTA,
  })
  role: UserRole;

  @Column({
    type: 'enum',
    enum: UserStatus,
    default: UserStatus.PENDING,
  })
  status: UserStatus;

  @Column({ name: 'email_verified', type: 'boolean', default: false })
  emailVerified: boolean;

  @Column({ name: 'phone_verified', type: 'boolean', default: false })
  phoneVerified: boolean;

  @Column({ name: 'last_login', type: 'timestamp', nullable: true })
  lastLogin: Date | null;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;

  // Relations
  @ManyToOne(() => Tenant)
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;

  @ManyToOne(() => Desa, { nullable: true })
  @JoinColumn({ name: 'desa_id' })
  desa: Desa | null;

  @OneToOne(() => TalentProfile, (profile) => profile.user, {
    cascade: true,
  })
  talentProfile: TalentProfile;
}
