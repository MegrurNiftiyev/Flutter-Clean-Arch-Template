import 'package:get_it/get_it.dart';
import '../../data/datasources/remote/auth_remote_data_source.dart';
import '../../data/datasources/remote/user_remote_data_source.dart';

final GetIt _sl = GetIt.instance;

void setupDataSources() {
  _sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  _sl.registerLazySingleton<IUserRemoteDataSource>(
    () => UserRemoteDataSource(),
  );
}
