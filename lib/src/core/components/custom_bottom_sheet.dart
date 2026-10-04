import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/paddings.dart';
import '../constants/radii.dart';
import '../constants/spaces.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.showDragHandle = true,
  });

  final Widget child;
  final String? title;
  final bool showDragHandle;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool showDragHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomBottomSheet(
        title: title,
        showDragHandle: showDragHandle,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.r24),
        ),
      ),
      padding: AppPaddings.a16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDragHandle) ...[
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.disabled,
                  borderRadius: AppRadii.borderR4,
                ),
              ),
            ),
            AppSpaces.v16,
          ],
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: AppTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),
            AppSpaces.v16,
          ],
          Flexible(child: child),
        ],
      ),
    );
  }
}
