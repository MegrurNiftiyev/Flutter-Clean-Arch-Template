import 'base_exception.dart';

sealed class UserException extends BaseException {
  const UserException(super.message, [super.statusCode]);

  static final Map<int, UserException Function(String?)> expected = {
    400: UserValidationError.new,
    404: UserNotFound.new,
  };
}

final class UserNotFound extends UserException {
  const UserNotFound([String? m]) : super(m ?? 'User not found', 404);
}

final class UserValidationError extends UserException {
  const UserValidationError([String? m]) : super(m ?? 'Invalid user data', 400);
}
