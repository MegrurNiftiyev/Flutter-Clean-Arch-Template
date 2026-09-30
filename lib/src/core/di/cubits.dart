import '../../presentation/features/auth/cubit/login/login_cubit.dart';
import '../../presentation/features/auth/cubit/register/register_cubit.dart';
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
    () => SplashCubit(getUserProfileUseCase: sl()),
  );
}
