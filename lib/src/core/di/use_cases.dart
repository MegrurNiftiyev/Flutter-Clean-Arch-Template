import '../../domain/usecases/auth/forgot_password_use_case.dart';
import '../../domain/usecases/auth/login_use_case.dart';
import '../../domain/usecases/auth/register_use_case.dart';
import '../../domain/usecases/user/get_user_profile_use_case.dart';
import '../../domain/usecases/user/update_user_profile_use_case.dart';
import 'dependency_injection.dart';

void initializeUseCases() {
  sl.registerLazySingleton(
    () => LoginUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => RegisterUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => ForgotPasswordUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetUserProfileUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => UpdateUserProfileUseCase(repository: sl()),
  );
}
