import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/helpers/result.dart';
import '../../../../../domain/usecases/auth/reset_password_use_case.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit(this.resetPasswordUseCase)
      : super(const ResetPasswordState());

  Future<void> resetPassword(String resetToken, String newPassword) async {
    emit(state.copyWith(status: Status.loading));
    final result = await resetPasswordUseCase(resetToken, newPassword);
    result
        .onSuccess((_) => emit(state.copyWith(status: Status.success)))
        .onError((e) => emit(state.copyWith(status: Status.failure, errorMessage: e.message)));
  }
}
