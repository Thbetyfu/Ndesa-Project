import {
  IsString,
  IsNotEmpty,
  MaxLength,
  Matches,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class UploadKtpDto {
  @ApiProperty({ example: '3216012345678901' })
  @IsString()
  @IsNotEmpty()
  @Matches(/^\d{16}$/, {
    message: 'NIK harus 16 digit angka',
  })
  nik: string;

  @ApiProperty({ example: 'Budi Santoso' })
  @IsString()
  @IsNotEmpty()
  @MaxLength(255)
  fullName: string;

  @ApiProperty({ example: 'Jl. Merdeka No. 123, Jakarta' })
  @IsString()
  @IsNotEmpty()
  @MaxLength(500)
  address: string;
}
