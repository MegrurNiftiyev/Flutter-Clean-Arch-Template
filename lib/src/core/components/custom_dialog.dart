import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/icon_sizes.dart';
import '../constants/paddings.dart';
import '../constants/radii.dart';
import '../constants/spaces.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.isDanger = false,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDanger;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? subtitle,
    IconData? icon,
    Color? iconColor,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDanger = false,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: title,
        subtitle: subtitle,
        icon: icon,
        iconColor: iconColor,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDanger: isDanger,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? (isDanger ? AppColors.error : AppColors.primary);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.borderR16,
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor ??
          Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: AppPaddings.all24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: AppIconSizes.s48,
                color: effectiveIconColor,
              ),
              AppSpaces.v16,
            ],
            Text(
              title,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null && subtitle!.isNotEmpty) ...[
              AppSpaces.v8,
              Text(
                subtitle!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            AppSpaces.v24,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadii.borderR12,
                      ),
                      padding: AppPaddings.v14,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel?.call();
                    },
                    child: Text(
                      cancelText ?? 'general.cancel'.tr(),
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                AppSpaces.h12,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDanger ? AppColors.error : AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadii.borderR12,
                      ),
                      padding: AppPaddings.v14,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                    child: Text(
                      confirmText ?? 'general.ok'.tr(),
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
