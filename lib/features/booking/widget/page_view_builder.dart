import 'package:flutter/material.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/widget/card_box_widget.dart';

class PageViewBuilder extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final List<Widget> children;
  final Widget action;

  const PageViewBuilder({
    super.key,
    required this.formKey,
    required this.title,
    required this.children,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CardBox(
      margin: EdgeInsets.fromLTRB(16, 16, 16, dimen.bottom(16)),
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 24),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
        const SizedBox(height: 16),
        action,
      ],
    );
  }
}