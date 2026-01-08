import { DataSource } from 'typeorm';
import { config } from 'dotenv';

// Load environment variables
config();

export default new DataSource({
  type: 'postgres',
  host: process.env.DATABASE_HOST || 'localhost',
  port: parseInt(process.env.DATABASE_PORT || '5432', 10),
  username: process.env.DATABASE_USERNAME || 'ndesa_user',
  password: process.env.DATABASE_PASSWORD || 'ndesa_password',
  database: process.env.DATABASE_NAME || 'ndesa_dev',
  entities: [__dirname + '/../modules/**/*.entity{.ts,.js}'],
  migrations: [__dirname + '/../migrations/*{.ts,.js}'],
  synchronize: false, // MUST be false for migrations
  logging: process.env.NODE_ENV === 'development',
});
