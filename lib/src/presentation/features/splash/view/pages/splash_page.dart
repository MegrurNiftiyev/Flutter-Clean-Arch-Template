import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../cubit/splash_cubit.dart';
import '../../cubit/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..checkAppStatus(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state.target) {
          case SplashTarget.onboarding:
            context.goNamed(AppRoute.onboarding.name);
            break;
          case SplashTarget.authenticated:
            context.goNamed(AppRoute.home.name);
            break;
          case SplashTarget.unauthenticated:
            context.goNamed(AppRoute.login.name);
            break;
          case SplashTarget.initial:
            break;
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flutter_dash_rounded,
                size: AppIconSizes.s80,
                color: AppColors.primary,
              ),
              AppSpaces.v16,
              Text(
                'splash.title'.tr(),
                style: AppTextStyles.titleLarge,
              ),
              AppSpaces.v24,
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
