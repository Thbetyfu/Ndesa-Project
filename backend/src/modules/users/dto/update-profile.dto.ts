import {
  IsString,
  IsOptional,
  IsDateString,
  IsEnum,
  MaxLength,
  Matches,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export enum Gender {
  MALE = 'MALE',
  FEMALE = 'FEMALE',
}

export class UpdateProfileDto {
  @ApiProperty({ example: 'Budi Santoso', required: false })
  @IsOptional()
  @IsString()
  @MaxLength(255)
  fullName?: string;

  @ApiProperty({ example: '1995-08-17', required: false })
  @IsOptional()
  @IsDateString()
  dateOfBirth?: string;

  @ApiProperty({ example: 'MALE', enum: Gender, required: false })
  @IsOptional()
  @IsEnum(Gender)
  gender?: Gender;

  @ApiProperty({
    example: 'Jl. Merdeka No. 123, RT 01/RW 02, Kelurahan Maju',
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(500)
  address?: string;

  @ApiProperty({ example: '+628123456789', required: false })
  @IsOptional()
  @IsString()
  @Matches(/^\+628\d{8,12}$/, {
    message: 'Format nomor telepon harus +628XXXXXXXXX',
  })
  phone?: string;

  @ApiProperty({
    example: 'Saya adalah fresh graduate yang tertarik dengan IT',
    required: false,
  })
  @IsOptional()
  @IsString()
  @MaxLength(1000)
  bio?: string;
}
