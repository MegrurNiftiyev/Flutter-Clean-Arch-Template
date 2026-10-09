import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/helpers/result.dart';
import '../../../../../domain/usecases/auth/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: Status.loading));
    final result = await loginUseCase(email, password);
    result
        .onSuccess((user) => emit(state.copyWith(status: Status.success)))
        .onError((e) => emit(state.copyWith(status: Status.failure, errorMessage: e.message)));
  }
}
