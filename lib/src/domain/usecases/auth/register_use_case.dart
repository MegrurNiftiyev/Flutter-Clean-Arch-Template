import '../../models/user_model.dart';
import '../../repositories/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase({
    required this.repository,
  });

  final IAuthRepository repository;

  Future<UserModel> call({
    required String email,
    required String password,
    String? name,
  }) {
    return repository.register(
      email: email,
      password: password,
      name: name,
    );
  }
}
