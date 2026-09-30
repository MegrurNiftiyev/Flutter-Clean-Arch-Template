import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/user/get_user_profile_use_case.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.getUserProfileUseCase,
  }) : super(const SplashState());

  final GetUserProfileUseCase getUserProfileUseCase;
}
