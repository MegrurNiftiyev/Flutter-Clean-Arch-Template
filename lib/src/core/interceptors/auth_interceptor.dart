import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../constants/cache_keys.dart';
import '../managers/encrypted_cache_manager.dart';

class AuthInterceptor extends Interceptor {
  final EncryptedCacheManager encryptedCacheManager;

  AuthInterceptor(this.encryptedCacheManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await encryptedCacheManager.read(CacheKeys.accessTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] =
          '${ApiConstants.bearerPrefix}$token';
    }
    super.onRequest(options, handler);
  }
}
