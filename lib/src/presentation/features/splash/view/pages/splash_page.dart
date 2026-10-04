import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch_template/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/splash_target.dart';
import '../../../../../core/router/app_routes.dart';
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
          case null:
            break;
        }
      },
      child: Scaffold(
        body: Center(
          child: Assets.images.logo.image(
            width: 120.r,
            height: 120.r,
          ),
        ),
      ),
    );
  }
}
