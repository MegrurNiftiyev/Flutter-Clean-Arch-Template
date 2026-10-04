import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/base_exception.dart';

class VerifyOtpState extends Equatable {
  final Status status;
  final BaseException? exception;
  final String? resetToken;

  const VerifyOtpState({
    this.status = Status.initial,
    this.exception,
    this.resetToken,
  });

  VerifyOtpState copyWith({
    Status? status,
    BaseException? exception,
    String? resetToken,
  }) {
    return VerifyOtpState(
      status: status ?? this.status,
      exception: exception,
      resetToken: resetToken ?? this.resetToken,
    );
  }

  @override
  List<Object?> get props => [status, exception, resetToken];
}
