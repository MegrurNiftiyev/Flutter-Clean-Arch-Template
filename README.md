# Flutter Clean Architecture Template

A production-ready, scalable starter template for Flutter applications built following the principles of **Clean Architecture**, **Feature-First Presentation**, and **BSoD/Cubit State Management**.

---

## 🏗️ Architecture Overview

```
lib/
├── main.dart
├── gen/
└── src/
    ├── core/
    │   ├── components/
    │   ├── constants/
    │   ├── di/                   # Dependency Injection locator (GetIt)
    │   ├── enums/                # Global Enums (Status: Initial, Loading, Success, Failure)
    │   ├── extensions/
    │   ├── interceptors/         # Dio Interceptors
    │   ├── managers/
    │   └── theme/                # Light & Dark AppTheme and AppColors
    ├── data/
    │   ├── datasources/
    │   │   ├── local/
    │   │   └── remote/           # Remote Data Sources (AuthRemoteDataSource, UserRemoteDataSource)
    │   ├── models/
    │   │   ├── dto/
    │   │   ├── request/          # API Request DTOs (LoginRequest, UserUpdateRequest)
    │   │   └── response/         # API Response DTOs with toDomain() converter
    │   └── repositories/         # Repository implementations
    ├── domain/
    │   ├── models/
    │   │   └── base/             # BaseModel (id) & ITimestamp (createdAt, updatedAt)
    │   └── repositories/         # Abstract repository interfaces (IAuthRepository, IUserRepository)
    └── presentation/
        ├── features/
        │   ├── auth/             # Login & Register pages + Cubits
        │   ├── home/             # Home view + Cubit
        │   ├── settings/         # Settings view + Cubit
        │   └── splash/           # Splash screen + Cubit
        └── widgets/              # Shared UI components
```

---

## ⚡ Tech Stack & Packages

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) / Cubit & [equatable](https://pub.dev/packages/equatable)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Networking**: [dio](https://pub.dev/packages/dio)
- **Local Storage**: [hive](https://pub.dev/packages/hive) & [hive_flutter](https://pub.dev/packages/hive_flutter)
- **Localization**: [easy_localization](https://pub.dev/packages/easy_localization)
- **Code Generation**: [build_runner](https://pub.dev/packages/build_runner), [hive_generator](https://pub.dev/packages/hive_generator), [flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner)
- **UI Components**: [flutter_svg](https://pub.dev/packages/flutter_svg), [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter), [skeletonizer](https://pub.dev/packages/skeletonizer), [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

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

### 3. Run code generation (optional)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the app
```bash
flutter run
```

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).
