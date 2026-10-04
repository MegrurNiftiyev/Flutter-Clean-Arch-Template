import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.texts,
    required this.onTap,
    this.underline = false,
    this.normalStyle,
    this.clickableStyle,
  }) : assert(
          texts.length >= 2 && texts.length <= 3,
          'texts list must contain 2 or 3 items: [normal, clickable, optionalNormal]',
        );

  final List<String> texts;
  final VoidCallback onTap;
  final bool underline;
  final TextStyle? normalStyle;
  final TextStyle? clickableStyle;

  @override
  Widget build(BuildContext context) {
    final defaultNormalStyle = normalStyle ?? AppTextStyles.bodyMedium;
    final defaultClickableStyle =
        (clickableStyle ?? AppTextStyles.bodyMedium).copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: defaultNormalStyle,
        children: [
          TextSpan(text: '${texts[0]} '),
          TextSpan(
            text: texts[1],
            style: defaultClickableStyle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
          if (texts.length > 2) TextSpan(text: ' ${texts[2]}'),
        ],
      ),
    );
  }
}
