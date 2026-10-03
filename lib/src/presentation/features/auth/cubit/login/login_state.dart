import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/models/user_model.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = Status.Initial,
    this.user,
    this.errorMessage,
  });

  final Status status;
  final UserModel? user;
  final String? errorMessage;

  LoginState copyWith({
    Status? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
