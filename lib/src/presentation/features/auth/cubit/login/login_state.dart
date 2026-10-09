import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/auth_exception.dart';
import '../../../../../domain/models/user_model.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = Status.initial,
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
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
