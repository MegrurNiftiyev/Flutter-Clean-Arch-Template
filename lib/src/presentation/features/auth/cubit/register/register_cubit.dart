import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/usecases/auth/register_use_case.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.registerUseCase,
  }) : super(const RegisterState());

  final RegisterUseCase registerUseCase;
}
