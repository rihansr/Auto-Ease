import 'package:flutter/material.dart';
import '../shared/dimens.dart';

class CardBox extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? margin;
  const CardBox({
    super.key,
    required this.children,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? EdgeInsets.fromLTRB(16, 0, 16, dimen.bottom(24)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
