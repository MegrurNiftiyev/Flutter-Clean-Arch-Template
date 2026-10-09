import '../../../core/helpers/result.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final IAuthRepository repository;

  const ForgotPasswordUseCase(this.repository);

  Future<Result<void>> call(String email) {
    return repository.forgotPassword(email: email);
  }
}
