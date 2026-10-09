import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_arch_template/gen/assets.gen.dart';
import '../../../../../core/constants/durations.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/radii.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../domain/models/onboarding_item_model.dart';
import '../../../../widgets/custom_button.dart';
import '../../cubit/onboarding_cubit.dart';
import '../../cubit/onboarding_state.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OnboardingCubit>(),
      child: const OnboardingView(),
    );
  }
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  final pageController = PageController();

  List<OnboardingItemModel> get items => [
        OnboardingItemModel(
          title: 'onboarding.title_1'.tr(),
          description: 'onboarding.desc_1'.tr(),
          image: Assets.images.onboarding1,
        ),
        OnboardingItemModel(
          title: 'onboarding.title_2'.tr(),
          description: 'onboarding.desc_2'.tr(),
          image: Assets.images.onboarding2,
        ),
        OnboardingItemModel(
          title: 'onboarding.title_3'.tr(),
          description: 'onboarding.desc_3'.tr(),
          image: Assets.images.onboarding3,
        ),
      ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onNextPage() {
    final cubit = context.read<OnboardingCubit>();
    final currentPage = cubit.state.currentPage;
    if (currentPage < items.length - 1) {
      pageController.nextPage(
        duration: AppDurations.short,
        curve: Curves.easeInOut,
      );
    } else {
      cubit.completeOnboarding();
    }
  }

  void onSkip() {
    context.read<OnboardingCubit>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onSkip,
            child: Text(
              'onboarding.skip'.tr(),
              style:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            context.goNamed(AppRoute.login.name);
          }
        },
        builder: (context, state) {
          final isLastPage = state.currentPage == items.length - 1;

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: (index) {
                    context.read<OnboardingCubit>().onPageChanged(index);
                  },
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: AppPaddings.a16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          item.image.image(
                            width: 180.r,
                            height: 180.r,
                            fit: BoxFit.contain,
                          ),
                          AppSpaces.v32,
                          Text(
                            item.title,
                            style: AppTextStyles.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          AppSpaces.v16,
                          Text(
                            item.description,
                            style: AppTextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    items.length,
                    (index) => AnimatedContainer(
                      duration: AppDurations.fast,
                      margin: AppPaddings.h4,
                      height: 8.h,
                      width: state.currentPage == index ? 24.w : 8.w,
                      decoration: BoxDecoration(
                        color: state.currentPage == index
                            ? AppColors.primary
                            : AppColors.disabled,
                        borderRadius: AppRadii.borderR4,
                      ),
                    ),
                  ),
                ),
                AppSpaces.v32,
                Padding(
                  padding: AppPaddings.a16,
                  child: CustomButton(
                    text: isLastPage
                        ? 'onboarding.get_started'.tr()
                        : 'onboarding.next'.tr(),
                    isLoading: state.status == Status.loading,
                    onPressed: onNextPage,
                  ),
                ),
                AppSpaces.v16,
              ],
          );
        },
      ),
    );
  }
}
