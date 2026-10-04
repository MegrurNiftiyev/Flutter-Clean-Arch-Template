import '../../../core/enums/api_endpoint.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/helpers/execute_request.dart';
import '../../../core/network/api_client.dart';
import '../../models/request/forgot_password_request.dart';
import '../../models/request/login_request.dart';
import '../../models/request/refresh_token_request.dart';
import '../../models/request/register_request.dart';
import '../../models/request/reset_password_request.dart';
import '../../models/request/verify_otp_request.dart';
import '../../models/response/login_response.dart';
import '../../models/response/refresh_token_response.dart';
import '../../models/response/register_response.dart';
import '../../models/response/verify_otp_response.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<LoginResponse> login(LoginRequest request) {
    return executeRequest(
      expected: AuthException.expected,
      () async {
        final response = await apiClient.dio.post(
          ApiEndpoint.login.path,
          data: request.toJson(),
        );
        return LoginResponse.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  Future<RegisterResponse> register(RegisterRequest request) {
    return executeRequest(
      expected: AuthException.expected,
      () async {
        final response = await apiClient.dio.post(
          ApiEndpoint.register.path,
          data: request.toJson(),
        );
        return RegisterResponse.fromJson(response.data as Map<String, dynamic>);
      },
    );
  }

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) {
    return executeRequest(
      expected: AuthException.expected,
      () async {
        final response = await apiClient.dio.post(
          ApiEndpoint.verifyOtp.path,
          data: request.toJson(),
        );
        return VerifyOtpResponse.fromJson(
            response.data as Map<String, dynamic>);
      },
    );
  }

  Future<void> forgotPassword(ForgotPasswordRequest request) {
    return executeRequest(
      expected: AuthException.expected,
      () async {
        await apiClient.dio.post(
          ApiEndpoint.forgotPassword.path,
          data: request.toJson(),
        );
      },
    );
  }

  Future<void> resetPassword(ResetPasswordRequest request) {
    return executeRequest(
      expected: AuthException.expected,
      () async {
        await apiClient.dio.post(
          ApiEndpoint.resetPassword.path,
          data: request.toJson(),
        );
      },
    );
  }

  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request) {
    return executeRequest(
      () async {
        final response = await apiClient.plainDio.post(
          ApiEndpoint.refreshToken.path,
          data: request.toJson(),
        );
        return RefreshTokenResponse.fromJson(
            response.data as Map<String, dynamic>);
      },
    );
  }
}
