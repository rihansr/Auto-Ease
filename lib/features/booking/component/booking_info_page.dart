import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/utils.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/text_field_widget.dart';
import '../viewmodel/create_booking_viewmodel.dart';
import '../widget/date_time_picker.dart';
import '../widget/page_view_builder.dart';

class BookingInfoPage extends StatelessWidget {
  const BookingInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<CreateBookingViewModel>();
    final controller = context.read<CreateBookingViewModel>();
    return PageViewBuilder(
      formKey: controller.formKeys[0],
      title: string.of(context).bookingInfo,
      action: Button(
        label: string.of(context).next,
        onPressed: controller.nextPage,
      ),
      children: [
        TextFieldWidget(
          controller: controller.titleController,
          title: string.of(context).title,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateField(value),
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
        ),
        TextFieldWidget(
          controller: controller.startAtController,
          title: string.of(context).startAt,
          hintText: string.of(context).bookingDateHint,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateField(value),
          typeable: false,
          onTap: () => showCustomDateTimePicker(
            context: context,
            minimumDate: controller.startAt,
            initialDate: controller.startAt,
            maximumDate: DateTime.now().add(const Duration(days: 90)),
            onSelected: (dateTime) {
              controller.startAt = dateTime;
              controller.startAtController.text = dateTime.Mdyyhhmma;
            },
          ),
          keyboardType: TextInputType.datetime,
        ),
        TextFieldWidget(
          controller: controller.endAtController,
          title: string.of(context).endAt,
          hintText: string.of(context).bookingDateHint,
          autoValidate: listener.enabledAutoValidate,
          validator: (value) => validator.validateField(value),
          typeable: false,
          onTap: () => showCustomDateTimePicker(
            context: context,
            minimumDate: controller.startAt,
            initialDate: controller.endAt ?? controller.startAt,
            maximumDate: DateTime.now().add(const Duration(days: 90)),
            onSelected: (dateTime) {
              controller.endAt = dateTime;
              controller.endAtController.text = dateTime.Mdyyhhmma;
            },
          ),
          keyboardType: TextInputType.datetime,
        ),
        TextFieldWidget(
          controller: controller.descriptionController,
          title: string.of(context).description,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
        ),
      ],
    );
  }
}
