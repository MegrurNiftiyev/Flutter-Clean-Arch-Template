import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/usecases/auth/forgot_password_use_case.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required this.forgotPasswordUseCase,
  }) : super(const ForgotPasswordState());

  final ForgotPasswordUseCase forgotPasswordUseCase;

  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      await forgotPasswordUseCase(email: email);
      emit(state.copyWith(status: Status.Success));
    } catch (e) {
      emit(state.copyWith(status: Status.Failure, errorMessage: e.toString()));
    }
  }
}
