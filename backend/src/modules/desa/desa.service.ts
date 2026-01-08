import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Desa } from './desa.entity';

@Injectable()
export class DesaService {
  constructor(
    @InjectRepository(Desa)
    private desaRepository: Repository<Desa>,
  ) {}

  async findAll(tenantId: string) {
    return this.desaRepository.find({
      where: { tenantId },
      order: { namaDesa: 'ASC' },
    });
  }

  async findById(id: string, tenantId: string) {
    return this.desaRepository.findOne({
      where: { id, tenantId },
    });
  }
}
