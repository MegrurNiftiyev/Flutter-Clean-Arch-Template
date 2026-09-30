import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = Status.Initial,
  });

  final Status status;

  RegisterState copyWith({
    Status? status,
  }) {
    return RegisterState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
