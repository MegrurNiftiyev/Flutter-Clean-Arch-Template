import '../../../core/network/api_client.dart';
import '../../models/request/forgot_password_request.dart';
import '../../models/request/login_request.dart';
import '../../models/request/register_request.dart';
import '../../models/request/reset_password_request.dart';
import '../../models/request/verify_otp_request.dart';
import '../../models/response/login_response.dart';
import '../../models/response/register_response.dart';
import '../../models/response/verify_otp_response.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    throw UnimplementedError();
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    throw UnimplementedError();
  }

  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    throw UnimplementedError();
  }

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) async {
    throw UnimplementedError();
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    throw UnimplementedError();
  }
}
