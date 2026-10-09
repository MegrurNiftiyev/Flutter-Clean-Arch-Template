import 'package:flutter/material.dart';
import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.text,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: AppPaddings.h16,
      leading: icon != null
          ? Icon(
              icon,
              size: AppIconSizes.s24,
              color: selected
                  ? AppColors.primary
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            )
          : null,
      title: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: selected
              ? AppColors.primary
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: selected
          ? Icon(
              Icons.check_rounded,
              size: AppIconSizes.s24,
              color: AppColors.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
