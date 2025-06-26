# SetoBaghApp - Complete Setup Guide

## 🚀 Overview

SetoBaghApp is a comprehensive sales agent management system with:
- **Flutter Mobile App** with GPS tracking and photo capture
- **React Web Dashboard** for management
- **Node.js/Express Backend** with SQL Server database
- **Real-time visit logging** with location verification
- **Sales order management** and payment tracking

## 📋 Prerequisites

### Required Software
1. **Node.js** (v16 or higher) - [Download](https://nodejs.org/)
2. **Flutter** (v3.8 or higher) - [Download](https://flutter.dev/)
3. **SQL Server** (2019 or higher) - [Download](https://www.microsoft.com/en-us/sql-server/)
4. **Git** - [Download](https://git-scm.com/)

### System Requirements
- Windows 10/11
- 8GB RAM minimum
- 10GB free disk space
- Internet connection for dependencies

## 🗄️ Database Setup

### Step 1: Create Database
Run these SQL scripts in order:

```sql
-- 1. Create database
backend/mobile/SQL STUFF/TABLES/00_CREATE_DATABASE.sql

-- 2. Create schema tables
backend/mobile/SQL STUFF/TABLES/ZONE_ROUTE_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/STAFF_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/OUTLET_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/PRODUCT_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/VISITLOG_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/PAYMENT_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/ATTENDANCE_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/TARGET_SCHEMA.sql
backend/mobile/SQL STUFF/TABLES/DEVICELOG_SCHEMA.sql
```

### Step 2: Insert Sample Data
Run these insert scripts in order:

```sql
-- 1. Insert zones and routes
backend/mobile/SQL STUFF/INSERT/Insert Zone and route.sql

-- 2. Insert staff
backend/mobile/SQL STUFF/INSERT/Insert Staff.sql

-- 3. Insert products
backend/mobile/SQL STUFF/INSERT/Insert Product.sql

-- 4. Insert outlets (after fixing CSV)
backend/mobile/SQL STUFF/INSERT/Insert Outlet.sql
```

## 🔧 Backend Setup

### Step 1: Install Dependencies
```bash
cd backend
npm install
```

### Step 2: Configure Database
Edit `backend/index.js` and update the database password:
```javascript
const dbConfig = {
    server: 'localhost',
    database: 'SetoBaghApp',
    user: 'sa',
    password: 'your_password_here', // ← Update this
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};
```

### Step 3: Start Backend Server
```bash
cd backend
npm start
```

The backend will run on `http://localhost:3000`

## 📱 Flutter App Setup

### Step 1: Install Dependencies
```bash
cd backend/mobile
flutter pub get
```

### Step 2: Configure API URL
Edit `backend/mobile/lib/services/api_service.dart` and update the baseUrl:

```dart
// For different platforms:
static const String baseUrl = 'http://localhost:3000/api';  // Windows/Web
// static const String baseUrl = 'http://10.0.2.2:3000/api';  // Android Emulator
// static const String baseUrl = 'http://YOUR_PC_IP:3000/api';  // Physical Device
```

### Step 3: Run Flutter App
```bash
cd backend/mobile
flutter run
```

## 🧪 Testing the App

### Login Credentials
Use any staff mobile number as both username and password:

**Test Staff Members:**
- **Nimesh Subedi**: `9847287536` / `9847287536`
- **Shree Krishna Neupane**: `9865064166` / `9865064166`
- **Suman Neupane**: `9865064167` / `9865064167`

### Features to Test

#### 1. **Authentication**
- Login with staff mobile number
- Verify staff profile loads correctly

#### 2. **GPS Tracking**
- Allow location permissions
- Check current GPS coordinates
- Verify distance calculation

#### 3. **Photo Capture**
- Take photos during visits
- Verify photo upload to server
- Check photo storage in uploads/photos/

#### 4. **Visit Logging**
- Select an outlet
- Check-in with GPS and photo
- Verify visit data in database

#### 5. **Dashboard**
- View today's statistics
- Check visit history
- Monitor sales data

## 🔍 Troubleshooting

### Common Issues

#### 1. **Database Connection Error**
```
Error: Login failed for user 'sa'
```
**Solution:** Check SQL Server password in `backend/index.js`

#### 2. **Flutter Dependencies Error**
```
Error: Could not find a file named "pubspec.yaml"
```
**Solution:** Run `flutter pub get` in the mobile directory

#### 3. **API Connection Error**
```
Error: Connection refused
```
**Solution:** 
- Ensure backend is running on port 3000
- Check firewall settings
- Update API URL for your platform

#### 4. **GPS Not Working**
```
Error: Location services are disabled
```
**Solution:**
- Enable location services on device
- Grant location permissions to app
- Check device GPS settings

#### 5. **Photo Upload Fails**
```
Error: File upload failed
```
**Solution:**
- Check uploads/photos/ directory exists
- Verify file permissions
- Check file size (max 10MB)

### Debug Commands

#### Check Backend Status
```bash
curl http://localhost:3000/api/staff/profile
```

#### Check Database Connection
```bash
cd backend
node test-db.js
```

#### Check Flutter Dependencies
```bash
cd backend/mobile
flutter doctor
flutter pub deps
```

## 📊 API Endpoints

### Authentication
- `POST /api/auth/login` - Staff login
- `GET /api/staff/profile` - Get staff profile

### Outlets
- `GET /api/staff/outlets` - Get assigned outlets
- `GET /api/outlets` - Get all outlets
- `GET /api/outlets/:id` - Get outlet details

### Visits
- `POST /api/visits/checkin` - Check-in to outlet
- `POST /api/visits/checkout` - Check-out from outlet
- `GET /api/visits/history` - Get visit history

### Orders
- `POST /api/orders` - Create sales order
- `GET /api/orders` - Get staff orders

### Payments
- `POST /api/payments` - Record payment

### Dashboard
- `GET /api/dashboard` - Get dashboard data

## 🎯 Features Overview

### Mobile App Features
- ✅ **User Authentication** with JWT tokens
- ✅ **GPS Location Tracking** with distance calculation
- ✅ **Photo Capture** during visits
- ✅ **Visit Logging** (Check-in/Check-out)
- ✅ **Outlet Management** with assigned routes
- ✅ **Sales Order Creation** with product selection
- ✅ **Payment Recording** with multiple methods
- ✅ **Dashboard Analytics** with real-time data
- ✅ **Staff Profile Management**
- ✅ **Offline Data Storage** (planned)

### Backend Features
- ✅ **RESTful API** with JWT authentication
- ✅ **File Upload** for visit photos
- ✅ **GPS Validation** with distance calculation
- ✅ **Database Management** with SQL Server
- ✅ **Data Validation** and error handling
- ✅ **Automatic Cleanup** of duplicate records
- ✅ **Audit Logging** for all activities

### Database Features
- ✅ **Master Data Management** (Zones, Routes, Staff, Products, Outlets)
- ✅ **Transaction Logging** (Visits, Orders, Payments)
- ✅ **Foreign Key Relationships** for data integrity
- ✅ **Indexed Queries** for performance
- ✅ **Stored Procedures** for complex operations
- ✅ **Data Validation** constraints

## 🚀 Production Deployment

### Backend Deployment
1. Set up production SQL Server
2. Configure environment variables
3. Set up reverse proxy (nginx)
4. Configure SSL certificates
5. Set up monitoring and logging

### Mobile App Deployment
1. Configure production API URLs
2. Build release APK/IPA
3. Sign the application
4. Upload to app stores
5. Configure crash reporting

### Database Migration
1. Backup development database
2. Restore to production server
3. Update connection strings
4. Test all functionality
5. Monitor performance

## 📞 Support

### Getting Help
1. Check the troubleshooting section above
2. Review error logs in console
3. Verify all prerequisites are installed
4. Test with sample data first
5. Contact development team

### Useful Commands
```bash
# Check Node.js version
node --version

# Check Flutter version
flutter --version

# Check SQL Server connection
sqlcmd -S localhost -U sa -P your_password

# Check if ports are in use
netstat -an | findstr :3000
```

---

**🎉 Congratulations! Your SetoBaghApp is now ready for testing and development!** 