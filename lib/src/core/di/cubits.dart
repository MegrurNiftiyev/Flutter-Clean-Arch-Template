import '../../presentation/features/auth/cubit/forgot_password/forgot_password_cubit.dart';
import '../../presentation/features/auth/cubit/login/login_cubit.dart';
import '../../presentation/features/auth/cubit/register/register_cubit.dart';
import '../../presentation/features/auth/cubit/reset_password/reset_password_cubit.dart';
import '../../presentation/features/auth/cubit/verify_otp/verify_otp_cubit.dart';
import '../../presentation/features/onboarding/cubit/onboarding_cubit.dart';
import '../../presentation/features/splash/cubit/splash_cubit.dart';
import '../../presentation/global_cubits/settings/settings_cubit.dart';
import 'dependency_injection.dart';

void initializeCubits() {
  sl.registerFactory(
    () => LoginCubit(sl()),
  );

  sl.registerFactory(
    () => RegisterCubit(sl()),
  );

  sl.registerFactory(
    () => ForgotPasswordCubit(sl()),
  );

  sl.registerFactory(
    () => VerifyOtpCubit(sl()),
  );

  sl.registerFactory(
    () => ResetPasswordCubit(sl()),
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

  sl.registerLazySingleton(
    () => SettingsCubit(sl(), sl()),
  );
}
