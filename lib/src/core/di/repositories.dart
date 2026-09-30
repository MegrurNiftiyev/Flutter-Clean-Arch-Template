import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import 'dependency_injection.dart';

void setupRepositories() {
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<IUserRepository>(
    () => UserRepository(remoteDataSource: sl()),
  );
}
