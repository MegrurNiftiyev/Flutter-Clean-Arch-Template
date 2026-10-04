import '../../../core/helpers/result.dart';
import '../../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final IAuthRepository repository;

  const ForgotPasswordUseCase(this.repository);

  Future<Result<void>> call(String email) {
    return repository.forgotPassword(email: email);
  }
}
