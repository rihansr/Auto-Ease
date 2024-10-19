import 'package:flutter/material.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../widget/auth_buikder.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
     return AuthViewBuilder(
      controller: AuthViewModel.register(),
      title: string.of(context).register,
      builder: (context, controller) => [
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
          ),
          hintText: string.of(context).passwordHint,
          title: string.of(context).confirmPassword,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
        ),
      ],
      action: (controller) => Button(
        label: string.of(context).signIn,
        onPressed: () => controller.login(),
        loading: controller.isLoading(key: 'login', orElse: false),
      ),
    );
  }
}
