# Flutter Clean Architecture Template

A production-ready, highly scalable starter template for Flutter applications built following the principles of **Clean Architecture**, **Feature-First Presentation**, **Typed Error Handling & Result Pattern**, **GoRouter Routing**, **ScreenUtil Responsiveness**, and **BLoC / Cubit State Management**.

---

## 🏗️ Architecture Overview

```
lib/
├── main.dart                     # Main entry point with EasyLocalization & initializeDependencies
├── main_app.dart                 # Root App widget with MaterialApp.router, AppTheme, & Root Session Expiry Listener
├── gen/                          # Generated assets (flutter_gen)
└── src/
    ├── core/
    │   ├── components/           # Core UI components (CustomDialog, etc.)
    │   ├── constants/            # App constants (AppPaddings, AppSpaces, AppIconSizes, ApiConstants, CacheKeys, AppDurations)
    │   ├── di/                   # Modularized Dependency Injection (GetIt)
    │   │   ├── cubits.dart
    │   │   ├── data_sources.dart
    │   │   ├── dependency_injection.dart
    │   │   ├── managers.dart
    │   │   ├── network.dart
    │   │   ├── repositories.dart
    │   │   └── use_cases.dart
    │   ├── enums/                # Central Enums (ApiEndpoint, Status, SplashTarget, SnackBarType, etc.)
    │   ├── exceptions/           # Core Exceptions (BaseException, NetworkExceptions, ExceptionMapper, executeRequest)
    │   ├── extensions/           # String & Object Extensions
    │   ├── helpers/              # Result Pattern (Result<T, E>, Success, Failure, ResultX)
    │   ├── interceptors/         # Dio Interceptors (AuthInterceptor, LocalizationInterceptor, ErrorInterceptor)
    │   ├── managers/             # Core Managers (EnvManager, NetworkManager, CacheManager, EncryptedCacheManager)
    │   ├── router/               # AppRouter & AppRoute Enum
    │   └── theme/                # Light & Dark AppTheme, AppColors, AppTextStyles, AppBoxShadows
    ├── data/
    │   ├── datasources/
    │   │   ├── local/            # Local Data Sources (Hive / EncryptedStorage)
    │   │   └── remote/           # Remote Data Sources (AuthRemoteDataSource, UserRemoteDataSource)
    │   ├── models/
    │   │   ├── dto/              # Data Transfer Objects
    │   │   ├── request/          # API Request DTOs (LoginRequest, RegisterRequest, etc.)
    │   │   └── response/         # API Response DTOs with toDomain() converter
    │   └── repositories/         # Repository implementations returning Result<T, FeatureException>
    ├── domain/
    │   ├── exceptions/           # Feature-Specific Exception Hierarchies (AuthException, UserException, SettingsException)
    │   ├── models/
    │   │   └── base/             # BaseModel (id) & TimestampModel (createdAt, updatedAt)
    │   ├── repositories/         # Abstract repository interfaces (IAuthRepository, IUserRepository, ISettingsRepository)
    │   └── usecases/             # Single-responsibility Use Cases
    │       ├── auth/             # LoginUseCase, RegisterUseCase, ForgotPasswordUseCase, VerifyOtpUseCase, ResetPasswordUseCase, RefreshTokenUseCase
    │       ├── settings/         # GetLanguageUseCase, UpdateLanguageUseCase, GetThemeUseCase, UpdateThemeUseCase, LogoutUseCase
    │       └── user/             # GetUserProfileUseCase, UpdateUserProfileUseCase
    └── presentation/
        ├── features/
        │   ├── auth/             # Login, Register, Forgot Password, Verify OTP, Reset Password pages + Cubits
        │   ├── error/            # Error / Fallback Page for GoRouter error handling
        │   ├── home/             # Home view + Cubit
        │   ├── onboarding/        # Onboarding Page + Cubit with Hive completion caching
        │   ├── settings/         # Settings view + Cubit
        │   └── splash/           # Splash screen + Cubit (checks Onboarding -> Token -> User profile)
        ├── global_cubits/        # Application-wide Cubits (SettingsCubit)
        └── widgets/              # Shared presentation widgets (CustomButton, CustomTextField, CustomRichText, ErrorSnackBar)
```

---

## 🛠️ Key Architectural Patterns

### 1. Typed Error Handling & Result Pattern
- All remote API calls are executed through `executeRequest` wrapper which maps Dio/HTTP errors to typed `BaseException` subclasses.
- Each feature defines its own sealed exception hierarchy in `domain/exceptions/`:
  - `AuthException` (`AuthInvalidCredentials`, `AuthUserAlreadyExists`, `AuthNoInternetException`, etc.)
  - `UserException` (`UserNotFound`, `UserValidationError`, `UserNoInternetException`, etc.)
  - `SettingsException` (`SettingsNoInternetException`, `SettingsServerException`, etc.)
- Repositories convert exceptions using `.toAuthException()`, `.toUserException()`, `.toSettingsException()` and return `Result<T, FeatureException>` (`Success` or `Failure`).

### 2. Centralized Endpoint Protection (`ApiEndpoint`)
- All backend routes live exclusively in the `ApiEndpoint` enum (`lib/src/core/enums/api_endpoint.dart`).
- Routes default to `requiresAuth: true`. Only public routes are marked `requiresAuth: false`.
- `AuthInterceptor` checks `ApiEndpoint.isPublic(path)` to automatically skip Authorization headers and 401 refresh logic for public routes.

### 3. Session Expiry & Single-Entry Logout Flow
- Token refresh race conditions are prevented using `retryDio` (an un-intercepted `plainDio` instance).
- Session expiry (refresh failure or retry 401) calls `onSessionExpired` -> `SettingsCubit.logout()`.
- `SettingsCubit.logout()` emits a one-shot `loggedOut: true` signal.
- The root `BlocListener` in `main_app.dart` captures `loggedOut` and performs stack reset navigation: `AppRouter.router.go(AppRoute.login.path)`.

### 4. Cache Managers with Default Values
- `CacheManager.getOrDefault<T>(boxName, key, defaultValue)` for Hive storage.
- `EncryptedCacheManager.readOrDefault(key, defaultValue)` for Secure Storage.

---

## 🎨 UI Styling & Design System Rules

1. **Paddings & Spacings**: All paddings use predefined `AppPaddings` (`lib/src/core/constants/paddings.dart`) and `AppSpaces` (`lib/src/core/constants/spaces.dart`) adapted via `flutter_screenutil`.
2. **Icon Sizes**: All icon dimensions use `AppIconSizes` (`lib/src/core/constants/icon_sizes.dart`) using ScreenUtil `.r` dimensions.
3. **Box Shadows & Elevations**: Elevation and card shadows use `AppBoxShadows` (`lib/src/core/theme/box_shadows.dart`).
4. **Colors**: Palette defined in `AppColors` (`lib/src/core/theme/colors.dart`). No hardcoded hex or raw inline colors.
5. **Typography**: Fonts defined in `AppTextStyles` (`lib/src/core/theme/text_styles.dart`) using responsive `.sp` sizes.

---

## ⚡ Tech Stack & Packages

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) / Cubit & [equatable](https://pub.dev/packages/equatable)
- **Navigation & Routing**: [go_router](https://pub.dev/packages/go_router)
- **Screen Responsiveness**: [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Networking**: [dio](https://pub.dev/packages/dio)
- **Local Storage & Security**: [hive](https://pub.dev/packages/hive), [hive_flutter](https://pub.dev/packages/hive_flutter), [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)
- **Localization**: [easy_localization](https://pub.dev/packages/easy_localization)
- **Code Generation**: [flutter_gen](https://pub.dev/packages/flutter_gen)

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/MegrurNiftiyev/Flutter-Clean-Arch-Template.git
cd Flutter-Clean-Arch-Template
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Run the app
```bash
flutter run
```

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).
