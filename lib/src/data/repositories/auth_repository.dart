import '../../core/constants/cache_keys.dart';
import '../../core/exceptions/network_exceptions.dart';
import '../../core/helpers/result.dart';
import '../../core/managers/encrypted_cache_manager.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/request/forgot_password_request.dart';
import '../models/request/login_request.dart';
import '../models/request/refresh_token_request.dart';
import '../models/request/register_request.dart';
import '../models/request/reset_password_request.dart';
import '../models/request/verify_otp_request.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required this.remoteDataSource,
    required this.encryptedCacheManager,
  });

  final AuthRemoteDataSource remoteDataSource;
  final EncryptedCacheManager encryptedCacheManager;

  @override
  Future<Result<UserModel>> login({
    required String email,
    required String password,
  }) async {
    return safeCall(() async {
      final request = LoginRequest(email: email, password: password);
      final response = await remoteDataSource.login(request);
      final authModel = response.toDomain();

      await encryptedCacheManager.write(
          CacheKeys.accessTokenKey, authModel.accessToken);
      await encryptedCacheManager.write(
          CacheKeys.refreshTokenKey, authModel.refreshToken);

      return authModel.user;
    });
  }

  @override
  Future<Result<UserModel>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    return safeCall(() async {
      final request =
          RegisterRequest(email: email, password: password, name: name);
      final response = await remoteDataSource.register(request);
      final authModel = response.toDomain();

      await encryptedCacheManager.write(
          CacheKeys.accessTokenKey, authModel.accessToken);
      await encryptedCacheManager.write(
          CacheKeys.refreshTokenKey, authModel.refreshToken);

      return authModel.user;
    });
  }

  @override
  Future<Result<void>> forgotPassword({required String email}) async {
    return safeCall(() async {
      await remoteDataSource
          .forgotPassword(ForgotPasswordRequest(email: email));
    });
  }

  @override
  Future<Result<String>> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    return safeCall(() async {
      final response = await remoteDataSource
          .verifyOtp(VerifyOtpRequest(email: email, otpCode: otpCode));
      return response.resetToken;
    });
  }

  @override
  Future<Result<void>> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    return safeCall(() async {
      await remoteDataSource.resetPassword(
        ResetPasswordRequest(resetToken: resetToken, newPassword: newPassword),
      );
    });
  }

  @override
  Future<Result<void>> refreshToken() async {
    return safeCall(() async {
      final current =
          await encryptedCacheManager.read(CacheKeys.refreshTokenKey);
      if (current == null || current.isEmpty) {
        throw const UnauthorizedException();
      }
      final response = await remoteDataSource
          .refreshToken(RefreshTokenRequest(refreshToken: current));
      await encryptedCacheManager.write(
          CacheKeys.accessTokenKey, response.accessToken);
      await encryptedCacheManager.write(
          CacheKeys.refreshTokenKey, response.refreshToken);
    });
  }
}
