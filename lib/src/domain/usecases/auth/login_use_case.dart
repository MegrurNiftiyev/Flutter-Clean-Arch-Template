import '../../../core/helpers/result.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase {
  final IAuthRepository repository;

  const LoginUseCase(this.repository);

  Future<Result<UserModel>> call(String email, String password) {
    return repository.login(email: email, password: password);
  }
}
