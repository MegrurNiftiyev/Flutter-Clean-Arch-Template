import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = Status.Initial,
    this.errorMessage,
  });

  final Status status;
  final String? errorMessage;

  ForgotPasswordState copyWith({
    Status? status,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
