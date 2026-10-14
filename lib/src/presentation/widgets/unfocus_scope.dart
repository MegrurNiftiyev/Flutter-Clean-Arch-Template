import 'package:flutter/material.dart';

/// A reusable wrapper widget that dismisses any active input focus
/// and closes the soft keyboard when tapping anywhere outside the input fields.
class UnfocusScope extends StatelessWidget {
  const UnfocusScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
