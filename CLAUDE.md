# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

**Build & Code Generation:**
- `flutter pub get` - Install dependencies
- `dart run build_runner build --delete-conflicting-outputs` - Generate code (DI, JSON serialization, Retrofit)
- `flutter gen-l10n` - Generate localization files
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app

**Running & Development:**
- `flutter run` - Run app in debug mode
- `flutter run --release` - Run in release mode
- `flutter run -d chrome` - Run in web browser
- `flutter clean` - Clean build cache

**Testing & Quality:**
- `flutter test` - Run all unit tests
- `flutter test test/path/to/test_file.dart` - Run specific test file
- `flutter test --name "test name"` - Run specific test by name
- `flutter analyze` - Run static analysis (uses flutter_lints)

## Architecture Overview

This is a Flutter expense tracker app following **Clean Architecture** with **BLoC** state management:

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

**Key Dependencies:**
- **State Management:** flutter_bloc, equatable
- **Networking:** dio, retrofit
- **DI:** get_it, injectable (requires code generation)
- **Serialization:** json_annotation, json_serializable (requires code generation)
- **Localization:** flutter_localizations (English/Indonesian)
- **Functional Programming:** fpdart

**Environment Setup:**
- Uses flutter_dotenv with config in `assets/env/.env`
- Localization files in `lib/l10n/` (app_en.arb, app_id.arb)

**New Page & Widget Setup:**
- Create localization id (Indonesian) and en (English) for every new text label
- If there any identic widget, create reusable widget
- Keep it clean and simple, don't over engineering
- Put every navigation in router.dart and create the enum for path

**Code Generation Note:**
After modifying models, DI modules, or API clients, run the build_runner command to regenerate necessary code.

## Feature Integration Guidelines

When adding new features, follow the established **Transaction Feature Pattern** for consistency:

**1. Data Layer Structure:**
- Create request models in `data/models/request/` with JSON serialization (`@JsonSerializable()`)
- Create response models in `data/models/response/` with JSON deserialization (`@JsonSerializable(createToJson: false)`)
- Add API endpoints to `data/datasources/remote/api_service.dart` using Retrofit annotations
- Create DTOs in `domain/dto/` to decouple UI from API models
- Implement use cases in `domain/usecases/` following single responsibility principle
- Update repository interfaces in `domain/repositories/` and implementations in `data/repositories/`

**2. BLoC State Management Pattern:**
- Create separate event, state, and bloc files in `presentation/pages/[feature]/bloc/`
- Use sealed classes for events and states with proper Equatable implementation
- Implement `StateData` class with copyWith method for state data management
- Follow naming convention: `[Feature]Event`, `[Feature]State`, `[Feature]Bloc`
- Use `@injectable` annotation and inject use cases via constructor
- Handle loading, success, and failure states for each operation (CRUD)

**3. UI Layer Structure:**
- Create main page in `presentation/pages/[feature]/`
- Extract reusable widgets to `presentation/widgets/[feature]/`
- Use BlocConsumer pattern: builder for UI, listener for side effects (navigation, snackbars, dialogs)
- Implement GetIt dependency injection for BLoC instances
- Follow established patterns for form validation, loading states, and error handling

**4. Localization Requirements:**
- Add all text strings to `lib/l10n/app_en.arb` and `lib/l10n/app_id.arb`
- Use `context.l10n.[key]` for accessing localized strings
- Include validation messages, button labels, and user feedback text

**5. Navigation & Routing:**
- Add new routes to `RouteName` enum in `app/router.dart`
- Include route in the `routes` map with proper argument handling
- Use named routes with `Navigator.pushNamed()` for consistency

**6. Error Handling Pattern:**
- Use `Either<Failure, T>` return type for all repository methods
- Handle failures in BLoC listener with `ErrorDialog.show(context, failure)`
- Show success feedback with green SnackBar messages
- Implement loading indicators during async operations

**7. API Integration:**
- Add endpoints to `ApiService` with proper HTTP methods and annotations
- Use consistent parameter naming (snake_case for API, camelCase for Dart)
- For list endpoints, consider pagination with `page`, `per_page`, `sort_by`, `sort_order` parameters when needed
- Implement proper request/response mapping between API and domain models

**8. UI Component Patterns:**
- Use existing common widgets: `GlobalButton`, `GlobalTextFormField`, `GlobalDropdownFormField`
- Follow Material Design with established theme colors and dimensions
- Implement refresh-to-reload with `RefreshIndicator` for data lists
- Add infinite scrolling for paginated list views with `NotificationListener<ScrollNotification>`
- Use modal bottom sheets for detail views and forms

**Code Generation Reminders:**
- Run `dart run build_runner build --delete-conflicting-outputs` after adding/modifying:
  - JSON serializable models
  - Injectable dependencies
  - Retrofit API endpoints
