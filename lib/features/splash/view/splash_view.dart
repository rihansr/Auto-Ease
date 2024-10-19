import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/drawables.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
      model: SplashViewModel(context),
      onInit: (controller) => controller.init(),
      builder: (context, controller, child) => Scaffold(
        body: Backdrop(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 32),
              SvgPicture.asset(
                drawable.splashLogo,
                width: dimen.width / 1.5,
                fit: BoxFit.contain,
              ),
              LottieBuilder.asset(
                drawable.loading,
                height: 72,
                width: 72,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
