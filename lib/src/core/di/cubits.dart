import 'package:get_it/get_it.dart';
import '../../presentation/features/auth/cubit/login/login_cubit.dart';
import '../../presentation/features/auth/cubit/register/register_cubit.dart';
import '../../presentation/features/splash/cubit/splash_cubit.dart';

final GetIt _sl = GetIt.instance;

void setupCubits() {
  _sl.registerFactory(
    () => LoginCubit(loginUseCase: _sl()),
  );

  _sl.registerFactory(
    () => RegisterCubit(registerUseCase: _sl()),
  );

  _sl.registerFactory(
    () => SplashCubit(getUserProfileUseCase: _sl()),
  );
}
