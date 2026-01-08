# NDESA - Platform GovTech Hybrid

## 🎯 About
NDESA adalah platform GovTech hybrid yang menggabungkan:
- **Compliance-as-a-Service (CaaS)** untuk manajemen Dana Desa
- **Creative Talent Hub** untuk pengembangan SDM desa

## 📁 Monorepo Structure

```
NDESA_Code/
├── backend/          # NestJS API Server
├── mobile/           # Flutter Mobile App
├── web/              # Next.js Web Dashboard
├── .github/          # CI/CD Workflows
└── docker-compose.yml
```

## 🚀 Quick Start

### Prerequisites
- Node.js 20+
- Flutter 3.16+
- PostgreSQL 15+
- Redis 7+
- Docker (optional)

### Setup All Services

```bash
# Clone repository
git clone <repo-url>
cd NDESA_Code

# Setup backend
cd backend
npm install
cp .env.example .env
npm run migration:run
npm run dev

# Setup mobile
cd ../mobile
flutter pub get
flutter run

# Setup web
cd ../web
npm install
cp .env.local.example .env.local
npm run dev
```

## 📖 Documentation
- [Sprint Backlog](../docs/SPRINT_BACKLOG.md)
- [API Specification](../docs/API_SPECIFICATION.md)
- [Data Model](../docs/DATA_MODEL_ERD.md)
- [Design Guidelines](../docs/DESIGN_GUIDELINES.md)

## 🎨 Design System
All designs available in `../Figma/`:
- Mobile: `../Figma/Mobile/` (20+ screens)
- Website: `../Figma/Website/` (dashboard designs)

## 👥 Team
- Product Owner: [Name]
- Tech Lead: [Name]
- Backend Developer: [Name]
- Mobile Developer: [Name]
- Frontend Developer: [Name]

## 📝 License
Proprietary - NDESA Team © 2026
