import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/auth/forgot_password_use_case.dart';
import '../../domain/usecases/auth/login_use_case.dart';
import '../../domain/usecases/auth/refresh_token_use_case.dart';
import '../../domain/usecases/auth/register_use_case.dart';
import '../../domain/usecases/auth/reset_password_use_case.dart';
import '../../domain/usecases/auth/verify_otp_use_case.dart';
import '../../domain/usecases/settings/get_language_use_case.dart';
import '../../domain/usecases/settings/get_theme_use_case.dart';
import '../../domain/usecases/settings/logout_use_case.dart';
import '../../domain/usecases/settings/update_language_use_case.dart';
import '../../domain/usecases/settings/update_theme_use_case.dart';
import '../../domain/usecases/user/get_user_profile_use_case.dart';
import '../../domain/usecases/user/update_user_profile_use_case.dart';
import 'dependency_injection.dart';

void initializeUseCases() {
  sl.registerLazySingleton(
    () => LoginUseCase(repository: sl<IAuthRepository>()),
  );

  sl.registerLazySingleton(
    () => RegisterUseCase(repository: sl<IAuthRepository>()),
  );

  sl.registerLazySingleton(
    () => ForgotPasswordUseCase(repository: sl<IAuthRepository>()),
  );

  sl.registerLazySingleton(
    () => VerifyOtpUseCase(repository: sl<IAuthRepository>()),
  );

  sl.registerLazySingleton(
    () => ResetPasswordUseCase(repository: sl<IAuthRepository>()),
  );

  sl.registerLazySingleton(
    () => RefreshTokenUseCase(repository: sl<IAuthRepository>()),
  );

  sl.registerLazySingleton(
    () => GetUserProfileUseCase(repository: sl<IUserRepository>()),
  );

  sl.registerLazySingleton(
    () => UpdateUserProfileUseCase(repository: sl<IUserRepository>()),
  );

  sl.registerLazySingleton(
    () => GetThemeUseCase(repository: sl<ISettingsRepository>()),
  );

  sl.registerLazySingleton(
    () => UpdateThemeUseCase(repository: sl<ISettingsRepository>()),
  );

  sl.registerLazySingleton(
    () => GetLanguageUseCase(repository: sl<ISettingsRepository>()),
  );

  sl.registerLazySingleton(
    () => UpdateLanguageUseCase(repository: sl<ISettingsRepository>()),
  );

  sl.registerLazySingleton(
    () => LogoutUseCase(repository: sl<ISettingsRepository>()),
  );
}
