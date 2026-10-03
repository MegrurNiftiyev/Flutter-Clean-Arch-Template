import '../../domain/usecases/auth/forgot_password_use_case.dart';
import '../../domain/usecases/auth/login_use_case.dart';
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
    () => LoginUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => RegisterUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => ForgotPasswordUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => VerifyOtpUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => ResetPasswordUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetUserProfileUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateUserProfileUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetThemeUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateThemeUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetLanguageUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateLanguageUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => LogoutUseCase(repository: sl()),
  );
}

