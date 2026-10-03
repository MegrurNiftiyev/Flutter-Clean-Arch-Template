import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/usecases/auth/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginUseCase,
  }) : super(const LoginState());

  final LoginUseCase loginUseCase;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );
      emit(state.copyWith(status: Status.Success, user: user));
    } catch (e) {
      emit(state.copyWith(status: Status.Failure, errorMessage: e.toString()));
    }
  }
}
