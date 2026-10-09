import 'package:dio/dio.dart';

import '../exceptions/base_exception.dart';
import '../exceptions/network_exceptions.dart';

typedef ErrorFactories = Map<String, BaseException Function(String?)>;

BaseException mapDioException(DioException e, ErrorFactories expected) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const RequestTimeoutException();
    case DioExceptionType.connectionError:
      return const NoInternetException();
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode;
      final data = e.response?.data;
      
      String? errorCode;
      String? msg;
      
      if (data is Map) {
        final errorObj = data['error'];
        if (errorObj is Map) {
          errorCode = errorObj['code']?.toString();
          msg = errorObj['message']?.toString();
        } else {
          msg = data['message']?.toString();
        }
      }

      if (errorCode != null) {
        final factory = expected[errorCode];
        if (factory != null) return factory(msg);
      }
      return switch (code) {
        401 => UnauthorizedException(msg),
        404 => NotFoundException(msg),
        _ => ServerException(msg, code),
      };
    default:
      return UnknownException(e.message);
  }
}
