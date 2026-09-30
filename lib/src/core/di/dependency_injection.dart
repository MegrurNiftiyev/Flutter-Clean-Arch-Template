import 'package:get_it/get_it.dart';
import '../../data/datasources/remote/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  // Data Sources
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  // Repositories
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(remoteDataSource: sl()),
  );
}
