import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final Widget image;
  final String? title;
  final String? message;
  final bool alignCenter;
  final EdgeInsetsGeometry margin;
  const EmptyWidget({
    super.key,
    required this.image,
    this.title,
    this.message,
    this.alignCenter = false,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final child = Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          image,
          if(title != null || message != null) const SizedBox(height: 16),
          if (title != null) Text(
              title!,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          if(title != null) const SizedBox(height: 6),
          if (message != null) Text(
              message!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
    return alignCenter
        ? Center(child: child)
        : child;
  }
}
