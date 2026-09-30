import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = Status.Initial,
  });

  final Status status;

  LoginState copyWith({
    Status? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
