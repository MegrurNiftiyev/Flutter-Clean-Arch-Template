import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/base_exception.dart';

class ForgotPasswordState extends Equatable {
  final Status status;
  final BaseException? exception;

  const ForgotPasswordState({
    this.status = Status.initial,
    this.exception,
  });

  ForgotPasswordState copyWith({
    Status? status,
    BaseException? exception,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
