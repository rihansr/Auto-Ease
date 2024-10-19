import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../service/navigation_service.dart';
import '../shared/strings.dart';

showNormalDialog({
  BuildContext? context,
  bool dismissible = true,
  String? title,
  String? content,
  String? negativeButtonLabel,
  Function()? onTapNegativeButton,
  String? positiveButtonLabel,
  Function()? onTapPositiveButton,
  Function(dynamic)? onDispose,
}) {
  context ??= navigator.context;
  final theme = Theme.of(context);
  showAdaptiveDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: title == null ? null : Text(title),
      titleTextStyle: theme.textTheme.titleLarge,
      content: content == null ? null : Text(content),
      contentTextStyle: theme.textTheme.bodyMedium,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actions: [
        TextButton(
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
            onTapNegativeButton?.call();
          },
          style: TextButton.styleFrom(
            foregroundColor: theme.hintColor,
            textStyle: theme.textTheme.bodyMedium,
          ),
          child: Text(negativeButtonLabel ?? string.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.selectionClick();
            Navigator.pop(context);
            onTapPositiveButton?.call();
          },
          style: TextButton.styleFrom(
            textStyle: theme.textTheme.titleMedium,
          ),
          child: Text(positiveButtonLabel ?? string.of(context).okay),
        ),
      ],
    ),
  ).then((value) => onDispose?.call(value));
}

showFullScreenDialog({
  BuildContext? context,
  required Widget child,
  Color? backgroundColor,
  bool dismissible = false,
  Object? arguments,
  Function(dynamic)? onDispose,
}) {
  context ??= navigator.context;
  final theme = Theme.of(context);
  showDialog(
    barrierDismissible: dismissible,
    context: context,
    barrierColor: backgroundColor ?? theme.colorScheme.surface,
    useSafeArea: false,
    builder: (context) => ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: child,
    ),
  ).then((value) => onDispose?.call(value));
}
