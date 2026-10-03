import '../../presentation/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import '../../presentation/features/auth/cubit/login/login_cubit.dart';
import '../../presentation/features/auth/cubit/register/register_cubit.dart';
import '../../presentation/features/auth/cubit/reset_password/reset_password_cubit.dart';
import '../../presentation/features/auth/cubit/verify_otp/verify_otp_cubit.dart';
import '../../presentation/features/onboarding/cubit/onboarding_cubit.dart';
import '../../presentation/features/settings/cubit/settings_cubit.dart';
import '../../presentation/features/splash/cubit/splash_cubit.dart';
import 'dependency_injection.dart';

void initializeCubits() {
  sl.registerFactory(
    () => LoginCubit(loginUseCase: sl()),
  );

  sl.registerFactory(
    () => RegisterCubit(registerUseCase: sl()),
  );

  sl.registerFactory(
    () => ForgotPasswordCubit(forgotPasswordUseCase: sl()),
  );

  sl.registerFactory(
    () => VerifyOtpCubit(verifyOtpUseCase: sl()),
  );

  sl.registerFactory(
    () => ResetPasswordCubit(
      resetPasswordUseCase: sl(),
      loginUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => OnboardingCubit(cacheManager: sl()),
  );

  sl.registerFactory(
    () => SplashCubit(
      cacheManager: sl(),
      encryptedCacheManager: sl(),
      getUserProfileUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => SettingsCubit(
      getThemeUseCase: sl(),
      updateThemeUseCase: sl(),
      getLanguageUseCase: sl(),
      updateLanguageUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );
}

