import 'package:equatable/equatable.dart';

import '../../../../../core/enums/status.dart';

class RegisterState extends Equatable {
  final Status status;
  final String? errorMessage;

  const RegisterState({
    this.status = Status.initial,
    this.errorMessage,
  });

  RegisterState copyWith({
    Status? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
