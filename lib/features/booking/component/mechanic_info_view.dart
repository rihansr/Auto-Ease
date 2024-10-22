import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../viewmodel/mechanic_viewmodel.dart';
import '../widget/page_view_builder.dart';

class MechanicInfoPage extends StatelessWidget {
  const MechanicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingViewModel>();
    final controller = context.read<BookingViewModel>();
    return ChangeNotifierProvider<MechanicViewModel>.value(
      value: MechanicViewModel(context),
      child: Consumer<MechanicViewModel>(
        builder: (context, model, child) => PageViewBuilder(
          formKey: controller.formKeys[4],
          title: string.of(context).mechanicInfo,
          action: Button(
            label: string.of(context).next,
            onPressed: () => controller.nextPage(),
          ),
          children: [
            TextFieldWidget(
              controller: controller.mechanicNameController,
              title: string.of(context).name,
              autoValidate: listener.enabledAutoValidate,
              validator: (value) => validator.validateField(value,
                  field: string.of(context).name),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            TextFieldWidget(
              controller: controller.mechanicEmailController,
              title: string.of(context).email,
              autoValidate: listener.enabledAutoValidate,
              validator: (value) => validator.validateEmail(value),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFieldWidget(
              controller: controller.mechanicPhoneController,
              title: string.of(context).phone,
              autoValidate: controller.enabledAutoValidate,
              validator: (value) => validator.validateField(value,
                  field: string.of(context).phone),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
