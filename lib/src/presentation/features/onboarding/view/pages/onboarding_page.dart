import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/durations.dart';
import '../../../../../core/constants/icon_sizes.dart';
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
          icon: Icons.architecture_rounded,
        ),
        OnboardingItemModel(
          title: 'onboarding.title_2'.tr(),
          description: 'onboarding.desc_2'.tr(),
          icon: Icons.rocket_launch_rounded,
        ),
        OnboardingItemModel(
          title: 'onboarding.title_3'.tr(),
          description: 'onboarding.desc_3'.tr(),
          icon: Icons.check_circle_outline_rounded,
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
        duration: AppDurations.normal,
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
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.status == Status.Success) {
            context.goNamed(AppRoute.login.name);
          }
        },
        builder: (context, state) {
          final isLastPage = state.currentPage == items.length - 1;

          return Padding(
            padding: AppPaddings.page,
            child: Column(
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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: AppIconSizes.s100,
                            color: AppColors.primary,
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
                CustomButton(
                  text: isLastPage ? 'onboarding.get_started'.tr() : 'onboarding.next'.tr(),
                  isLoading: state.status == Status.Loading,
                  onPressed: onNextPage,
                ),
                AppSpaces.v16,
              ],
            ),
          );
        },
      ),
    );
  }
}
