import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/helpers/result.dart';
import '../../../../../domain/usecases/auth/verify_otp_use_case.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpCubit(this.verifyOtpUseCase) : super(const VerifyOtpState());

  Future<void> verifyOtp(String email, String otpCode) async {
    emit(state.copyWith(status: Status.loading));
    final result = await verifyOtpUseCase(email, otpCode);
    result.fold(
      (token) =>
          emit(state.copyWith(status: Status.success, resetToken: token)),
      (e) => emit(state.copyWith(status: Status.failure, exception: e)),
    );
  }
}
