import 'package:flutter/material.dart';

import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';

class DemoScreen2Page extends StatelessWidget {
  const DemoScreen2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreen2View();
  }
}

class DemoScreen2View extends StatelessWidget {
  const DemoScreen2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demo 2',
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: Padding(
        padding: AppPaddings.a16,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.dashboard_outlined,
                size: AppIconSizes.s80,
                color: AppColors.primary,
              ),
              AppSpaces.v16,
              Text(
                'Demo Feature 2',
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
