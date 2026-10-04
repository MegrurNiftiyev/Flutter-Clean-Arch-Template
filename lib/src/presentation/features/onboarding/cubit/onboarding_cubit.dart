import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/cache_keys.dart';
import '../../../../core/enums/status.dart';
import '../../../../core/managers/cache_manager.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required this.cacheManager,
  }) : super(const OnboardingState());

  final CacheManager cacheManager;

  void onPageChanged(int index) {
    emit(state.copyWith(currentPage: index));
  }

  Future<void> completeOnboarding() async {
    emit(state.copyWith(status: Status.loading));
    try {
      await cacheManager.put<bool>(
        CacheKeys.boxName,
        CacheKeys.onboardingCompleted,
        true,
      );
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
