# Backend (Node.js/Express)

## Overview
- REST API for SetoBaghApp
- Connects to SQL Server
- Handles authentication, visits, orders, payments, outlets, products

## Setup
```sh
npm install
npm start
```
- Edit `db.js` for your SQL Server credentials if needed.

## Endpoints
- `POST /api/auth/login` - Login
- `GET /api/staff/profile` - Staff profile (JWT required)
- `GET /api/staff/outlets` - Assigned outlets
- `GET /api/products` - Product list
- `POST /api/visits/checkin` - Check-in with GPS/photo
- `POST /api/orders` - Create order
- `POST /api/payments` - Record payment
- `GET /api/dashboard` - Staff dashboard summary

## Troubleshooting
- If you see DB connection errors, check your SQL Server is running and credentials are correct.
- If mobile app can't connect, check your PC firewall and API URL in the app. 