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
    final theme = Theme.of(context);
    final defaultNormalStyle = normalStyle ??
        theme.textTheme.bodyMedium ??
        AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurface);
    final defaultClickableStyle =
        (clickableStyle ?? defaultNormalStyle).copyWith(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
    );

    return Text.rich(
      TextSpan(
        style: defaultNormalStyle,
        children: [
          TextSpan(text: '${texts[0]} '),
          TextSpan(
            text: texts[1],
            style: defaultClickableStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                FocusManager.instance.primaryFocus?.unfocus();
                onTap();
              },
          ),
          if (texts.length > 2) TextSpan(text: ' ${texts[2]}'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
