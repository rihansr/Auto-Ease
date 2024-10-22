import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../viewmodel/customer_viewmodel.dart';
import '../widget/page_view_builder.dart';

class CustomerInfoPage extends StatelessWidget {
  const CustomerInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingViewModel>();
    final controller = context.read<BookingViewModel>();
    return ChangeNotifierProvider<CustomerViewModel>.value(
      value: CustomerViewModel(context),
      child: Consumer<CustomerViewModel>(
        builder: (context, model, child) => PageViewBuilder(
          formKey: controller.formKeys[1],
          title: string.of(context).customerInfo,
          action: Button(
            label: string.of(context).next,
            onPressed: () => controller.nextPage(),
          ),
          children: [
            TextFieldWidget(
              controller: controller.customerNameController,
              title: string.of(context).name,
              autoValidate: listener.enabledAutoValidate,
              validator: (value) => validator.validateField(value,
                  field: string.of(context).name),
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
            TextFieldWidget(
              controller: controller.customerEmailController,
              title: string.of(context).email,
              keyboardType: TextInputType.emailAddress,
            ),
            TextFieldWidget(
              controller: controller.customerPhoneController,
              title: string.of(context).phone,
              autoValidate: listener.enabledAutoValidate,
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
