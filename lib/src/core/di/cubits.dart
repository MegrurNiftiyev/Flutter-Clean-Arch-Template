import 'package:get_it/get_it.dart';
import '../../presentation/features/auth/cubit/login/login_cubit.dart';
import '../../presentation/features/auth/cubit/register/register_cubit.dart';
import '../../presentation/features/splash/cubit/splash_cubit.dart';

final GetIt _sl = GetIt.instance;

void setupCubits() {
  _sl.registerFactory(
    () => LoginCubit(authRepository: _sl()),
  );

  _sl.registerFactory(
    () => RegisterCubit(authRepository: _sl()),
  );

  _sl.registerFactory(
    () => SplashCubit(userRepository: _sl()),
  );
}
