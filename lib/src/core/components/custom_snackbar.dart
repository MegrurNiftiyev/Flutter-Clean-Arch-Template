import 'package:flutter/material.dart';
import '../constants/durations.dart';
import '../constants/icon_sizes.dart';
import '../constants/paddings.dart';
import '../constants/radii.dart';
import '../constants/spaces.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

enum SnackBarType { success, alert, danger }

abstract class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    String? title,
    SnackBarType type = SnackBarType.success,
    IconData? icon,
    Duration? duration,
  }) {
    final effectiveColor = _getColor(type);
    final effectiveIcon = icon ?? _getIcon(type);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: effectiveColor,
        duration: duration ?? AppDurations.snackBar,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.borderR12,
        ),
        margin: AppPaddings.all16,
        content: Row(
          children: [
            Icon(
              effectiveIcon,
              size: AppIconSizes.s24,
              color: AppColors.textLight,
            ),
            AppSpaces.h12,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null && title.isNotEmpty) ...[
                    Text(
                      title,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    AppSpaces.v4,
                  ],
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
    String? title,
    IconData? icon,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      title: title,
      type: SnackBarType.success,
      icon: icon,
      duration: duration,
    );
  }

  static void showAlert({
    required BuildContext context,
    required String message,
    String? title,
    IconData? icon,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      title: title,
      type: SnackBarType.alert,
      icon: icon,
      duration: duration,
    );
  }

  static void showDanger({
    required BuildContext context,
    required String message,
    String? title,
    IconData? icon,
    Duration? duration,
  }) {
    show(
      context: context,
      message: message,
      title: title,
      type: SnackBarType.danger,
      icon: icon,
      duration: duration,
    );
  }

  static Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return AppColors.success;
      case SnackBarType.alert:
        return AppColors.warning;
      case SnackBarType.danger:
        return AppColors.error;
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_rounded;
      case SnackBarType.alert:
        return Icons.warning_amber_rounded;
      case SnackBarType.danger:
        return Icons.error_outline_rounded;
    }
  }
}
