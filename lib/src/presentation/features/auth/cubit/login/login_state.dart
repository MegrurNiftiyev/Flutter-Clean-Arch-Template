import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/base_exception.dart';

class LoginState extends Equatable {
  final Status status;
  final BaseException? exception;

  const LoginState({
    this.status = Status.initial,
    this.exception,
  });

  LoginState copyWith({
    Status? status,
    BaseException? exception,
  }) {
    return LoginState(
      status: status ?? this.status,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
