import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.authRepository,
  }) : super(const RegisterState());

  final IAuthRepository authRepository;
}
