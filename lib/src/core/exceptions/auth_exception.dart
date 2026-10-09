import 'base_exception.dart';

sealed class AuthException extends BaseException {
  const AuthException(super.message, super.statusCode);

  static final Map<String, AuthException Function(String?)> expected = {
    'VALIDATION_ERROR': AuthValidationError.new,
    'HEADER_*_INVALID': AuthValidationError.new,
    'MALFORMED_JSON': AuthValidationError.new,
    'OTP_INVALID': AuthValidationError.new,
    'OTP_EXPIRED': AuthValidationError.new,
    'AUTH_INVALID_CREDENTIALS': AuthInvalidCredentials.new,
    'AUTH_ACCOUNT_DISABLED': AuthEmailNotConfirmed.new, // mapping disabled account to email not confirmed for now, could be separate
    'USER_EMAIL_ALREADY_EXISTS': AuthUserAlreadyExists.new,
    'RATE_LIMIT_EXCEEDED': AuthRateLimitExceeded.new,
    'OTP_RESEND_COOLDOWN': AuthRateLimitExceeded.new,
    'OTP_TOO_MANY_ATTEMPTS': AuthRateLimitExceeded.new,
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
