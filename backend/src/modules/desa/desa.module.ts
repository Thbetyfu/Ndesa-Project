import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DesaService } from './desa.service';
import { Desa } from './desa.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Desa])],
  providers: [DesaService],
  exports: [DesaService],
})
export class DesaModule {}
