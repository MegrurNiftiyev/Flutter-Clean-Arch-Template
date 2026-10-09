import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/paddings.dart';
import '../../core/constants/spaces.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class CustomIconHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CustomIconHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: AppPaddings.a24,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(26), // 0.1 * 255
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 48.r,
            color: AppColors.primary,
          ),
        ),
        AppSpaces.v24,
        Text(
          title,
          style: AppTextStyles.titleLarge,
          textAlign: TextAlign.center,
        ),
        AppSpaces.v8,
        Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
