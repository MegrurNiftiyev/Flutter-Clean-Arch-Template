import 'package:equatable/equatable.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/models/user_model.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.status = Status.Initial,
    this.user,
    this.errorMessage,
  });

  final Status status;
  final UserModel? user;
  final String? errorMessage;

  ResetPasswordState copyWith({
    Status? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
