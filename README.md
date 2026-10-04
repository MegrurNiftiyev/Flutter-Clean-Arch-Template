# Flutter Clean Architecture Template

A production-ready, highly scalable starter template for Flutter applications built following strict **Clean Architecture**, **Feature-First Presentation**, **Sealed Error Handling & Result Pattern**, **GoRouter Routing**, **ScreenUtil Responsiveness**, and **BLoC / Cubit State Management**.

---

## 🏗️ Architecture Overview

```text
lib/
├── main.dart                     # Entry point (EasyLocalization, initializeDependencies, pre-loads SettingsCubit)
├── main_app.dart                 # Root App widget (MaterialApp.router, AppTheme, ScreenUtil, Session Expiry Listener)
├── gen/                          # Generated assets & fonts (flutter_gen)
│   ├── assets.gen.dart
│   └── fonts.gen.dart
└── src/
    ├── core/
    │   ├── components/           # Reusable UI components (CustomSnackBar, CustomDialog, CustomBottomSheet, CustomBottomNavBar)
    │   ├── constants/            # Design system tokens (AppPaddings, AppSpaces, AppIconSizes, AppRadii, AppDurations)
    │   ├── di/                   # Modularized GetIt Dependency Injection (cubits, data_sources, repositories, use_cases, managers, network)
    │   ├── enums/                # App Enums (ApiEndpoint, EventStatus, Status, SplashTarget, AppLanguage)
    │   ├── exceptions/           # Exception Hierarchy (BaseException, NetworkExceptions, AuthException, UserException, SettingsException)
    │   ├── extensions/           # Extensions (EventStatusX, StringExtensions)
    │   ├── helpers/              # Core Helpers (Result<T>, safeCall, executeRequest, exception_mapper)
    │   ├── interceptors/         # Dio Interceptors (AuthInterceptor, LocalizationInterceptor, ErrorInterceptor)
    │   ├── managers/             # Managers (EnvManager, NetworkManager, CacheManager, EncryptedCacheManager)
    │   ├── router/               # AppRouter & AppRoute Enum
    │   └── theme/                # Light & Dark AppTheme, AppColors, AppTextStyles, AppBoxShadows
    ├── data/
    │   ├── datasources/
    │   │   ├── local/            # Local Data Sources (SettingsLocalDataSource using Hive / EncryptedStorage)
    │   │   └── remote/           # Remote Data Sources (AuthRemoteDataSource, UserRemoteDataSource)
    │   ├── models/
    │   │   ├── dto/              # Data Transfer Objects
    │   │   ├── request/          # API Request Models (LoginRequest, RegisterRequest, etc.)
    │   │   └── response/         # API Response Models with toDomain() converters
    │   └── repositories/         # Repository Implementations wrapping calls in safeCall(() async { ... })
    ├── domain/
    │   ├── models/               # Domain Entities extending BaseModel & implementing TimestampModel
    │   ├── repositories/         # Repository Interfaces (IAuthRepository, IUserRepository, ISettingsRepository)
    │   └── usecases/             # Single-responsibility Use Cases (LoginUseCase, GetUserProfileUseCase, etc.)
    └── presentation/
        ├── features/             # Feature Modules (auth, home, onboarding, settings, splash, error, demo_screen1, demo_screen2)
        ├── global_cubits/        # Shared Application-Wide Cubits (SettingsCubit)
        └── widgets/              # Presentation Widgets (CustomButton, CustomTextField, CustomRichText)
```

---

## 🔒 Exceptions & Error Handling Hierarchy

The template enforces a **Sealed Exception Architecture** similar to Kotlin's `NetworkException` + `BaseApiException` division. Network errors are unified, while features hold only true domain-specific exceptions.

### 1. Exception Class Diagram

```text
BaseException (abstract, Equatable)
 ├─ NetworkException (sealed)
 │   ├─ NoInternetException
 │   ├─ RequestTimeoutException
 │   ├─ UnauthorizedException (401)
 │   ├─ NotFoundException (404)
 │   ├─ ServerException
 │   └─ UnknownException
 │
 └─ AuthException (sealed - Domain Specific)
     ├─ AuthInvalidCredentials (401)
     ├─ AuthValidationError (400)
     ├─ AuthEmailNotConfirmed (403)
     ├─ AuthUserAlreadyExists (409)
     └─ AuthRateLimitExceeded (429)
```

### 2. Domain Exception Factory Mapping

Domain exceptions declare a static `expected` status code map:

```dart
sealed class AuthException extends BaseException {
  const AuthException(super.message, [super.statusCode]);

  static final Map<int, AuthException Function(String?)> expected = {
    400: AuthValidationError.new,
    401: AuthInvalidCredentials.new,
    403: AuthEmailNotConfirmed.new,
    409: AuthUserAlreadyExists.new,
    429: AuthRateLimitExceeded.new,
  };
}
```

### 3. `executeRequest` & Stack Trace Preservation

Remote data sources execute API calls with `executeRequest`:

```dart
class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<LoginResponse> login(LoginRequest request) {
    return executeRequest(
      expected: AuthException.expected,
      () async {
        final response = await apiClient.dio.post(
          ApiEndpoint.login.path,
          data: request.toJson(),
        );
        return LoginResponse.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }
}
```

---

## ⚡ `Result<T>` Pattern & `safeCall`

The `Result<T>` pattern has a single generic parameter (`Success<T>` or `Failure<T>`). All repository implementations execute operations using `safeCall`:

### Remote Repository Example

```dart
class AuthRepository implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final EncryptedCacheManager encryptedCacheManager;

  AuthRepository({
    required this.remoteDataSource,
    required this.encryptedCacheManager,
  });

  @override
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      final request = LoginRequest(email: email, password: password);
      final response = await remoteDataSource.login(request);
      final authModel = response.toDomain();

      await encryptedCacheManager.write(
          CacheKeys.accessTokenKey, authModel.accessToken);
      await encryptedCacheManager.write(
          CacheKeys.refreshTokenKey, authModel.refreshToken);

      return authModel.user;
    });
  }
}
```

### Local Repository Example

```dart
class SettingsRepository implements ISettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepository({required SettingsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Result<bool>> isDarkMode() async {
    return safeCall(() async {
      return await _localDataSource.isDarkMode();
    });
  }

  @override
  Future<Result<void>> setDarkMode(bool isDark) async {
    return safeCall(() async {
      await _localDataSource.setDarkMode(isDark);
    });
  }
}
```

---

## 🔄 Data Flow Architecture

The data flow direction is strictly unidirectional:
`Page -> Cubit -> UseCase -> IRepository -> RepositoryImpl -> DataSource -> API / Cache`

1. **Domain Models**: Extend `BaseModel` (`id`) and implement `TimestampModel` (`createdAt`, `updatedAt`).
2. **Domain Repository Interfaces**: Accept primitive parameters, never DTOs or Request objects. Return `Future<Result<T>>`.
3. **Use Cases**: One use case = one business action (`LoginUseCase`, `LogoutUseCase`).
4. **Cubits**: Depend only on Use Cases (never Repositories or Data Sources directly). Emit `Status.loading` before calls and handle outcomes with `result.fold(onSuccess, onError)`.

---

## 🎨 UI & Design Tokens System

1. **Design Constants**:
   - `AppPaddings`: Standard paddings (`all16`, `h16`, `v14h16`, etc.) with `ScreenUtil`.
   - `AppSpaces`: Vertical and horizontal spacing widgets (`v16`, `h16`).
   - `AppIconSizes`: Icon dimensions (`s16`, `s24`, `s32`).
   - `AppRadii`: Border radius helpers (`borderR8`, `borderR16`).
   - `AppDurations`: Time durations (`instant`, `fast`, `small`, `medium`, `large`).
2. **UI Status Component (`EventStatus`)**:
   - `EventStatus` (`info`, `success`, `warning`, `error`).
   - `EventStatusX` extension provides `icon` and `color` dynamically across UI widgets like `CustomSnackBar`.
3. **Assets & Fonts with `flutter_gen`**:
   - Images: `Assets.images.logo.image(width: 120.r)`
   - Fonts: `TextStyle(fontFamily: FontFamily.poppins)`

---

## 🛠️ Commit Message Conventions

Commit messages MUST follow the Conventional Commits format:

```text
<header>

- <detail 1>
- <detail 2>
```

Example:
```text
feat: add language selection bottom sheet

- Replace language dropdown with a bottom sheet in settings
- Add LanguageTile widget with icon, text and selected state
- Apply selected language immediately through SettingsCubit
```

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/MegrurNiftiyev/Flutter-Clean-Arch-Template.git
cd Flutter-Clean-Arch-Template
```

### 2. Install dependencies & run build runner
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run static analyzer & launch app
```bash
flutter analyze
flutter run
```

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).
