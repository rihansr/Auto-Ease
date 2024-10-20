import 'package:flutter/material.dart';

class Badges extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  final int count;
  const Badges({
    super.key,
    this.isVisible = false,
    required this.child,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Badge.count(
      count: count,
      textStyle: theme.textTheme.labelMedium?.copyWith(
        fontSize: 11,
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      isLabelVisible: isVisible && count != 0,
      alignment: const Alignment(1, -0.75),
      child: child,
    );
  }
}
