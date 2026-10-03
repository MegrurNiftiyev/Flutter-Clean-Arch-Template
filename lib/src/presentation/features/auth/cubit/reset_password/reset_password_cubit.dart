import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/usecases/auth/login_use_case.dart';
import '../../../../../domain/usecases/auth/reset_password_use_case.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit({
    required this.resetPasswordUseCase,
    required this.loginUseCase,
  }) : super(const ResetPasswordState());

  final ResetPasswordUseCase resetPasswordUseCase;
  final LoginUseCase loginUseCase;

  Future<void> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
  }) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      await resetPasswordUseCase(
        resetToken: resetToken,
        newPassword: newPassword,
      );
      // Seamlessly log in with email and the newly set password
      final user = await loginUseCase(
        email: email,
        password: newPassword,
      );
      emit(state.copyWith(status: Status.Success, user: user));
    } catch (e) {
      emit(state.copyWith(status: Status.Failure, errorMessage: e.toString()));
    }
  }
}
