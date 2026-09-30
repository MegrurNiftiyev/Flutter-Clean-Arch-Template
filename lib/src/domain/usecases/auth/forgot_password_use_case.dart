import '../../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  ForgotPasswordUseCase({
    required this.repository,
  });

  final IAuthRepository repository;

  Future<void> call({
    required String email,
  }) {
    return repository.forgotPassword(
      email: email,
    );
  }
}
