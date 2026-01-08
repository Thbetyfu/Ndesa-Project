# 🚀 Quick Start Guide - NDESA

## 📌 Masalah: Docker Error

**Error yang Anda alami:**
```
unable to get image 'postgres:15-alpine': 
The system cannot find the file specified.
```

**Penyebab:** Docker Desktop tidak berjalan di komputer Anda.

---

## ✅ 3 Pilihan Solusi

### **Option 1: Install Docker Desktop (RECOMMENDED)** ⭐

#### Langkah-langkah:

1. **Download Docker Desktop:**
   - Buka: https://www.docker.com/products/docker-desktop/
   - Klik **"Download for Windows"**
   - Install file yang terdownload

2. **Start Docker Desktop:**
   - Buka aplikasi **Docker Desktop** dari Start Menu
   - Tunggu hingga status **"Engine running"** (biasanya 1-2 menit)
   - Lihat ikon 🐳 di taskbar bawah kanan

3. **Jalankan Docker Compose:**
   ```powershell
   cd "d:\0. Kerjaan\Ndesa\NDESA_Code"
   docker-compose up -d
   ```

4. **Verifikasi Services:**
   ```powershell
   docker-compose ps
   ```
   
   Output yang benar:
   ```
   NAME            IMAGE               STATUS
   ndesa-postgres  postgres:15-alpine  Up
   ndesa-redis     redis:7-alpine      Up
   ndesa-minio     minio/minio:latest  Up
   ```

5. **Lanjut ke Backend Setup** (lihat di bawah ⬇️)

---

### **Option 2: Gunakan Database Cloud (NO DOCKER NEEDED)** ☁️

Jika tidak ingin install Docker, gunakan database gratis di cloud:

#### A. PostgreSQL Cloud (Neon.tech):
1. Buka: https://neon.tech
2. Sign up (gratis)
3. Create new project → Create database
4. Copy connection string
5. Edit `backend/.env`:
   ```env
   DATABASE_HOST=ep-xxxxx.neon.tech
   DATABASE_PORT=5432
   DATABASE_USERNAME=your_username
   DATABASE_PASSWORD=your_password
   DATABASE_NAME=neondb
   DATABASE_SSL=true
   ```

#### B. Redis Cloud (Redis Labs):
1. Buka: https://redis.com/try-free/
2. Sign up (gratis)
3. Create database
4. Copy endpoint dan password
5. Edit `backend/.env`:
   ```env
   REDIS_HOST=redis-xxxxx.redis.cloud.com
   REDIS_PORT=12345
   REDIS_PASSWORD=your_password
   ```

#### C. Skip MinIO (gunakan local filesystem sementara):
Edit `backend/.env`:
```env
# Comment out S3 config:
# S3_ENDPOINT=http://localhost:9000
# S3_ACCESS_KEY_ID=minioadmin
# S3_SECRET_ACCESS_KEY=minioadmin123

# Gunakan local storage:
STORAGE_TYPE=local
UPLOAD_DIR=./uploads
```

**Lanjut ke Backend Setup** (lihat di bawah ⬇️)

---

### **Option 3: Install Database Manual (Advanced)** 🔧

#### PostgreSQL:
```powershell
# 1. Download: https://www.postgresql.org/download/windows/
# 2. Install dengan default settings
# 3. Set password untuk user postgres
# 4. Update backend/.env:

DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_USERNAME=postgres
DATABASE_PASSWORD=your_password
DATABASE_NAME=ndesa_dev
```

#### Redis:
```powershell
# 1. Download: https://github.com/microsoftarchive/redis/releases
# 2. Download Redis-x64-3.2.100.msi
# 3. Install
# 4. Update backend/.env:

REDIS_HOST=localhost
REDIS_PORT=6379
```

---

## 🎯 Backend Setup (Setelah Database Ready)

### 1. Cek .env file:
```powershell
cd backend
type .env
```

Pastikan semua variabel terisi dengan benar.

### 2. Run Database Migrations:
```powershell
npm run migration:run
```

**Output yang benar:**
```
query: CREATE TABLE "tenants" (...)
query: CREATE TABLE "desas" (...)
query: CREATE TABLE "users" (...)
query: CREATE TABLE "talent_profiles" (...)
query: CREATE TABLE "otps" (...)
Migration has been executed successfully.
```

**Jika error:** Cek koneksi database di .env

### 3. Start Backend Server:
```powershell
npm run dev
```

**Output yang benar:**
```
[Nest] Starting Nest application...
[Nest] TypeOrmModule dependencies initialized
🚀 NDESA Backend running on: http://localhost:3000
📚 API Documentation: http://localhost:3000/api/docs
```

### 4. Test API:
Buka browser: **http://localhost:3000/api/docs**

Anda akan melihat Swagger UI dengan endpoints:
- POST `/v1/auth/register`
- POST `/v1/auth/login`
- POST `/v1/auth/verify-otp`
- dll.

---

## 📱 Mobile Setup (Optional - Untuk Test)

### 1. Cek Flutter:
```powershell
cd mobile
flutter doctor
```

### 2. Run App (dengan emulator/device):
```powershell
flutter run
```

Atau build APK:
```powershell
flutter build apk
```

---

## 🧪 Test Authentication Flow

### 1. Register User Baru:

Buka Swagger UI: http://localhost:3000/api/docs

POST `/v1/auth/register`:
```json
{
  "email": "talenta1@example.com",
  "password": "Password123!",
  "phone": "+628123456789",
  "fullName": "Ahmad Talenta",
  "role": "TALENTA"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "userId": "uuid-here",
    "email": "talenta1@example.com",
    "message": "Registration successful. Please verify your OTP."
  }
}
```

**Cek Console Backend** - Anda akan melihat OTP code (contoh: 123456)

### 2. Verify OTP:

POST `/v1/auth/verify-otp`:
```json
{
  "code": "123456"
}
```

(Klik 🔒 Authorize di Swagger, masukkan token dari login)

### 3. Login:

POST `/v1/auth/login`:
```json
{
  "email": "talenta1@example.com",
  "password": "Password123!"
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": { ... },
    "accessToken": "eyJhbGc...",
    "refreshToken": "eyJhbGc..."
  }
}
```

Copy `accessToken`, klik **Authorize** di Swagger, paste token.

Sekarang Anda bisa test endpoint yang dilindungi!

---

## ❌ Common Errors & Fixes

### Error: "Port 3000 already in use"
```powershell
# Cari dan kill process:
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Atau ubah port di .env:
PORT=3001
```

### Error: "Cannot connect to database"
```powershell
# Test koneksi:
npm run typeorm -- query "SELECT NOW()"

# Jika gagal, cek:
# 1. Database running?
# 2. Username/password benar?
# 3. Firewall tidak block?
```

### Error: "Migration failed"
```powershell
# Reset database:
npm run typeorm -- schema:drop
npm run migration:run
```

---

## 📊 Sprint 1 Status

### ✅ COMPLETED:
- ✅ Backend: 874 packages installed
- ✅ Mobile: 126 packages installed, build_runner success
- ✅ Infrastructure: Docker Compose ready
- ✅ Database: Schema designed (5 entities)
- ✅ Auth: JWT + RBAC implemented
- ✅ API Docs: Swagger configured

### ⏳ NEXT STEPS:
1. ✅ Start Docker Desktop
2. ✅ Run `docker-compose up -d`
3. ✅ Run `npm run migration:run`
4. ✅ Run `npm run dev`
5. ✅ Test API via Swagger

---

## 🆘 Need Help?

Jika masih error setelah mengikuti panduan ini:

1. **Screenshot error message**
2. **Copy full terminal output**
3. **Beritahu di step mana error terjadi**

Saya akan bantu lebih detail!

---

**Next:** [TROUBLESHOOTING.md](TROUBLESHOOTING.md) untuk panduan lengkap troubleshooting

**Sprint 1 Completion Report:** [SPRINT_1_COMPLETION.md](SPRINT_1_COMPLETION.md)

---

**Last Updated:** 2026-01-03 03:05:00 +08:00
