import 'package:get_it/get_it.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';

final GetIt _sl = GetIt.instance;

void setupRepositories() {
  _sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(remoteDataSource: _sl()),
  );

  _sl.registerLazySingleton<IUserRepository>(
    () => UserRepository(remoteDataSource: _sl()),
  );
}
