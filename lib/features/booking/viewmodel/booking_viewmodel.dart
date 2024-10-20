import 'package:flutter/material.dart';
import 'package:autoease/core/shared/utils.dart';

import '../../../core/viewmodel/base_viewmodel.dart';
import '../../auth/model/user_model.dart';
import '../model/booking_model.dart';
import '../model/service_model.dart';
import '../model/vehicle_model.dart';

class BookingViewModel extends BaseViewModel {
  final BuildContext context;
  Booking? booking;

  late GlobalKey<FormState> formKey;

  // Booking Details
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  // Car Details
  late Vehicle? carDetails;
  late TextEditingController carMakeController;
  late TextEditingController carModelController;
  late TextEditingController carYearController;
  late TextEditingController carPlateController;

  // Booking Date and Time
  DateTime? startAt;
  late TextEditingController startAtController;
  DateTime? endAt;
  late TextEditingController endAtController;

  // Customer Details
  late User? customer;
  late TextEditingController customerNameController;
  late TextEditingController customerEmailController;
  late TextEditingController customerPhoneController;

  // Mechanic Details
  late User? mechanic;
  late TextEditingController mechanicNameController;
  late TextEditingController mechanicEmailController;
  late TextEditingController mechanicPhoneController;

  // Services
  late List<Service> services;

  BookingViewModel(this.context, [this.booking])
      : formKey = GlobalKey<FormState>() {
    titleController = TextEditingController(text: booking?.title);
    descriptionController = TextEditingController(text: booking?.description);
    carDetails = booking?.carDetails;
    carMakeController = TextEditingController(text: carDetails?.make);
    carModelController = TextEditingController(text: carDetails?.model);
    carYearController =
        TextEditingController(text: carDetails?.year?.toString());
    carPlateController = TextEditingController(text: carDetails?.plate);
    startAt = booking?.startAt;
    startAtController = TextEditingController(text: startAt?.hhmmaMdyy);
    endAt = booking?.endAt;
    endAtController = TextEditingController(text: endAt?.hhmmaMdyy);
    customer = booking?.customer;
    customerNameController = TextEditingController(text: customer?.name);
    customerEmailController = TextEditingController(text: customer?.email);
    customerPhoneController = TextEditingController(text: customer?.phone);
    mechanic = booking?.mechanic;
    mechanicNameController = TextEditingController(text: mechanic?.name);
    mechanicEmailController = TextEditingController(text: mechanic?.email);
    mechanicPhoneController = TextEditingController(text: mechanic?.phone);
    services = booking?.services ?? [];
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    carMakeController.dispose();
    carModelController.dispose();
    carYearController.dispose();
    carPlateController.dispose();
    startAtController.dispose();
    endAtController.dispose();
    customerNameController.dispose();
    customerEmailController.dispose();
    customerPhoneController.dispose();
    mechanicNameController.dispose();
    mechanicEmailController.dispose();
    mechanicPhoneController.dispose();
    super.dispose();
  }
}
