import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/paddings.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.disabledColor,
    this.textColor,
    this.textStyle,
    this.borderRadius,
    this.height,
    this.width,
    this.padding,
    this.enabled = true,
  });

  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? disabledColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? 48.h;
    final buttonWidth = width ?? double.infinity;
    final radius = borderRadius ?? 12.r;
    final isButtonDisabled = !enabled || onPressed == null;

    final effectiveColor = isButtonDisabled && !isLoading
        ? (disabledColor ?? AppColors.disabled)
        : (color ?? AppColors.primary);

    final effectiveTextColor = textColor ?? AppColors.textLight;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: (isButtonDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveColor,
          disabledBackgroundColor: isLoading
              ? (color ?? AppColors.primary)
              : (disabledColor ?? AppColors.disabled),
          foregroundColor: effectiveTextColor,
          padding: padding ?? AppPaddings.buttonContent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 24.r,
                width: 24.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5.w,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : (child ??
                Text(
                  text ?? '',
                  style: (textStyle ?? AppTextStyles.button).copyWith(
                    color: effectiveTextColor,
                  ),
                )),
      ),
    );
  }
}
