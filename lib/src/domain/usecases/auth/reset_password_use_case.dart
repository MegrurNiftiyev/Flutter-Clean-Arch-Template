import '../../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase({
    required this.repository,
  });

  final IAuthRepository repository;

  Future<void> call({
    required String resetToken,
    required String newPassword,
  }) {
    return repository.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
    );
  }
}
