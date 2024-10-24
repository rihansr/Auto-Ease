import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../widget/auth_view_builder.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthViewBuilder(
      controller: AuthViewModel.forgetPass(context),
      title: string.of(context).passwordReset,
      subtitle: string.of(context).resetEmailWillSentMessage,
      builder: (context, controller) => [
        TextFieldWidget(
          controller: controller.emailController,
          autoValidate: controller.enabledAutoValidate,
          validator: (value) => validator.validateEmail(value),
          hintText: string.of(context).emailHint,
          title: string.of(context).email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        Button(
          label: string.of(context).sent,
          onPressed: () => controller.forgetPassword(
            onSuccess: () => context.pop(),
          ),
          loading: controller.isLoading(
            key: 'sending_reset_email',
            orElse: false,
          ),
        ),
      ],
    );
  }
}
