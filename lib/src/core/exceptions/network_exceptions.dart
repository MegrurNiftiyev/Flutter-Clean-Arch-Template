import 'base_exception.dart';

sealed class NetworkException extends BaseException {
  const NetworkException(super.message, [super.statusCode]);
}

final class NoInternetException extends NetworkException {
  const NoInternetException([String? m]) : super(m ?? 'No internet connection');
}

final class RequestTimeoutException extends NetworkException {
  const RequestTimeoutException([String? m])
      : super(m ?? 'The request timed out');
}

final class UnauthorizedException extends NetworkException {
  const UnauthorizedException([String? m])
      : super(m ?? 'Your session has expired', 401);
}

final class NotFoundException extends NetworkException {
  const NotFoundException([String? m]) : super(m ?? 'Not found', 404);
}

final class ServerException extends NetworkException {
  const ServerException([String? m, int? code])
      : super(m ?? 'A server error occurred', code);
}

final class UnknownException extends NetworkException {
  const UnknownException([String? m])
      : super(m ?? 'An unexpected error occurred');
}
