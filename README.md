# SetoBaghApp - Sales Agent Management System

A cross-platform sales agent management system with:
- **Flutter mobile app** for field agents
- **Node.js/Express backend** with SQL Server
- **React dashboard** (planned)

---

## Project Architecture
```
setobaghapp/
├── backend/        # Node.js API server
│   ├── index.js    # Main server
│   ├── db.js       # DB connection
│   └── mobile/     # Flutter app
├── dashboard/      # React dashboard (future)
└── README.md       # Project overview
```

---

## What's Implemented
- **Backend API:**
  - Auth, visit logging, orders, payments, outlets, products
  - Connects to SQL Server
- **Mobile App:**
  - Login, dashboard, GPS check-in, photo upload, order/payment
  - Works with real backend or mock data fallback
- **Database:**
  - All schemas and sample data for staff, outlets, products, visits, orders

---

## How to Run

### 1. Database
- Run SQL scripts in backend/mobile/SQL STUFF/ in order:
  1. 00_CREATE_DATABASE.sql
  2. ZONE_ROUTE_SCHEMA.sql
  3. STAFF_SCHEMA.sql
  4. OUTLET_SCHEMA.sql
  5. PRODUCT_SCHEMA.sql
  6. VISITLOG_SCHEMA.sql

### 2. Backend
```sh
cd backend
npm install
npm start
```
- Make sure your SQL Server is running and accessible.

### 3. Mobile App
```sh
cd backend/mobile
flutter pub get
# Update lib/services/api_service.dart with your PC's IP
flutter build apk --release
# Install APK on your phone
```

---

## Current Status
- [x] Backend API: All endpoints working
- [x] Mobile app: All core features working
- [x] Database: All schemas and sample data ready
- [ ] Dashboard: Not started
- [ ] Production deployment: Not started

---

## Next Steps / Roadmap
- [ ] Build and launch the React dashboard for admin/manager use
- [ ] Add advanced reporting and analytics
- [ ] Implement push notifications for field agents
- [ ] Add offline data sync for mobile app
- [ ] Harden security (passwords, JWT expiry, etc.)
- [ ] Prepare for production deployment (cloud, Docker, etc.)

---

## Handoff Notes
- All code is optimized and cleaned up
- README files in each folder explain local setup
- Ask any chatbot or developer for help with next steps using this README! 