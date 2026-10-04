import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/base_exception.dart';

class ResetPasswordState extends Equatable {
  final Status status;
  final BaseException? exception;

  const ResetPasswordState({
    this.status = Status.initial,
    this.exception,
  });

  ResetPasswordState copyWith({
    Status? status,
    BaseException? exception,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [status, exception];
}
