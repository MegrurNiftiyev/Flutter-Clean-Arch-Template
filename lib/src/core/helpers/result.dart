import '../exceptions/base_exception.dart';
import '../exceptions/network_exceptions.dart';

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final BaseException exception;

  const Failure(this.exception);
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  Result<T> onSuccess(void Function(T data) action) {
    if (this case Success<T>(:final data)) action(data);
    return this;
  }

  Result<T> onError(void Function(BaseException exception) action) {
    if (this case Failure<T>(:final exception)) action(exception);
    return this;
  }

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(BaseException exception) onError,
  ) {
    return switch (this) {
      Success<T>(:final data) => onSuccess(data),
      Failure<T>(:final exception) => onError(exception),
    };
  }
}

Future<Result<T>> safeCall<T>(Future<T> Function() block) async {
  try {
    return Success(await block());
  } on BaseException catch (e) {
    return Failure(e);
  } catch (e) {
    return Failure(UnknownException(e.toString()));
  }
}
