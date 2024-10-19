import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../widget/auth_view_builder.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AuthViewBuilder(
      controller: AuthViewModel.register(),
      title: string.of(context).register,
      builder: (context, controller) => [
        TextFieldWidget(
          controller: controller.nameController,
          autoValidate: controller.enabledAutoValidate,
          validator: (value) => validator.validateField(
            value,
            field: string.of(context).name,
          ),
          hintText: string.of(context).nameHint,
          title: string.of(context).name,
          keyboardType: TextInputType.name,
        ),
        TextFieldWidget(
          controller: controller.emailController,
          autoValidate: controller.enabledAutoValidate,
          validator: (value) => validator.validateEmail(value),
          hintText: string.of(context).emailHint,
          title: string.of(context).email,
          keyboardType: TextInputType.emailAddress,
        ),
        TextFieldWidget(
          controller: controller.passwordController,
          autoValidate: controller.enabledAutoValidate,
          validator: (value) => validator.validatePassword(
            value,
            field: string.of(context).password,
          ),
          hintText: string.of(context).passwordHint,
          title: string.of(context).password,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),
        TextFieldWidget(
          controller: controller.secondaryPasswordController,
          autoValidate: controller.enabledAutoValidate,
          validator: (value) => validator.validatePassword(
            value,
            field: string.of(context).password,
            matchValue: controller.passwordController?.text,
          ),
          hintText: string.of(context).passwordHint,
          title: string.of(context).confirmPassword,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        Button(
          label: string.of(context).signUp,
          onPressed: () => controller.login(),
          loading: controller.isLoading(key: 'login', orElse: false),
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: string.of(context).alreadyHaveAnAccount,
            children: [
              TextSpan(
                text: " ${string.of(context).login}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => context.pop(),
              ),
            ],
            style: theme.textTheme.labelMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
