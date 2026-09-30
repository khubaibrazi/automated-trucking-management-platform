# Automated Trucking Management Platform

A functional Flutter prototype developed as a BS Software Engineering Final Year Project at The Superior University, Lahore.

The project explores how trucking loads can be created, validated, stored, retrieved, and presented through a structured mobile workflow.

## Why This Project

The idea was influenced by practical exposure to logistics operations and shipment workflows. The goal is to translate part of that real-world process into a clearer digital experience.

## Current Working Workflow

The repository contains one complete, demonstrable workflow:

1. A user opens the load-creation form.
2. Pickup, delivery, cargo, and weight details are entered.
3. Required fields and positive weight are validated.
4. The load is serialized and stored locally.
5. Saved loads are retrieved after application restart.
6. The dashboard displays recent loads and live counts.

## Implemented Features

- Working Flutter application entry point
- Responsive Material dashboard
- Create-load form
- Required-field validation
- Positive-weight validation
- Local persistence with `shared_preferences`
- Automatic retrieval after restart
- Latest-load cards with route, cargo, weight, date, and status
- Dashboard counts derived from stored data
- Pull-to-refresh behaviour
- Storage error states
- Widget tests covering creation, validation, retrieval, and display

## Technology

- Flutter
- Dart
- Material Design
- `shared_preferences`
- `flutter_test`

## Current Architecture

```text
User
  ↓
Create Load
  ↓
Validation
  ↓
Serialization
  ↓
Local Storage
  ↓
Retrieval
  ↓
Dashboard
```

## Project Structure

```text
Automated_Trucking_management_System/
├── lib/
│   ├── data/
│   │   └── load_store.dart
│   ├── models/
│   │   └── truck_load.dart
│   └── main.dart
├── test/
│   └── widget_test.dart
└── pubspec.yaml
```

## Run Locally

### Prerequisites

- Flutter SDK compatible with Dart SDK `^3.5.2`
- Configured Flutter development environment

### Setup

```bash
git clone https://github.com/khubaibrazi/automated-trucking-management-platform.git
cd automated-trucking-management-platform/Automated_Trucking_management_System
flutter pub get
flutter run
```

## Run Tests

```bash
flutter test
```

## Data Storage

Loads are currently stored as JSON strings in local preferences. This makes the prototype persistent on one device and suitable for demonstrating the working flow without requiring a remote server.

## Project Status

This repository is a **working prototype**, not a finished multi-user production platform.

The following are not currently implemented in this repository:

- Authentication
- Remote backend
- Multi-user synchronization
- Live location tracking
- Payments
- Notifications

## Future Direction

A future version could extend the current storage interface with:

- Authentication and role-based access
- Remote REST API and database
- Customer, driver, and administrator workflows
- Load assignment and status transitions
- Location tracking and route visualization
- Payment and notification integrations
- Integration and backend tests
- Deployment configuration

## Academic Context

Final Year Project  
BS Software Engineering  
The Superior University, Lahore

## Author

**Khubaib Razi**

- GitHub: https://github.com/khubaibrazi
