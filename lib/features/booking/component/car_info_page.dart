import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../widget/page_view_builder.dart';

class CarInfoPage extends StatelessWidget {
  const CarInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingViewModel>();
    final controller = context.read<BookingViewModel>();
    return PageViewBuilder(
      formKey: controller.formKeys[2],
      title: string.of(context).carInfo,
      action: Button(
        label: string.of(context).next,
        onPressed: controller.nextPage,
      ),
      children: [
        TextFieldWidget(
          controller: controller.carMakeController,
          title: string.of(context).make,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateField(value),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
        ),
        TextFieldWidget(
          controller: controller.carModelController,
          title: string.of(context).model,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateField(value),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
        ),
        TextFieldWidget(
          controller: controller.carYearController,
          title: string.of(context).year,
          hintText: string.of(context).yearHint,
          keyboardType: TextInputType.datetime,
        ),
        TextFieldWidget(
          controller: controller.carPlateController,
          title: string.of(context).regPlate,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateField(value),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
