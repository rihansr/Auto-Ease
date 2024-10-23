import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../auth/model/user_model.dart';
import '../viewmodel/create_booking_viewmodel.dart';
import '../widget/auto_suggessions_text_field.dart';
import '../widget/page_view_builder.dart';
import 'user_suggession_item.dart';

class CustomerInfoPage extends StatelessWidget {
  const CustomerInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<CreateBookingViewModel>();
    final controller = context.read<CreateBookingViewModel>();
    return PageViewBuilder(
      formKey: controller.formKeys[1],
      title: string.of(context).customerInfo,
      action: Button(
        label: string.of(context).next,
        onPressed: controller.nextPage,
      ),
      children: [
        AutoSuggessionsTextField<User>(
          controller: controller.customerNameController,
          title: string.of(context).name,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) =>
              validator.validateField(value, field: string.of(context).name),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          suggestionsCallback: (pattern) async => controller.customers.where(
            (user) =>
                user.name?.toLowerCase().contains(pattern.toLowerCase()) ??
                false,
          ),
          itemBuilder: (context, user) =>
              UserSuggessionItem(key: ValueKey(user.uid), user: user),
          onSuggestionSelected: (user) => controller
            ..customer = user
            ..notify,
        ),
        AutoSuggessionsTextField<User>(
          controller: controller.customerEmailController,
          title: string.of(context).email,
          keyboardType: TextInputType.emailAddress,
          suggestionsCallback: (pattern) async => controller.customers.where(
            (user) =>
                user.email?.toLowerCase().contains(pattern.toLowerCase()) ??
                false,
          ),
          itemBuilder: (context, user) =>
              UserSuggessionItem(key: ValueKey(user.uid), user: user),
          onSuggestionSelected: (user) => controller
            ..customer = user
            ..notify,
        ),
        AutoSuggessionsTextField<User>(
          controller: controller.customerPhoneController,
          title: string.of(context).phone,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) =>
              validator.validateField(value, field: string.of(context).phone),
          keyboardType: TextInputType.phone,
          suggestionsCallback: (pattern) async => controller.customers.where(
            (user) => user.phone?.contains(pattern) ?? false,
          ),
          itemBuilder: (context, user) =>
              UserSuggessionItem(key: ValueKey(user.uid), user: user),
          onSuggestionSelected: (user) => controller
            ..customer = user
            ..notify,
        ),
        if (listener.customer?.uid == null)
          CheckboxListTile(
            dense: true,
            visualDensity: const VisualDensity(horizontal: -4),
            title: Text(string.of(context).saveCustomer),
            contentPadding: const EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.saveCustomer,
            onChanged: (value) => controller.saveCustomer = value!,
          ),
      ],
    );
  }
}
