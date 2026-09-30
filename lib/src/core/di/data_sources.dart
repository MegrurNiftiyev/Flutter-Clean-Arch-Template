import '../../data/datasources/remote/auth_remote_data_source.dart';
import '../../data/datasources/remote/user_remote_data_source.dart';
import 'dependency_injection.dart';

void initializeDataSources() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(),
  );
}
