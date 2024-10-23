import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/card_box_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import '../viewmodel/account_viewmodel.dart';

class AccountUpdateView extends StatelessWidget {
  const AccountUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final account = context.read<AccountViewModel>();
    return BaseWidget<AuthViewModel>(
      model: AuthViewModel.update(context, account.user),
      onDispose: (controller) => controller.dispose(),
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        body: Backdrop(
          child: SafeArea(
            child: BaseWidget<AuthViewModel>(
              model: AuthViewModel.update(context, account.user),
              onDispose: (controller) => controller.dispose(),
              builder: (context, controller, _) => Form(
                key: controller.formKey,
                child: CardBox(
                  children: [
                    Text(
                      string.of(context).accountUpdate,
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
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
                      enabled: controller.user?.email == null,
                      hintText: string.of(context).emailHint,
                      title: string.of(context).email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFieldWidget(
                      controller: controller.phoneController,
                      hintText: string.of(context).phoneHint,
                      title: string.of(context).phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    Button(
                      label: string.of(context).save,
                      onPressed: () => controller.updateAccount(
                        onSuccess: (user) => account.user = user,
                      ),
                      loading: controller.isLoading(
                          key: 'updating_account', orElse: false),
                    ),
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
