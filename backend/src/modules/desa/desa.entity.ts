import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
  Index,
} from 'typeorm';
import { Tenant } from '../common/entities/tenant.entity';

export enum DesaStatus {
  SWASEMBADA = 'swasembada',
  BERKEMBANG = 'berkembang',
  TERTINGGAL = 'tertinggal',
}

@Entity('desas')
@Index('idx_desa_tenant', ['tenantId'])
@Index('idx_desa_kode', ['kodeDesa'])
export class Desa {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ name: 'tenant_id', type: 'uuid' })
  tenantId: string;

  @Column({ name: 'kode_desa', type: 'varchar', length: 20, unique: true })
  kodeDesa: string;

  @Column({ name: 'nama_desa', type: 'varchar', length: 255 })
  namaDesa: string;

  @Column({ name: 'kecamatan', type: 'varchar', length: 255 })
  kecamatan: string;

  @Column({
    name: 'status',
    type: 'enum',
    enum: DesaStatus,
    default: DesaStatus.BERKEMBANG,
  })
  status: DesaStatus;

  @Column({ name: 'population', type: 'integer', nullable: true })
  population: number;

  @Column({ name: 'latitude', type: 'decimal', precision: 10, scale: 7, nullable: true })
  latitude: number;

  @Column({ name: 'longitude', type: 'decimal', precision: 10, scale: 7, nullable: true })
  longitude: number;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;

  // Relations
  @ManyToOne(() => Tenant)
  @JoinColumn({ name: 'tenant_id' })
  tenant: Tenant;
}
