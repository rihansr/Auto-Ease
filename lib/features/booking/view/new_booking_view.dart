import 'package:autoease/core/shared/utils.dart';
import 'package:autoease/core/shared/validator.dart';
import 'package:autoease/core/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../model/booking_model.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../widget/date_time_picker.dart';

class NewBookingView extends StatelessWidget {
  final Booking? booking;

  const NewBookingView({
    super.key,
    this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(string.of(context).newBooking),
      ),
      extendBodyBehindAppBar: true,
      body: Backdrop(
        child: SafeArea(
          child: BaseWidget<BookingViewModel>(
            model: BookingViewModel(context, booking),
            builder: (context, controller, _) => Form(
              key: controller.formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ExpansionTile(
                    title: const Text("Booking Details"),
                    initiallyExpanded: true,
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      TextFieldWidget(
                        controller: controller.titleController,
                        title: "Title",
                        autoValidate: controller.enabledAutoValidate,
                        validator: (value) =>
                            validator.validateField(value, field: "Title"),
                        keyboardType: TextInputType.text,
                      ),
                      TextFieldWidget(
                        controller: controller.descriptionController,
                        title: "Description",
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.startAtController,
                              title: "Start At",
                              autoValidate: controller.enabledAutoValidate,
                              validator: (value) => validator
                                  .validateField(value, field: "Start At"),
                              typeable: false,
                              onTap: () => showCustomDateTimePicker(
                                context: context,
                                initialDateTime: controller.startAt,
                                onSelected: (dateTime) {
                                  controller.startAt = dateTime;
                                  controller.startAtController.text =
                                      dateTime.hhmmaMdyy;
                                },
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.endAtController,
                              title: "End At",
                              autoValidate: controller.enabledAutoValidate,
                              validator: (value) => validator
                                  .validateField(value, field: "End At"),
                              typeable: false,
                              onTap: () => showCustomDateTimePicker(
                                context: context,
                                initialDateTime: controller.endAt,
                                onSelected: (dateTime) {
                                  controller.endAt = dateTime;
                                  controller.endAtController.text =
                                      dateTime.hhmmaMdyy;
                                },
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Car Details"),
                    initiallyExpanded: true,
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.carMakeController,
                              title: "Car Make",
                              autoValidate: controller.enabledAutoValidate,
                              validator: (value) => validator
                                  .validateField(value, field: "Car Make"),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.carModelController,
                              title: "Car Model",
                              autoValidate: controller.enabledAutoValidate,
                              validator: (value) => validator
                                  .validateField(value, field: "Car Model"),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.carYearController,
                              title: "Car Year",
                              autoValidate: controller.enabledAutoValidate,
                              validator: (value) => validator
                                  .validateField(value, field: "Car Year"),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFieldWidget(
                              controller: controller.carPlateController,
                              title: "Car Plate",
                              autoValidate: controller.enabledAutoValidate,
                              validator: (value) => validator
                                  .validateField(value, field: "Car Plate"),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Customer Details"),
                    initiallyExpanded: true,
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      TextFieldWidget(
                        controller: controller.customerNameController,
                        title: string.of(context).name,
                        autoValidate: controller.enabledAutoValidate,
                        validator: (value) => validator.validateField(value,
                            field: string.of(context).name),
                        keyboardType: TextInputType.name,
                      ),
                      TextFieldWidget(
                        controller: controller.customerEmailController,
                        title: string.of(context).email,
                        autoValidate: controller.enabledAutoValidate,
                        validator: (value) => validator.validateEmail(value),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFieldWidget(
                        controller: controller.customerPhoneController,
                        title: string.of(context).phone,
                        autoValidate: controller.enabledAutoValidate,
                        validator: (value) => validator.validateField(value,
                            field: string.of(context).phone),
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: const Text("Mechanic Details"),
                    initiallyExpanded: true,
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      TextFieldWidget(
                        controller: controller.mechanicNameController,
                        title: string.of(context).name,
                        autoValidate: controller.enabledAutoValidate,
                        validator: (value) => validator.validateField(value,
                            field: string.of(context).name),
                        keyboardType: TextInputType.name,
                      ),
                      TextFieldWidget(
                        controller: controller.mechanicEmailController,
                        title: string.of(context).email,
                        autoValidate: controller.enabledAutoValidate,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
