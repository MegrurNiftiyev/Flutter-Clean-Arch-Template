import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/durations.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/text_styles.dart';

class CustomOtpField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final bool hasError;
  final int length;

  const CustomOtpField({
    super.key,
    required this.controller,
    this.onCompleted,
    this.hasError = false,
    this.length = 6,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: AppDurations.medium,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(
        CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));

    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(CustomOtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasError && !oldWidget.hasError) {
      _shakeController.forward(from: 0.0);
    }
  }

  void _onTextChanged() {
    if (mounted) setState(() {});
    if (widget.controller.text.length == widget.length) {
      widget.onCompleted?.call(widget.controller.text);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _focusNode.dispose();
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
          SystemChannels.textInput.invokeMethod('TextInput.show');
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Hidden text field
            Opacity(
              opacity: 0.0,
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: widget.length,
                autofocus: true,
                showCursor: false,
                decoration: const InputDecoration(counterText: ''),
              ),
            ),
            // Visible boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.length, (index) {
                final text = widget.controller.text;
                final isFocused = _focusNode.hasFocus && text.length == index;
                // If it's the last box and it's filled and focused
                final isLastBoxFocused = _focusNode.hasFocus &&
                    index == widget.length - 1 &&
                    text.length == widget.length;
                final char = index < text.length ? text[index] : '';
                final isCurrentFocus = isFocused || isLastBoxFocused;

                return Container(
                  width: 48.w,
                  height: 56.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: widget.hasError
                          ? AppColors.error
                          : isCurrentFocus
                              ? AppColors.primary
                              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    char,
                    style: AppTextStyles.titleLarge,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
