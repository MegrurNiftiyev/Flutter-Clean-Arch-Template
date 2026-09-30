import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase({
    required this.repository,
  });

  final IAuthRepository repository;

  Future<UserModel> call({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
