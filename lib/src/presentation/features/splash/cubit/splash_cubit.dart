import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/cache_keys.dart';
import '../../../../core/enums/splash_target.dart';
import '../../../../core/enums/status.dart';
import '../../../../core/helpers/result.dart';
import '../../../../core/managers/cache_manager.dart';
import '../../../../core/managers/encrypted_cache_manager.dart';
import '../../../../domain/usecases/user/get_user_profile_use_case.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.cacheManager,
    required this.encryptedCacheManager,
    required this.getUserProfileUseCase,
  }) : super(const SplashState());

  final CacheManager cacheManager;
  final EncryptedCacheManager encryptedCacheManager;
  final GetUserProfileUseCase getUserProfileUseCase;

  Future<void> checkAppStatus() async {
    emit(state.copyWith(status: Status.loading));

    final isFirstLaunch = !(await cacheManager.get<bool>(
            CacheKeys.boxName, CacheKeys.onboardingCompleted) ??
        false);

    if (isFirstLaunch) {
      emit(state.copyWith(
        status: Status.success,
        target: SplashTarget.onboarding,
      ));
      return;
    }

    final token = await encryptedCacheManager.read(CacheKeys.accessTokenKey);
    if (token == null || token.isEmpty) {
      emit(state.copyWith(
        status: Status.success,
        target: SplashTarget.unauthenticated,
      ));
      return;
    }

    final profileResult = await getUserProfileUseCase();
    profileResult
        .onSuccess((user) => emit(state.copyWith(
              status: Status.success,
              target: SplashTarget.authenticated,
            )))
        .onError((e) => emit(state.copyWith(
              status: Status.success,
              target: SplashTarget.unauthenticated,
            )));
  }
}
