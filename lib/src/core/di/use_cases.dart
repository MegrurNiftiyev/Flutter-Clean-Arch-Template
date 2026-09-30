import 'package:get_it/get_it.dart';
import '../../domain/usecases/auth/forgot_password_use_case.dart';
import '../../domain/usecases/auth/login_use_case.dart';
import '../../domain/usecases/auth/register_use_case.dart';
import '../../domain/usecases/user/get_user_profile_use_case.dart';
import '../../domain/usecases/user/update_user_profile_use_case.dart';

final GetIt _sl = GetIt.instance;

void setupUseCases() {
  _sl.registerLazySingleton(
    () => LoginUseCase(repository: _sl()),
  );

  _sl.registerLazySingleton(
    () => RegisterUseCase(repository: _sl()),
  );

  _sl.registerLazySingleton(
    () => ForgotPasswordUseCase(repository: _sl()),
  );

  _sl.registerLazySingleton(
    () => GetUserProfileUseCase(repository: _sl()),
  );

  _sl.registerLazySingleton(
    () => UpdateUserProfileUseCase(repository: _sl()),
  );
}
