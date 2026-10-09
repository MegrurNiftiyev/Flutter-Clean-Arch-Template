import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/helpers/result.dart';
import '../../../../../domain/usecases/auth/forgot_password_use_case.dart';
import '../../../../../domain/usecases/auth/verify_otp_use_case.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  VerifyOtpCubit(this.verifyOtpUseCase, this.forgotPasswordUseCase)
      : super(const VerifyOtpState());

  Future<void> verifyOtp(String email, String otpCode) async {
    emit(state.copyWith(status: Status.loading));
    final result = await verifyOtpUseCase(email, otpCode);
    result
        .onSuccess((token) =>
            emit(state.copyWith(status: Status.success, resetToken: token)))
        .onError((e) => emit(state.copyWith(status: Status.failure, errorMessage: e.message)));
  }

  Future<void> resendOtp(String email) async {
    emit(state.copyWith(status: Status.loading));
    final result = await forgotPasswordUseCase(email);
    result
        .onSuccess((_) => emit(state.copyWith(status: Status.initial)))
        .onError((e) => emit(state.copyWith(status: Status.failure, errorMessage: e.message)));
  }
}
