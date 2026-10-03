# Flutter Clean Architecture Template

A production-ready, highly scalable starter template for Flutter applications built following the principles of **Clean Architecture**, **Feature-First Presentation**, **GoRouter Routing**, **ScreenUtil Responsiveness**, and **BLoC / Cubit State Management**.

---

## 🏗️ Architecture Overview

```
lib/
├── main.dart                     # App entry point with EasyLocalization, ScreenUtil & GoRouter
├── gen/                          # Generated assets (flutter_gen)
└── src/
    ├── core/
    │   ├── components/           # Core UI components
    │   ├── constants/            # App constants (AppPaddings, AppSpaces, AppIconSizes, ApiConstants, CacheKeys)
    │   ├── di/                   # Modularized Dependency Injection (GetIt)
    │   │   ├── cubits.dart
    │   │   ├── data_sources.dart
    │   │   ├── dependency_injection.dart
    │   │   ├── managers.dart
    │   │   ├── network.dart
    │   │   ├── repositories.dart
    │   │   └── use_cases.dart
    │   ├── enums/                # Enums (Status, AppLanguage, AppRegion, etc.)
    │   ├── extensions/           # Extensions (StringValidatorExtensions)
    │   ├── interceptors/         # Dio Interceptors (AuthInterceptor, LocalizationInterceptor, ErrorInterceptor)
    │   ├── managers/             # Core Managers (EnvManager, NetworkManager, CacheManager, EncryptedCacheManager)
    │   ├── router/               # AppRouter & AppRoute Enum
    │   └── theme/                # Light & Dark AppTheme, AppColors, AppTextStyles, AppBoxShadows
    ├── data/
    │   ├── datasources/
    │   │   ├── local/            # Local Data Sources (Hive / EncryptedStorage)
    │   │   └── remote/           # Remote Data Sources (AuthRemoteDataSource, UserRemoteDataSource)
    │   ├── models/
    │   │   ├── dto/              # Data Transfer Objects (UserDto, AuthDto)
    │   │   ├── request/          # API Request DTOs (LoginRequest, RegisterRequest, ForgotPasswordRequest, etc.)
    │   │   └── response/         # API Response DTOs with toDomain() converter
    │   └── repositories/         # Repository implementations
    ├── domain/
    │   ├── models/
    │   │   └── base/             # BaseModel (id) & TimestampModel (createdAt, updatedAt)
    │   ├── repositories/         # Abstract repository interfaces (IAuthRepository, IUserRepository)
    │   └── usecases/             # Single-responsibility Use Cases
    │       ├── auth/             # LoginUseCase, RegisterUseCase, ForgotPasswordUseCase, VerifyOtpUseCase, ResetPasswordUseCase
    │       └── user/             # GetUserProfileUseCase, UpdateUserProfileUseCase
    └── presentation/
        ├── features/
        │   ├── auth/             # Login, Register, Forgot Password, Verify OTP, Reset Password pages + Cubits
        │   ├── error/            # Error / Fallback Page for GoRouter error handling
        │   ├── home/             # Home view + Cubit
        │   ├── onboarding/        # Onboarding Page + Cubit with Hive completion caching
        │   ├── settings/         # Settings view + Cubit
        │   └── splash/           # Splash screen + Cubit (checks Onboarding -> Token -> User profile)
        └── widgets/              # Shared presentation widgets (CustomButton, CustomTextField)
```

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
- **Environment Management**: [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- **Localization**: [easy_localization](https://pub.dev/packages/easy_localization)
- **Flavors**: [flutter_flavor](https://pub.dev/packages/flutter_flavor)

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
