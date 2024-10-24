import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class ModalBottomSheet extends StatelessWidget {
  final Widget title;
  final Text? subtitle;
  final Widget? content;
  final List<Widget> actions;

  const ModalBottomSheet({
    super.key,
    required this.title,
    this.subtitle,
    this.content,
    this.actions = const [],
  });

  static show(BuildContext context, Widget Function(BuildContext) builder) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: builder,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DefaultTextStyle(
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 8),
                      DefaultTextStyle(
                        style: theme.textTheme.labelMedium!,
                        child: subtitle!,
                      ),
                    ],
                    if (content != null) ...[
                      const SizedBox(height: 24),
                      content!,
                    ],
                    const SizedBox(height: 32),
                    ...actions,
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Transform.rotate(
                  angle: 0.785398,
                  child: const Icon(Iconsax.add, size: 28),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
