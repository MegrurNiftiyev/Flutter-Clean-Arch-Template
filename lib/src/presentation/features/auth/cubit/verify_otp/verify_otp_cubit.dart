import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/usecases/auth/verify_otp_use_case.dart';
import 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit({
    required this.verifyOtpUseCase,
  }) : super(const VerifyOtpState());

  final VerifyOtpUseCase verifyOtpUseCase;

  Future<void> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      final token = await verifyOtpUseCase(
        email: email,
        otpCode: otpCode,
      );
      emit(state.copyWith(status: Status.Success, resetToken: token));
    } catch (e) {
      emit(state.copyWith(status: Status.Failure, errorMessage: e.toString()));
    }
  }
}
