import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/usecases/auth/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginUseCase,
  }) : super(const LoginState());

  final LoginUseCase loginUseCase;
}
