import '../../../core/helpers/result.dart';
import '../../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final IAuthRepository repository;

  const VerifyOtpUseCase(this.repository);

  Future<Result<String>> call(String email, String otpCode) {
    return repository.verifyOtp(email: email, otpCode: otpCode);
  }
}
