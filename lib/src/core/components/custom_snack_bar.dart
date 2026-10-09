import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/durations.dart';
import '../constants/icon_sizes.dart';
import '../constants/paddings.dart';
import '../enums/event_status.dart';
import '../extensions/event_status_extensions.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

abstract class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    EventStatus type = EventStatus.info,
    IconData? icon,
    Color? backgroundColor,
    VoidCallback? onAction,
    String? actionLabel,
    Duration? duration,
  }) {
    final effectiveIcon = icon ?? type.icon;
    final effectiveColor = backgroundColor ?? type.color;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration ?? AppDurations.s3,
          backgroundColor: effectiveColor,
          behavior: SnackBarBehavior.floating,
          margin: AppPaddings.a16,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          content: Row(
            children: [
              Icon(
                effectiveIcon,
                color: AppColors.textLight,
                size: AppIconSizes.s24,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
              ),
            ],
          ),
          action: onAction != null
              ? SnackBarAction(
                  label: actionLabel ?? 'general.retry'.tr(),
                  textColor: AppColors.textLight,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }

  static void showError(
    BuildContext context, {
    required String message,
    VoidCallback? onRetry,
  }) {
    show(
      context,
      message: message,
      type: EventStatus.error,
      onAction: onRetry,
      actionLabel: onRetry != null ? 'general.retry'.tr() : null,
    );
  }
}
