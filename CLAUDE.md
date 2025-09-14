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
- `flutter test` - Run unit tests
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
