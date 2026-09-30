import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authRepository,
  }) : super(const LoginState());

  final IAuthRepository authRepository;
}
