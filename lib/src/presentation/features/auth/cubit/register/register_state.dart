import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/base_exception.dart';

class RegisterState extends Equatable {
  final Status status;
  final BaseException? exception;

  const RegisterState({
    this.status = Status.initial,
    this.exception,
  });

  RegisterState copyWith({
    Status? status,
    BaseException? exception,
  }) {
    return RegisterState(
      status: status ?? this.status,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
