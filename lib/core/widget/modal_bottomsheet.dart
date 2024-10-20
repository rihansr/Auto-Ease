import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../shared/strings.dart';
import '../shared/styles.dart';
import 'button_widget.dart';

class ModalBottomSheet extends StatelessWidget {
  final Text title;
  final Text? subtitle;
  final Widget? content;
  final String? primaryButtonLabel;
  final Color? primaryButtonColor;
  final Function()? onPrimaryButtonPressed;
  final String? secondaryButtonLabel;
  final Function()? onSecondaryButtonPressed;

  const ModalBottomSheet({
    super.key,
    required this.title,
    this.subtitle,
    this.content,
    this.primaryButtonLabel,
    this.primaryButtonColor,
    this.onPrimaryButtonPressed,
    this.secondaryButtonLabel,
    this.onSecondaryButtonPressed,
  });

  static show(BuildContext context, Widget Function(BuildContext) builder) =>
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: builder,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackdropFilter(
      filter: style.defaultBlur,
      child: Column(
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
                      Button(
                        label: primaryButtonLabel ?? string.of(context).okay,
                        margin: const EdgeInsets.all(0),
                        background: primaryButtonColor,
                        onPressed: () {
                          onPrimaryButtonPressed?.call();
                          context.pop();
                        },
                      ),
                      Button(
                        label:
                            secondaryButtonLabel ?? string.of(context).cancel,
                        background: Colors.transparent,
                        fontColor: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                        onPressed: () {
                          onSecondaryButtonPressed?.call();
                          context.pop();
                        },
                      ),
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
      ),
    );
  }
}
