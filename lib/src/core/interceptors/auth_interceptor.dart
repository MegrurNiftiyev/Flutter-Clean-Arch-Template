import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/usecases/auth/refresh_token_use_case.dart';
import '../constants/api_constants.dart';
import '../constants/cache_keys.dart';
import '../di/dependency_injection.dart';
import '../enums/api_endpoint.dart';
import '../managers/encrypted_cache_manager.dart';
import '../helpers/result.dart';

class AuthInterceptor extends QueuedInterceptor {
  final EncryptedCacheManager encryptedCacheManager;
  final RefreshTokenUseCase? refreshTokenUseCase;
  final VoidCallback onSessionExpired;
  final Dio retryDio;

  AuthInterceptor(
    this.encryptedCacheManager, {
    required this.onSessionExpired,
    required this.retryDio,
    this.refreshTokenUseCase,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (ApiEndpoint.isPublic(options.path)) return handler.next(options);
    final token = await _token();
    if (token != null) {
      options.headers[ApiConstants.authorizationHeader] = _bearer(token);
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final req = err.requestOptions;
    if (err.response?.statusCode != 401 || ApiEndpoint.isPublic(req.path)) {
      return handler.next(err);
    }

    final current = await _token();
    if (current == null) return handler.next(err);

    if (req.headers[ApiConstants.authorizationHeader] == _bearer(current)) {
      final useCase = refreshTokenUseCase ?? sl<RefreshTokenUseCase>();
      final result = await useCase();
      if (result.isFailure) {
        onSessionExpired();
        return handler.next(err);
      }
    }

    final fresh = await _token();
    if (fresh == null) return handler.next(err);
    req.headers[ApiConstants.authorizationHeader] = _bearer(fresh);

    try {
      handler.resolve(await retryDio.fetch(req));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) onSessionExpired();
      handler.next(e);
    }
  }

  String _bearer(String token) => '${ApiConstants.bearerPrefix}$token';

  Future<String?> _token() async {
    final token = await encryptedCacheManager.read(CacheKeys.accessTokenKey);
    return token == null || token.isEmpty ? null : token;
  }
}
