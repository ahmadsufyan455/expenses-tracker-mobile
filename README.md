# Expense Tracker Mobile

A Flutter expense tracking application built with Clean Architecture and BLoC state management pattern.

## Features

- Track income and expenses
- Budget management
- Transaction categorization
- Multi-language support (English/Indonesian)
- Clean and intuitive user interface
- Dark/Light theme support

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

- **Framework:** Flutter
- **State Management:** flutter_bloc, equatable
- **Networking:** dio, retrofit
- **Dependency Injection:** get_it, injectable
- **Serialization:** json_annotation, json_serializable
- **Localization:** flutter_localizations
- **Functional Programming:** fpdart
- **Environment Configuration:** flutter_dotenv

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
   - Create `assets/env/.env` file with your configuration

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
- **Models:** JSON serializable data models
- **Datasources:** API clients using Retrofit
- **Repositories:** Data repository implementations

### Domain Layer
- **DTOs:** Data transfer objects
- **Use Cases:** Business logic operations
- **Repository Interfaces:** Abstract repository contracts

### Presentation Layer
- **Pages:** Screen components with BLoC integration
- **Widgets:** Reusable UI components
- **BLoC:** State management with events and states

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
