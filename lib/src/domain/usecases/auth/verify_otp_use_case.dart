import '../../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  VerifyOtpUseCase({
    required this.repository,
  });

  final IAuthRepository repository;

  Future<String> call({
    required String email,
    required String otpCode,
  }) {
    return repository.verifyOtp(
      email: email,
      otpCode: otpCode,
    );
  }
}
