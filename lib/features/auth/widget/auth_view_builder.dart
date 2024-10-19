import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/drawables.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../viewmodel/auth_viewmodel.dart';

class AuthViewBuilder extends StatelessWidget {
  final String title;
  final AuthViewModel controller;
  final Function(AuthViewModel)? onInit;
  final List<Widget> Function(
    BuildContext context,
    AuthViewModel controller,
  ) builder;

  const AuthViewBuilder({
    super.key,
    required this.title,
    required this.controller,
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
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        body: Backdrop(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          width: dimen.width / 2.5,
                          drawable.splashLogo,
                          fit: BoxFit.scaleDown,
                        ),
                        const SizedBox(height: 24),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}