# Expense Tracker Mobile

A Flutter expense tracking application built with Clean Architecture and BLoC state management pattern.

## Features

### 📊 Dashboard & Analytics
- Real-time financial overview with income, expenses, and balance tracking
- Visual expense breakdown with interactive pie charts
- Monthly financial trends and insights
- Quick access to recent transactions

### 💰 Transaction Management
- Create, read, update, and delete transactions
- Support for both income and expense tracking
- Transaction categorization
- Date-based filtering and sorting
- Transaction history with detailed views

### 🏷️ Category Management
- Create custom categories for organizing transactions
- Update and delete categories
- Color-coded category system
- Category-based expense analysis

### 💳 Budget Planning
- Set monthly budgets by category
- Real-time budget tracking and progress monitoring
- Budget vs actual spending comparison
- Budget alerts and notifications
- Create, update, and delete budgets

### 👤 User Profile & Authentication
- Secure user registration and login
- Profile management (view and edit)
- Password change functionality
- Account deletion option
- Session persistence with token management

### 🌍 Localization & Accessibility
- Multi-language support (English/Indonesian)
- Localized date and currency formatting
- RTL support ready
- Clean and intuitive user interface

### 🔧 Technical Features
- Offline-first architecture with local caching
- Error logging and monitoring with Sentry
- Network request/response logging for debugging
- Smooth animations and transitions
- Pull-to-refresh functionality

## Architecture

This project follows **Clean Architecture** principles with **BLoC** state management:

```
lib/
├── app/                    # App configuration (routing, theme)
├── core/                   # Core utilities and DI
│   ├── di/                # Dependency injection (GetIt + Injectable)
│   ├── utils/             # Utilities (validation, localization)
│   ├── extensions/        # Dart extensions
│   └── errors/            # Error handling
├── data/                   # Data layer
│   ├── datasources/       # Local & remote data sources (Retrofit APIs)
│   ├── repositories/      # Repository implementations
│   └── models/            # Data models (JSON serializable)
├── domain/                 # Business logic layer
│   ├── dto/               # Data transfer objects
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business use cases
└── presentation/          # UI layer
    ├── pages/             # Screen components with BLoC
    └── widgets/           # Reusable UI components
```

## Tech Stack

- **Framework:** Flutter 3.8.1+
- **State Management:** flutter_bloc, equatable
- **Networking:** dio, retrofit
- **Dependency Injection:** get_it, injectable
- **Serialization:** json_annotation, json_serializable
- **Localization:** flutter_localizations, intl
- **Functional Programming:** fpdart
- **Charts & Visualization:** fl_chart
- **Error Monitoring:** sentry_flutter
- **Local Storage:** shared_preferences
- **Environment Configuration:** flutter_dotenv
- **Development Tools:**
  - network_logger for API debugging
  - build_runner for code generation
  - flutter_lints for code quality

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- iOS development tools (for iOS builds)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd expense_tracker_mobile
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code (DI, JSON serialization, API clients):
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Generate localization files:
```bash
flutter gen-l10n
```

5. Set up environment configuration:
   - Create `assets/env/.env` file with the following variables:
     ```
     BASE_URL=<your_api_base_url>
     SENTRY_DSN=<your_sentry_dsn>
     ```

### Running the App

```bash
# Debug mode
flutter run

# Release mode
flutter run --release

# Web browser
flutter run -d chrome
```

### Development Commands

**Build & Code Generation:**
```bash
flutter pub get                                              # Install dependencies
dart run build_runner build --delete-conflicting-outputs    # Generate code
flutter gen-l10n                                           # Generate localization
flutter build apk                                          # Build Android APK
flutter build ios                                          # Build iOS app
```

**Testing & Quality:**
```bash
flutter test                              # Run all tests
flutter test test/path/to/test_file.dart  # Run specific test
flutter analyze                           # Static analysis
```

**Utility:**
```bash
flutter clean  # Clean build cache
```

## Project Structure

### Data Layer
- **Models:** JSON serializable request/response models
- **Datasources:**
  - Remote: API clients using Retrofit
  - Local: SharedPreferences for caching and session management
- **Repositories:** Data repository implementations with error handling

### Domain Layer
- **DTOs:** Data transfer objects for UI layer
- **Use Cases:** Business logic operations (19+ use cases)
  - Authentication: Login, Register
  - Transactions: CRUD operations, filtering
  - Categories: CRUD operations
  - Budgets: CRUD operations
  - Profile: View, Update, Change Password, Delete Account
  - Dashboard: Financial overview and analytics
- **Repository Interfaces:** Abstract repository contracts

### Presentation Layer
- **Pages:**
  - Auth: Splash, Login, Register
  - Home: Dashboard with analytics
  - Transactions: List, Add/Edit Transaction
  - Categories: Category management
  - Budgets: Budget planning and tracking
  - Profile: User profile and settings
- **Widgets:** Reusable UI components
  - Global components (buttons, forms, dialogs)
  - Feature-specific widgets (charts, cards, headers)
- **BLoC:** State management with events, states, and bloc classes

## Localization

The app supports multiple languages:
- English (en)
- Indonesian (id)

Localization files are located in `lib/l10n/`:
- `app_en.arb` - English translations
- `app_id.arb` - Indonesian translations

## Contributing

When adding new features, follow the established patterns:

1. **Data Layer:** Create request/response models with JSON serialization
2. **Domain Layer:** Implement use cases and DTOs
3. **Presentation Layer:** Create BLoC with proper state management
4. **Localization:** Add text strings to both language files
5. **Code Generation:** Run build_runner after model changes

## Code Generation

After modifying the following, run the build_runner command:
- JSON serializable models
- Injectable dependencies
- Retrofit API endpoints

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Main Features
- **Dashboard:** Financial overview with balance, income, and expense tracking
- **Transactions:** Complete transaction history with add/edit capabilities
- **Categories:** Custom category management with color coding
- **Budgets:** Budget planning with progress tracking
- **Profile:** User settings and account management

## API Integration

The app integrates with a RESTful API for data persistence and synchronization. Key endpoints include:

- **Authentication:** `/auth/login`, `/auth/register`
- **Transactions:** `/transactions` (CRUD operations)
- **Categories:** `/categories` (CRUD operations)
- **Budgets:** `/budgets` (CRUD operations)
- **Profile:** `/profile` (view, update, change password, delete)
- **Dashboard:** `/dashboard` (analytics and insights)

API base URL is configured via environment variables in `assets/env/.env`.

## Error Handling & Monitoring

- **Sentry Integration:** Real-time error tracking and crash reporting
- **Network Logging:** Development-mode API request/response logging
- **User Feedback:** Friendly error dialogs with localized messages
- **Offline Support:** Graceful handling of network failures

## Security

- **Token-based Authentication:** JWT tokens stored securely
- **Secure Storage:** Sensitive data encrypted in SharedPreferences
- **API Security:** All requests authenticated with bearer tokens
- **Input Validation:** Form validation on all user inputs
