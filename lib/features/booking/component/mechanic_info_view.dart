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

class MechanicInfoPage extends StatelessWidget {
  const MechanicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<CreateBookingViewModel>();
    final controller = context.read<CreateBookingViewModel>();
    return PageViewBuilder(
      formKey: controller.formKeys[4],
      title: string.of(context).mechanicInfo,
      action: Button(
        label: string.of(context).book,
        loading: listener.isLoading(),
        onPressed: controller.nextPage,
      ),
      children: [
        AutoSuggessionsTextField<User>(
          controller: controller.mechanicNameController,
          title: string.of(context).name,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) =>
              validator.validateField(value, field: string.of(context).name),
          keyboardType: TextInputType.name,
          textCapitalization: TextCapitalization.words,
          suggestionsCallback: (pattern) async => controller.mechanics.where(
            (user) =>
                user.name?.toLowerCase().contains(pattern.toLowerCase()) ??
                false,
          ),
          itemBuilder: (context, user) =>
              UserSuggessionItem(key: ValueKey(user.uid), user: user),
          onSuggestionSelected: (user) => controller
            ..mechanic = user
            ..notify,
        ),
        AutoSuggessionsTextField<User>(
          controller: controller.mechanicEmailController,
          title: string.of(context).email,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateEmail(value),
          keyboardType: TextInputType.emailAddress,
          suggestionsCallback: (pattern) async => controller.mechanics.where(
            (user) =>
                user.email?.toLowerCase().contains(pattern.toLowerCase()) ??
                false,
          ),
          itemBuilder: (context, user) =>
              UserSuggessionItem(key: ValueKey(user.uid), user: user),
          onSuggestionSelected: (user) => controller
            ..mechanic = user
            ..notify,
        ),
        AutoSuggessionsTextField<User>(
          controller: controller.mechanicPhoneController,
          title: string.of(context).phone,
          autoValidate: controller.enabledAutoValidate,
          suggestionsCallback: (pattern) async => controller.mechanics.where(
            (user) => user.phone?.contains(pattern) ?? false,
          ),
          itemBuilder: (context, user) =>
              UserSuggessionItem(key: ValueKey(user.uid), user: user),
          onSuggestionSelected: (user) => controller
            ..mechanic = user
            ..notify,
        ),
        if (listener.mechanic?.uid == null)
          CheckboxListTile(
            dense: true,
            visualDensity: const VisualDensity(horizontal: -4),
            title: Text(string.of(context).saveMechanic),
            contentPadding: const EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            value: controller.saveMechanic,
            onChanged: (value) => controller.saveMechanic = value!,
          ),
      ],
    );
  }
}
