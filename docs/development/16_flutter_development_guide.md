# DeadHour - Flutter Development Guide

**Document Purpose**: This document is the canonical guide for developers working on the DeadHour Flutter application. It provides setup instructions, coding standards, architectural patterns, and deployment procedures, all aligned with the **dual-problem platform** vision.

**Last Updated**: July 25, 2025

---

## 1. 🛠️ Development Environment Setup

### Prerequisites
- **Flutter SDK**: 3.16.0 or higher
- **Dart SDK**: 3.2.0 or higher
- **IDE**: Android Studio or VS Code (with Flutter and Dart plugins)
- **Platform Tools**: Android SDK, Xcode (for iOS development)

### Initial Setup
1.  **Clone the Repository**
    ```bash
    git clone <repository-url>
    cd deadhour
    ```
2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```
3.  **Configure Firebase (for MVP)**
    ```bash
    flutterfire configure
    ```
4.  **Verify Installation**
    ```bash
    flutter doctor
    ```

---

## 2. 🏗️ Project Architecture

The project follows a clean, modular architecture designed to support the dual-problem platform's complexity and the multi-role account system.

### Directory Structure
```
lib/
├── main.dart                    # Application entry point
├── app.dart                     # App configuration and theme
├── routes/                      # Navigation configuration (GoRouter)
│   └── app_routes.dart
├── features/                    # Feature-based modules
│   ├── auth/                    # Authentication & Role Selection
│   ├── home/                    # Home feed & Discovery
│   ├── community/               # Community Rooms & Social Features
│   ├── business/                # Business Role Dashboard & Tools
│   └── profile/                 # User Profile & Role Management
├── widgets/                     # Reusable UI components
│   └── common/
├── models/                      # Data models (User, Venue, Deal, Room, etc.)
├── services/                    # API service integrations
├── providers/                   # State management (Provider)
└── utils/                       # Utilities, constants, and theme
```

### Architecture Patterns

-   **State Management**: The app uses the **Provider** pattern for state management, ensuring a clear separation of UI and business logic.
-   **Navigation**: We use **GoRouter** for declarative, URL-based navigation, which supports deep linking and role-based routing.
-   **Service Layer**: A dedicated service layer handles all API communication, abstracting the data source from the UI.

---

## 3. 🎨 Design System & UI

The app's design system is inspired by Moroccan aesthetics and is built to be culturally aware and accessible.

### Theme Configuration (`lib/utils/theme.dart`)
-   **Primary Colors**: The theme uses Morocco's flag colors (green, red) and a gold accent to create a distinct brand identity.
-   **Typography**: The typography is optimized for readability in Arabic (RTL), French, and English.
-   **Cultural Integration**: The theme includes considerations for prayer times, Ramadan mode, and other cultural events.

### Custom Components
-   All reusable UI components are located in `lib/widgets/common/`.
-   Components like `DealCard` and `VenueCard` are designed to display both business information and social validation (e.g., community recommendations).

---

## 4. 🔧 Development Workflow & Standards

### Code Standards
-   **Dart Style**: Strictly follow the official Dart style guide (`dart format .`).
-   **Naming Conventions**: `UpperCamelCase` for classes, `lowerCamelCase` for variables/functions, `snake_case` for files.
-   **Widget Organization**: Build methods should be clean and delegate complex UI sections to private `_build...` helper methods.

### Testing Strategy
-   **Unit Tests**: All business logic (services, providers, models) must have unit tests.
-   **Widget Tests**: All reusable widgets and screens should have widget tests to verify UI and interactions.
-   **Integration Tests**: End-to-end user flows for critical paths (e.g., booking a deal through a community room) must have integration tests.
-   **Goal**: Achieve and maintain >80% test coverage.

### Pull Request (PR) Process
1.  Create a feature branch from `develop` (e.g., `feature/business-dashboard`).
2.  Ensure all code is formatted and all tests pass locally.
3.  Submit a PR with a clear description of the changes and link any related issues.
4.  Require at least one code review approval before merging.

---

## 5. 🌐 API Integration

-   All API communication is handled through the `lib/services/` layer.
-   The API specification is detailed in `docs/development/17_api_documentation.md`.
-   Use the provided `ApiException` class for consistent error handling.

---

## 6. 📱 Platform-Specific Configurations

### Android (`android/app/src/main/AndroidManifest.xml`)
-   Ensure `INTERNET` and `ACCESS_FINE_LOCATION` permissions are present.

### iOS (`ios/Runner/Info.plist`)
-   Provide usage descriptions for location services (e.g., `NSLocationWhenInUseUsageDescription`).

---

## 7. 🔍 Technical Gaps & Roadmap

This section addresses the critical gaps identified in the `MISSING_ELEMENTS_COMPREHENSIVE_REPORT.md` and outlines the development priorities.

### Phase 1: Critical Blockers (Current Focus)
1.  **Implement Full Testing Framework**: Achieve >80% coverage.
2.  **Integrate Real Backend**: Replace all mock data from `lib/utils/mock_data.dart` with live API calls to the Firebase/Django backend.
3.  **Implement Security**: Integrate Firebase Auth, manage user sessions, and secure API endpoints.
4.  **Legal Compliance**: Ensure the app includes links to the Terms of Service and Privacy Policy.

### Phase 2: Core Features
1.  **Payment Systems**: Integrate a payment gateway to handle commissions and subscriptions.
2.  **Real-time Features**: Implement WebSocket or other real-time solutions for the community chat features.

This guide will be updated as the project evolves. Please refer to the main project `README.md` and the `DeadHour_UNIFIED_VISION.md` for the overall project strategy.
