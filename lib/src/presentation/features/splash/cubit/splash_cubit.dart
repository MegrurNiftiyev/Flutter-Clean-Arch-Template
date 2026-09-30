import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/user_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.userRepository,
  }) : super(const SplashState());

  final IUserRepository userRepository;
}
