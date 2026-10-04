import 'base_exception.dart';

sealed class AuthException extends BaseException {
  const AuthException(super.message, super.statusCode);

  static final Map<int, AuthException Function(String?)> expected = {
    400: AuthValidationError.new,
    401: AuthInvalidCredentials.new,
    403: AuthEmailNotConfirmed.new,
    409: AuthUserAlreadyExists.new,
    429: AuthRateLimitExceeded.new,
  };
}

final class AuthInvalidCredentials extends AuthException {
  const AuthInvalidCredentials([String? m])
      : super(m ?? 'Invalid email or password', 401);
}

final class AuthValidationError extends AuthException {
  const AuthValidationError([String? m])
      : super(m ?? 'Invalid input data format', 400);
}

final class AuthEmailNotConfirmed extends AuthException {
  const AuthEmailNotConfirmed([String? m])
      : super(m ?? 'Please confirm your email address', 403);
}

final class AuthUserAlreadyExists extends AuthException {
  const AuthUserAlreadyExists([String? m])
      : super(m ?? 'An account with this email already exists', 409);
}

final class AuthRateLimitExceeded extends AuthException {
  const AuthRateLimitExceeded([String? m])
      : super(m ?? 'Too many requests, please try again later', 429);
}
