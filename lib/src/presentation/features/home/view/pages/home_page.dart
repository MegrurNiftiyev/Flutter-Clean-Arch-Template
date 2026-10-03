import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home.title'.tr(),
          style: AppTextStyles.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_outlined,
              size: AppIconSizes.s24,
              color: AppColors.primary,
            ),
            onPressed: () {
              context.pushNamed(AppRoute.settings.name);
            },
          ),
        ],
      ),
      body: Padding(
        padding: AppPaddings.page,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_outlined,
                size: AppIconSizes.s80,
                color: AppColors.primary,
              ),
              AppSpaces.v16,
              Text(
                'home.welcome'.tr(),
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
