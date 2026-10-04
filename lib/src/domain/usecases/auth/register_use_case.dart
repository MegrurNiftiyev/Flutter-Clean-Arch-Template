import '../../../core/helpers/result.dart';
import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase {
  final IAuthRepository repository;

  const RegisterUseCase(this.repository);

  Future<Result<UserModel>> call(String email, String password,
      {String? name}) {
    return repository.register(email: email, password: password, name: name);
  }
}
