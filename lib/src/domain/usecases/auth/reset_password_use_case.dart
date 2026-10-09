import '../../../core/helpers/result.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final IAuthRepository repository;

  const ResetPasswordUseCase(this.repository);

  Future<Result<void>> call(String resetToken, String newPassword) {
    return repository.resetPassword(
        resetToken: resetToken, newPassword: newPassword);
  }
}
