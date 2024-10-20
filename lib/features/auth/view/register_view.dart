import 'package:autoease/core/shared/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared/enums.dart';
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
      controller: AuthViewModel.register(context),
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
          textCapitalization: TextCapitalization.words,
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
        const SizedBox(height: 8),
        Row(
          children: [Role.admin, Role.mechanic].map(
            (role) {
              final selected = controller.role == role;
              return Expanded(
                child: RadioListTile<Role>(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity: const VisualDensity(horizontal: -4),
                  title: Text(role.name.capitalize),
                  value: role,
                  groupValue: controller.role,
                  onChanged: (value) => controller.role = value!,
                  selected: selected,
                  activeColor: theme.colorScheme.primary,
                ),
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 16),
        Button(
          label: string.of(context).signUp,
          onPressed: () => controller.register(),
          loading: controller.isLoading(key: 'register', orElse: false),
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
                recognizer: TapGestureRecognizer()..onTap = () => context.pop(),
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
