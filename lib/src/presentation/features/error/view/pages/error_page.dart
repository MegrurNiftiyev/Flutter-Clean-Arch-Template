import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../widgets/custom_button.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.error,
  });

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('general.error'.tr()),
      ),
      body: Padding(
        padding: AppPaddings.page,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: AppIconSizes.s80,
              color: Theme.of(context).colorScheme.error,
            ),
            AppSpaces.v24,
            Text(
              'general.error'.tr(),
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            AppSpaces.v12,
            Text(
              error ?? 'general.error_default'.tr(),
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            AppSpaces.v32,
            CustomButton(
              text: 'home.title'.tr(),
              onPressed: () {
                context.goNamed(AppRoute.home.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
