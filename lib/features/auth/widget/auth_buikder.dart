import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/shared/drawables.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/base_widget.dart';
import '../viewmodel/auth_viewmodel.dart';

class AuthViewBuilder extends StatelessWidget {
  final String title;
  final AuthViewModel controller;
  final Widget Function(AuthViewModel controller) action;
  final Function(AuthViewModel)? onInit;
  final List<Widget> Function(BuildContext context, AuthViewModel controller)
      builder;

  const AuthViewBuilder({
    super.key,
    required this.title,
    required this.controller,
    required this.action,
    this.onInit,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseWidget<AuthViewModel>(
      model: controller,
      onInit: onInit,
      onDispose: (controller) => controller.dispose(),
      builder: (context, value, child) => DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(drawable.blurryBackdrop),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            body: Card(
              margin: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      drawable.splashLogo,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      string.of(context).enterYourDetails,
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: builder(context, controller),
                      ),
                    ),
                    const SizedBox(height: 20),
                    action.call(controller),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
