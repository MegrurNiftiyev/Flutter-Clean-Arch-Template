import 'package:flutter/material.dart';

import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';

class DemoScreen1Page extends StatelessWidget {
  const DemoScreen1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreen1View();
  }
}

class DemoScreen1View extends StatelessWidget {
  const DemoScreen1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demo 1',
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
                Icons.widgets_outlined,
                size: AppIconSizes.s80,
                color: AppColors.primary,
              ),
              AppSpaces.v16,
              Text(
                'Demo Feature 1',
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
