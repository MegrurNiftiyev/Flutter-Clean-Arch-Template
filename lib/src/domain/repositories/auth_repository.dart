import '../../core/helpers/result.dart';
import '../../core/exceptions/auth_exception.dart';
import '../models/user_model.dart';

abstract class IAuthRepository {
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  });

  Future<Result<UserModel>> register({
    required String email,
    required String password,
    String? name,
  });

  Future<Result<void>> forgotPassword({
    required String email,
  });

  Future<Result<String>> verifyOtp({
    required String email,
    required String otpCode,
  });

  Future<Result<void>> resetPassword({
    required String resetToken,
    required String newPassword,
  });

  Future<Result<void>> refreshToken();
}
