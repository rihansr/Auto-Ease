import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../shared/drawables.dart';

class Backdrop extends StatelessWidget {
  final Widget child;
  const Backdrop({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          left: 20,
          top: 0,
          child: SvgPicture.asset(
            drawable.blurryBackdrop,
            fit: BoxFit.scaleDown,
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
