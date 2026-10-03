import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.status = Status.Initial,
    this.resetToken,
    this.errorMessage,
  });

  final Status status;
  final String? resetToken;
  final String? errorMessage;

  VerifyOtpState copyWith({
    Status? status,
    String? resetToken,
    String? errorMessage,
  }) {
    return VerifyOtpState(
      status: status ?? this.status,
      resetToken: resetToken ?? this.resetToken,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, resetToken, errorMessage];
}
