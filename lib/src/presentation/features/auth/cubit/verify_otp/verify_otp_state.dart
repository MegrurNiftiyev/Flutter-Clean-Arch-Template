import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';

class VerifyOtpState extends Equatable {
  final Status status;
  final String? errorMessage;
  final String? resetToken;

  const VerifyOtpState({
    this.status = Status.initial,
    this.errorMessage,
    this.resetToken,
  });

  VerifyOtpState copyWith({
    Status? status,
    String? errorMessage,
    String? resetToken,
  }) {
    return VerifyOtpState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      resetToken: resetToken ?? this.resetToken,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, resetToken];
}
