# 🚛 Automated Trucking Management Platform

A digital platform designed to modernize Pakistan's trucking and logistics industry by connecting truck owners, drivers, and customers through a single, automated system — from shipment booking to real-time job tracking and secure payments.

> **Final Year Project (FYP)** — BS Software Engineering, Session 2021–2025
> Department of Software Engineering, Faculty of Computer Science & Information Technology
> The Superior University, Lahore

---

## 📌 Overview

Pakistan's trucking sector is largely manual, with no centralized system to manage bookings, job assignments, or vehicle tracking. This leads to inefficient communication, poor job tracking, and fragmented coordination between truck owners, drivers, and customers.

**Automated Trucking Management Platform** solves this by providing:
- A **mobile app** (Flutter) for customers and drivers
- A **web dashboard** for administrators and logistics managers, inspired by Jira-style task management
- End-to-end automation: booking → job assignment → real-time tracking → payment

## ✨ Key Features

| Feature | Description |
|---|---|
| 🔐 **User Authentication** | Secure registration & login with JWT-based session management |
| 📦 **Shipment Booking** | Customers create orders with pickup/delivery location, cargo type & cost estimation |
| 💳 **Payment Processing** | Integrated with **EasyPaisa** & **JazzCash** for secure local payments |
| 📍 **Real-Time Tracking** | Live shipment location & status updates via Google Maps API |
| 🔔 **Notifications & Alerts** | SMS (Twilio) and in-app alerts for order, payment & delivery status |
| 🗂️ **Job Management Dashboard** | Jira-like task board for admins to assign, monitor, and manage jobs |

## 🛠️ Tech Stack

**Frontend (Mobile App)**
- [Flutter](https://flutter.dev/) & Dart
- `provider` — state management
- `http` — REST API communication
- `flutter_local_notifications` — local alerts

**Backend**
- [Node.js](https://nodejs.org/) + [Express.js](https://expressjs.com/) — REST API
- [MongoDB](https://www.mongodb.com/) + Mongoose — database & ODM
- `jsonwebtoken` — authentication

**Third-Party Integrations**
- EasyPaisa / JazzCash — payment gateways
- Twilio — SMS notifications
- Google Maps API — geolocation & route tracking

**DevOps & Tooling**
- Git & GitHub — version control
- Docker — containerization
- AWS EC2 / MongoDB Atlas — hosting & database
- Postman & Jest — API testing

## 📂 Project Structure

```
automated-trucking-management-platform/
└── Automated_Trucking_management_System/
    ├── (Flutter app — mobile frontend)
    └── (Node.js backend — REST API)
```

> *Structure to be refined as the repo grows — frontend and backend currently live in a single project folder.*

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Node.js](https://nodejs.org/) (LTS recommended)
- [MongoDB](https://www.mongodb.com/try/download/community) (local or Atlas connection)

### Backend Setup
```bash
cd backend
npm install
# create a .env file with your MongoDB URI, JWT secret, and payment/API keys
npm start
```

### Frontend Setup
```bash
cd mobile_app
flutter pub get
flutter run
```

## 👥 Team

| Name | Reg. # | Role |
|---|---|---|
| Khubaib Razi | BSEM-F21-080 | Group Leader |
| Abdul Rehman Butt | BSEM-F21-067 | Member |

**Supervisor:** Mr. Munib Ahmed, Senior Lecturer
**FYP ID:** BSSE-FYP-F24-037

## 📄 Documentation

Full project documentation — including SRS, use case analysis, system design diagrams (architecture, ERD, class, sequence, activity, deployment), and testing strategy — is available in the FYP report.

## 🔮 Future Enhancements

- Driver-side mobile app improvements
- Advanced analytics dashboard for logistics managers
- Multi-language support (Urdu/English)
- Route optimization using historical traffic data

---

*Final Year Project — Spring 2025*
