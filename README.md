# Automated Trucking Management Platform

A functional Flutter prototype for creating and tracking trucking loads. This repository is part of a BS Software Engineering Final Year Project focused on improving coordination among truck owners, drivers, customers, and logistics managers in Pakistan.

## Current Status

The repository now contains one complete, demonstrable workflow:

1. A user opens the load-creation form.
2. Required fields and weight are validated.
3. The load is serialized and stored locally on the device.
4. Saved loads are retrieved when the app starts.
5. The dashboard displays the latest loads and live counts.

This is still a prototype. It does not yet include accounts, a remote backend, multi-user synchronization, payments, maps, or notifications.

## Implemented Features

- Working Flutter application entry point
- Responsive Material dashboard
- Create-load form for pickup, delivery, cargo, and weight
- Required-field and positive-weight validation
- Local persistence using `shared_preferences`
- Automatic retrieval after an app restart
- Latest-load cards with route, cargo, weight, date, and status
- Dashboard counts derived from stored data
- Pull-to-refresh and storage error states
- Widget tests covering creation, retrieval, display, and validation

## Technology

- Flutter
- Dart
- Material Design
- `shared_preferences`
- `flutter_test`

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
- A configured Flutter development environment

### Steps

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

Loads are stored as JSON strings in the app's local preferences. This makes the workflow persistent on one device and suitable for demonstrating the prototype without a server.

Local preferences are not an appropriate final database for a multi-user logistics platform. A future version should place the `LoadStore` interface behind an authenticated remote API while retaining a local cache for offline use.

## Planned Work

- Authentication and role-based access
- Remote REST API and database
- Customer, driver, and administrator workflows
- Load assignment and status transitions
- Location tracking and route visualization
- Payment and notification integrations
- Integration and backend tests
- Deployment configuration

Planned items are not presented as implemented features.

## Academic Context

Final Year Project, BS Software Engineering, The Superior University, Lahore.

## Author

Khubaib Razi
