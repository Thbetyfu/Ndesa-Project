# 🚀 NDESA - Panduan Menjalankan Aplikasi

## 📋 Prasyarat

### Software yang Dibutuhkan
- **Node.js**: v20.x atau lebih tinggi
- **Flutter**: v3.16.0 atau lebih tinggi
- **Docker Desktop**: untuk PostgreSQL, Redis, dan MinIO
- **Git**: untuk version control

### Verifikasi Instalasi
```powershell
node --version      # v20.x.x
npm --version       # 10.x.x
flutter --version   # Flutter 3.16.0
docker --version    # Docker 27.x.x
```

---

## 🎯 Sprint 1 - Setup Infrastruktur (SUDAH SELESAI)

### ✅ Yang Sudah Dikerjakan:
1. **✅ S1-01**: Monorepo structure (backend/, mobile/, web/)
2. **✅ S1-02**: CI/CD pipeline (GitHub Actions)
3. **✅ S1-03**: PostgreSQL + Redis (docker-compose.yml)
4. **✅ S1-04**: Database schema (5 entities: Tenant, Desa, User, TalentProfile, Otp)
5. **✅ S1-05**: Auth service (JWT + RBAC complete)
6. **✅ S1-06**: S3 storage (MinIO configured)
7. **✅ S1-07**: Mobile app structure (Flutter clean architecture)
8. **✅ S1-08**: Backend dependencies installed (874 packages)
9. **✅ S1-09**: Mobile dependencies (sedang install)

---

## 🏃‍♂️ Cara Menjalankan Aplikasi

### 1️⃣ Start Infrastructure Services

**PENTING**: Pastikan Docker Desktop sudah berjalan!

```powershell
# Masuk ke folder root
cd "d:\0. Kerjaan\Ndesa\NDESA_Code"

# Start PostgreSQL, Redis, MinIO
docker-compose up -d

# Cek status services
docker-compose ps

# Lihat logs jika ada error
docker-compose logs postgres
docker-compose logs redis
docker-compose logs minio
```

**Services yang berjalan:**
- PostgreSQL: `localhost:5432` (user: ndesa_user, pass: ndesa_password)
- Redis: `localhost:6379`
- MinIO: `localhost:9000` (Console: `localhost:9001`, user: minioadmin, pass: minioadmin123)

---

### 2️⃣ Setup Backend (NestJS)

```powershell
# Masuk ke folder backend
cd backend

# File .env sudah dibuat, silakan review jika perlu
# notepad .env

# Install dependencies (sudah done: 874 packages)
# npm install

# Run database migrations (buat tables)
npm run migration:run

# Start backend server (development mode)
npm run dev
```

**Backend akan berjalan di:**
- API: `http://localhost:3000/v1`
- Swagger Docs: `http://localhost:3000/api/docs`

**Test API:**
1. Buka browser → `http://localhost:3000/api/docs`
2. Test endpoint `POST /auth/register`:
   ```json
   {
     "email": "test@example.com",
     "password": "password123",
     "phone": "+628123456789",
     "role": "talenta",
     "fullName": "Test User"
   }
   ```
3. Cek console backend untuk melihat OTP code
4. Verify OTP dengan endpoint `POST /auth/verify-otp`
5. Login dengan endpoint `POST /auth/login`

---

### 3️⃣ Setup Mobile (Flutter)

```powershell
# Masuk ke folder mobile
cd ..\mobile

# Install dependencies (sedang proses)
flutter pub get

# Generate Freezed models
flutter pub run build_runner build --delete-conflicting-outputs

# Run mobile app
flutter run
```

**Mobile Screens (Figma/Mobile/):**
- ✅ Start.png - Welcome screen
- ✅ Login.png - Login form
- ✅ Register.png - Registration
- ✅ Verification.png - OTP verification
- ✅ KTP.png - ID card upload
- ✅ Swafoto.png - Selfie verification
- ✅ Minat.png - Interest selection
- ✅ Home.png - Dashboard
- Dan 15+ screens lainnya

---

### 4️⃣ Setup Web Dashboard (Next.js) - COMING SOON

```powershell
# Masuk ke folder web
cd ..\web

# Initialize Next.js (belum dibuat)
npx create-next-app@latest . --typescript --tailwind --app --src-dir --import-alias "@/*"

# Install dependencies
npm install

# Start web dashboard
npm run dev
```

Web dashboard akan berjalan di: `http://localhost:3001`

---

## 🔍 Troubleshooting

### Docker Desktop Tidak Berjalan
```
Error: unable to get image 'postgres:15-alpine'
```
**Solusi**: 
1. Buka Docker Desktop
2. Tunggu sampai status "Docker Desktop is running"
3. Jalankan ulang `docker-compose up -d`

### Flutter Pub Get Gagal
```
Error: version solving failed
```
**Solusi**:
```powershell
flutter clean
flutter pub get
```

### Backend Port 3000 Sudah Digunakan
```
Error: listen EADDRINUSE: address already in use :::3000
```
**Solusi**:
```powershell
# Windows PowerShell
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### PostgreSQL Connection Error
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```
**Solusi**:
1. Cek Docker container: `docker-compose ps`
2. Restart PostgreSQL: `docker-compose restart postgres`
3. Cek logs: `docker-compose logs postgres`

---

## 📊 Database Schema

### Entities (5):
1. **tenants** - Multi-tenancy (kabupaten/kota)
2. **desas** - Village data
3. **users** - All users (6 roles: TALENTA, PEMDES_ADMIN, MITRA_ADMIN, DPMD, INSPEKTORAT, SUPER_ADMIN)
4. **talent_profiles** - Talent KYC data (NIK, KTP, selfie)
5. **otps** - OTP verification codes

### Relationships:
```
Tenant (1) --> (N) Desa
Desa (1) --> (N) User
User (1) --> (1) TalentProfile
User (1) --> (N) Otp
```

---

## 🔐 Authentication Flow

1. **Register** → `POST /auth/register`
   - Input: email, password, phone, role, fullName
   - Output: userId, OTP sent to phone/email
   - Status: User created with status PENDING

2. **Verify OTP** → `POST /auth/verify-otp`
   - Input: code (6 digits)
   - Output: success message
   - Effect: User status → ACTIVE

3. **Login** → `POST /auth/login`
   - Input: email, password
   - Output: accessToken (7d), refreshToken (30d)
   - Use token in header: `Authorization: Bearer <accessToken>`

4. **Protected Routes** → Requires JWT token
   - GET /users/me
   - GET /talents/profile
   - PATCH /talents/profile
   - POST /talents/upload-ktp
   - POST /talents/upload-selfie

---

## 🧪 Testing

### Backend Unit Tests
```powershell
cd backend
npm run test          # Run all tests
npm run test:watch    # Watch mode
npm run test:cov      # Coverage report
```

### Mobile Tests
```powershell
cd mobile
flutter test
```

### API Manual Testing
1. Swagger UI: `http://localhost:3000/api/docs`
2. Postman: Import OpenAPI spec dari Swagger
3. cURL commands dari terminal

---

## 📝 Next Steps (Sprint 2)

### Fitur yang Akan Dikembangkan:
1. **S2-01**: KYC Implementation
   - Upload KTP dengan validasi OCR
   - Selfie verification dengan liveness detection
   - Admin approval workflow

2. **S2-02**: Interest Selection
   - Multi-select interests dari master data
   - Save preferences ke talent_profiles

3. **S2-03**: Dashboard Implementation
   - Pemdes dashboard (village-level monitoring)
   - DPMD dashboard (district-level compliance)
   - Mitra dashboard (recruitment & placement)

4. **S2-04**: Job Marketplace
   - Job listing dengan filter/search
   - Save jobs functionality
   - Apply for jobs

---

## 🎨 Design System

### Colors (Figma):
- Primary: `#2563EB` (blue-600)
- Secondary: `#16A34A` (green-600)
- Success: `#16A34A`
- Warning: `#EAB308`
- Error: `#DC2626`

### Typography (Inter):
- H1: 36px / Bold
- H2: 30px / Semibold
- H3: 24px / Semibold
- Body: 16px / Regular
- Small: 14px / Regular

### Spacing (Tailwind):
- s1 = 4px
- s2 = 8px
- s3 = 12px
- s4 = 16px
- s6 = 24px
- s8 = 32px

---

## 🤝 Kontribusi

### Coding Standards:
- ✅ Always filter by `tenantId` in database queries
- ✅ Always validate user permissions (RBAC)
- ✅ Always validate inputs (DTO + schemas)
- ✅ Always use parameterized queries (SQL injection prevention)
- ✅ Always handle errors with try-catch
- ✅ Always write Indonesian error messages
- ✅ Always match Figma designs exactly

### Git Workflow:
```powershell
git checkout -b feature/S2-01-kyc-implementation
# Make changes
git add .
git commit -m "feat(kyc): implement KTP upload with OCR validation"
git push origin feature/S2-01-kyc-implementation
# Create Pull Request
```

---

## 📞 Support

Jika ada masalah:
1. Cek dokumentasi di `README.md`
2. Cek API spec di `docs/API_SPECIFICATION.md`
3. Cek data model di `docs/DATA_MODEL_ERD.md`
4. Cek sprint backlog di `docs/SPRINT_BACKLOG.md`
5. Lihat Figma designs di `Figma/Mobile/` dan `Figma/Website/`

---

**Status Sprint 1**: ✅ COMPLETED (9/9 tasks done)
**Status Sprint 2**: ⏳ READY TO START
**Last Updated**: 2026-01-03
