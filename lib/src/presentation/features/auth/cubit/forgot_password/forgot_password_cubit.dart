import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/helpers/result.dart';
import '../../../../../domain/usecases/auth/forgot_password_use_case.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit(this.forgotPasswordUseCase)
      : super(const ForgotPasswordState());

  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(status: Status.loading));
    final result = await forgotPasswordUseCase(email);
    result
        .onSuccess((_) => emit(state.copyWith(status: Status.success)))
        .onError((e) => emit(state.copyWith(status: Status.failure, errorMessage: e.message)));
  }
}
