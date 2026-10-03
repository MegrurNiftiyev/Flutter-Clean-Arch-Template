import '../../core/constants/cache_keys.dart';
import '../../core/managers/encrypted_cache_manager.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/request/forgot_password_request.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../models/request/reset_password_request.dart';
import '../models/request/verify_otp_request.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required this.remoteDataSource,
    required this.encryptedCacheManager,
  });

  final AuthRemoteDataSource remoteDataSource;
  final EncryptedCacheManager encryptedCacheManager;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final request = LoginRequest(email: email, password: password);
    final response = await remoteDataSource.login(request);
    final authModel = response.toDomain();

    await encryptedCacheManager.write(CacheKeys.accessTokenKey, authModel.accessToken);
    await encryptedCacheManager.write(CacheKeys.refreshTokenKey, authModel.refreshToken);

    return authModel.user;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final request = RegisterRequest(email: email, password: password, name: name);
    final response = await remoteDataSource.register(request);
    final authModel = response.toDomain();

    await encryptedCacheManager.write(CacheKeys.accessTokenKey, authModel.accessToken);
    await encryptedCacheManager.write(CacheKeys.refreshTokenKey, authModel.refreshToken);

    return authModel.user;
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    final request = ForgotPasswordRequest(email: email);
    return remoteDataSource.forgotPassword(request);
  }

  @override
  Future<String> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    final request = VerifyOtpRequest(email: email, otpCode: otpCode);
    final response = await remoteDataSource.verifyOtp(request);
    return response.resetToken;
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    final request = ResetPasswordRequest(resetToken: resetToken, newPassword: newPassword);
    return remoteDataSource.resetPassword(request);
  }
}
