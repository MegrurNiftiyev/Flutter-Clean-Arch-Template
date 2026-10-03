import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../domain/usecases/auth/register_use_case.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.registerUseCase,
  }) : super(const RegisterState());

  final RegisterUseCase registerUseCase;

  Future<void> register({
    required String email,
    required String password,
    String? name,
  }) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      final user = await registerUseCase(
        email: email,
        password: password,
        name: name,
      );
      emit(state.copyWith(status: Status.Success, user: user));
    } catch (e) {
      emit(state.copyWith(status: Status.Failure, errorMessage: e.toString()));
    }
  }
}
