# 🚨 Troubleshooting Guide - NDESA Setup

## ❌ Error: Docker Desktop Not Running

### Gejala:
```
unable to get image 'postgres:15-alpine': error during connect: 
Get "http://%2F%2F.%2Fpipe%2FdockerDesktopLinuxEngine/v1.51/images/...": 
open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.
```

### Penyebab:
**Docker Desktop belum dijalankan / tidak terinstall**

---

## ✅ Solusi 1: Install & Start Docker Desktop (RECOMMENDED)

### Langkah 1: Download Docker Desktop
1. Buka: https://www.docker.com/products/docker-desktop/
2. Download **Docker Desktop for Windows**
3. Install dengan double-click file installer
4. Restart komputer jika diminta

### Langkah 2: Start Docker Desktop
1. Buka aplikasi **Docker Desktop** dari Start Menu
2. Tunggu hingga muncul **"Docker Desktop is running"** di system tray
3. Anda akan lihat ikon 🐳 di taskbar bawah kanan
4. Status harus **"Engine running"**

### Langkah 3: Jalankan Ulang Docker Compose
```powershell
cd "d:\0. Kerjaan\Ndesa\NDESA_Code"
docker-compose up -d
```

### Verifikasi Services Running:
```powershell
docker-compose ps
```

Anda harus melihat:
```
NAME                IMAGE               STATUS
ndesa-postgres      postgres:15-alpine  Up
ndesa-redis         redis:7-alpine      Up  
ndesa-minio         minio/minio:latest  Up
```

---

## ✅ Solusi 2: Jalankan Backend TANPA Docker (Alternative)

Jika Anda **tidak ingin install Docker**, bisa install database secara manual:

### Option A: Gunakan Database Cloud (EASIEST)

#### 1. PostgreSQL Cloud (Neon.tech - FREE):
```bash
# 1. Buat akun di https://neon.tech (gratis)
# 2. Buat database baru, dapatkan connection string
# 3. Update .env:

DATABASE_HOST=ep-xxx.neon.tech
DATABASE_PORT=5432
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=your_password
DATABASE_NAME=ndesa_dev
DATABASE_SSL=true
```

#### 2. Redis Cloud (Redis Labs - FREE):
```bash
# 1. Buat akun di https://redis.com/try-free/ (gratis)
# 2. Buat database baru, dapatkan connection string
# 3. Update .env:

REDIS_HOST=redis-xxxxx.redis.cloud.com
REDIS_PORT=12345
REDIS_PASSWORD=your_password
```

#### 3. S3 Storage (AWS S3 atau Cloudinary):
```bash
# Gunakan Cloudinary untuk file storage (gratis):
# 1. Daftar di https://cloudinary.com (gratis)
# 2. Update .env:

S3_ENDPOINT=https://api.cloudinary.com/v1_1/your_cloud_name
S3_ACCESS_KEY_ID=your_api_key
S3_SECRET_ACCESS_KEY=your_api_secret
```

### Option B: Install Database Lokal (Windows)

#### PostgreSQL:
```powershell
# 1. Download PostgreSQL 15:
# https://www.postgresql.org/download/windows/

# 2. Install dengan default settings
# 3. Catat password yang Anda set untuk user postgres

# 4. Update .env:
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=your_password
DATABASE_NAME=ndesa_dev
```

#### Redis:
```powershell
# 1. Download Redis untuk Windows:
# https://github.com/microsoftarchive/redis/releases
# Redis-x64-3.2.100.msi

# 2. Install dengan default settings

# 3. Update .env:
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
```

---

## 🎯 Langkah-Langkah Setelah Database Ready

### 1. Cek Koneksi Database:
```powershell
cd backend

# Test PostgreSQL connection:
npm run typeorm -- query "SELECT NOW()"

# Jika berhasil, lanjut ke migration
```

### 2. Jalankan Database Migrations:
```powershell
npm run migration:run
```

Output yang diharapkan:
```
query: SELECT * FROM "migrations" "migrations" ORDER BY "id" DESC
query: CREATE TABLE "tenants" (...)
query: CREATE TABLE "desas" (...)
query: CREATE TABLE "users" (...)
query: CREATE TABLE "talent_profiles" (...)
query: CREATE TABLE "otps" (...)
Migration CreateInitialSchema1704240000000 has been executed successfully.
```

### 3. Start Backend Server:
```powershell
npm run dev
```

Output yang diharapkan:
```
[Nest] 12345  - 2026/01/03, 02:57:00     LOG [NestFactory] Starting Nest application...
[Nest] 12345  - 2026/01/03, 02:57:00     LOG [InstanceLoader] AppModule dependencies initialized
[Nest] 12345  - 2026/01/03, 02:57:00     LOG [InstanceLoader] TypeOrmModule dependencies initialized
[Nest] 12345  - 2026/01/03, 02:57:01     LOG [RoutesResolver] AuthController {/v1/auth}:
[Nest] 12345  - 2026/01/03, 02:57:01     LOG [RouterExplorer] Mapped {/v1/auth/register, POST} route
[Nest] 12345  - 2026/01/03, 02:57:01     LOG [RouterExplorer] Mapped {/v1/auth/login, POST} route
[Nest] 12345  - 2026/01/03, 02:57:01     LOG [NestApplication] Nest application successfully started
🚀 NDESA Backend running on: http://localhost:3000
📚 API Documentation: http://localhost:3000/api/docs
```

### 4. Test API via Swagger:
1. Buka browser: http://localhost:3000/api/docs
2. Anda akan melihat Swagger UI dengan semua endpoints
3. Test endpoint POST `/v1/auth/register`

---

## 🐛 Troubleshooting Errors Lainnya

### Error: "Port 3000 already in use"
```powershell
# Cek process yang menggunakan port 3000:
netstat -ano | findstr :3000

# Kill process:
taskkill /PID <PID_NUMBER> /F

# Atau ubah port di .env:
PORT=3001
```

### Error: "Cannot connect to database"
```powershell
# Test koneksi manual:
psql -h localhost -U ndesa_user -d ndesa_dev

# Jika gagal, cek:
# 1. PostgreSQL service running? (Task Manager → Services)
# 2. Username/password di .env benar?
# 3. Database sudah dibuat? (buat dengan: CREATE DATABASE ndesa_dev;)
```

### Error: "npm ERR! Missing script"
```powershell
# Pastikan Anda di folder backend:
cd "d:\0. Kerjaan\Ndesa\NDESA_Code\backend"

# Cek package.json ada:
dir package.json

# Install dependencies jika belum:
npm install
```

### Error: Flutter build_runner gagal
```powershell
cd "d:\0. Kerjaan\Ndesa\NDESA_Code\mobile"

# Clean build cache:
flutter clean

# Get dependencies:
flutter pub get

# Run build_runner lagi:
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📋 Checklist Setup

Gunakan checklist ini untuk memastikan semua berjalan:

### ✅ Backend Setup:
- [ ] PostgreSQL installed dan running (atau menggunakan cloud)
- [ ] Redis installed dan running (atau menggunakan cloud)
- [ ] `.env` file sudah dibuat di `backend/`
- [ ] `npm install` sudah selesai (874 packages)
- [ ] Database migrations berhasil dijalankan
- [ ] Backend server bisa start (`npm run dev`)
- [ ] Swagger UI bisa diakses di http://localhost:3000/api/docs

### ✅ Mobile Setup:
- [ ] Flutter SDK terinstall (`flutter --version`)
- [ ] `flutter pub get` berhasil (126 packages)
- [ ] `build_runner` berhasil generate files (.freezed.dart, .g.dart)
- [ ] Tidak ada error di `flutter analyze`

### ✅ Infrastructure:
- [ ] Docker Desktop running (opsional, jika pakai Docker)
- [ ] `docker-compose up -d` berhasil (jika pakai Docker)
- [ ] Semua services running: postgres, redis, minio

---

## 🆘 Jika Masih Error

Jika masih mengalami error setelah mengikuti panduan di atas:

1. **Screenshot error message** yang muncul
2. **Copy full error log** dari terminal
3. **Beritahu saya error di step mana** (migration? start server? docker?)

Saya akan bantu troubleshoot lebih detail!

---

## 🎯 Quick Start (Tanpa Docker)

Jika Anda ingin **langsung coba backend tanpa setup database**:

### Gunakan SQLite (Development Only):

1. Edit `backend/src/app.module.ts`:
```typescript
TypeOrmModule.forRoot({
  type: 'sqlite',
  database: 'ndesa_dev.db',
  entities: [__dirname + '/**/*.entity{.ts,.js}'],
  synchronize: true, // Auto-create tables
}),
```

2. Install sqlite3:
```powershell
cd backend
npm install sqlite3
```

3. Start server:
```powershell
npm run dev
```

⚠️ **Note**: SQLite hanya untuk testing, **TIDAK untuk production**!

---

**Last Updated:** 2026-01-03 03:00:00 +08:00
