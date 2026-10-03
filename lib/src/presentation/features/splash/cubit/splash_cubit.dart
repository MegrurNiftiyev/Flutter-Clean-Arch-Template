import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/constants/durations.dart';
import '../../../../core/enums/status.dart';
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
    emit(state.copyWith(status: Status.Loading));

    // Give splash screen a smooth minimum display time
    await Future.delayed(AppDurations.splashDelay);

    try {
      // 1. Check if Onboarding is completed
      final isOnboardingCompleted = await cacheManager.get<bool>(
        CacheKeys.boxName,
        CacheKeys.onboardingCompleted,
        defaultValue: false,
      );

      if (isOnboardingCompleted != true) {
        emit(state.copyWith(
          status: Status.Success,
          target: SplashTarget.onboarding,
        ));
        return;
      }

      // 2. Check if Auth Token exists in Encrypted Storage
      final token = await encryptedCacheManager.read(CacheKeys.accessTokenKey);
      if (token == null || token.isEmpty) {
        emit(state.copyWith(
          status: Status.Success,
          target: SplashTarget.unauthenticated,
        ));
        return;
      }

      // 3. Verify user authentication with GetUserProfileUseCase
      try {
        await getUserProfileUseCase(userId: 'current_user');
        emit(state.copyWith(
          status: Status.Success,
          target: SplashTarget.authenticated,
        ));
      } catch (_) {
        emit(state.copyWith(
          status: Status.Success,
          target: SplashTarget.unauthenticated,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        status: Status.Success,
        target: SplashTarget.unauthenticated,
      ));
    }
  }
}
