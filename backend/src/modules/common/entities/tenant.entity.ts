import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
} from 'typeorm';

export enum TenantType {
  KABUPATEN = 'kabupaten',
  KOTA = 'kota',
}

@Entity('tenants')
@Index('idx_tenant_name', ['name'])
export class Tenant {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({
    type: 'enum',
    enum: TenantType,
    default: TenantType.KABUPATEN,
  })
  type: TenantType;

  @Column({ type: 'varchar', length: 100 })
  province: string;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive: boolean;

  @CreateDateColumn({ name: 'created_at' })
  createdAt: Date;

  @UpdateDateColumn({ name: 'updated_at' })
  updatedAt: Date;
}
