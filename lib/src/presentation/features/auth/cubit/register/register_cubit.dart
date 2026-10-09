
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/status.dart';
import '../../../../../core/helpers/result.dart';
import '../../../../../domain/usecases/auth/register_use_case.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(const RegisterState());

  Future<void> register({required String email, required String password, String? name}) async {
    emit(state.copyWith(status: Status.loading));
    final result = await registerUseCase(email: email, password: password, name: name);
    result
        .onSuccess((user) => emit(state.copyWith(status: Status.success)))
        .onError((e) => emit(state.copyWith(status: Status.failure, errorMessage: e.message)));
  }
}