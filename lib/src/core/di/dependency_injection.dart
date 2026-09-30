import 'package:get_it/get_it.dart';
import '../../data/datasources/remote/auth_remote_data_source.dart';
import '../../data/datasources/remote/user_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../presentation/features/auth/cubit/login/login_cubit.dart';
import '../../presentation/features/auth/cubit/register/register_cubit.dart';
import '../../presentation/features/splash/cubit/splash_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // Data Sources
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  sl.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSource(),
  );

  // Repositories
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<IUserRepository>(
    () => UserRepository(remoteDataSource: sl()),
  );

  // Cubits / Blocs
  sl.registerFactory(
    () => LoginCubit(authRepository: sl()),
  );

  sl.registerFactory(
    () => RegisterCubit(authRepository: sl()),
  );

  sl.registerFactory(
    () => SplashCubit(userRepository: sl()),
  );
}
