import 'package:flutter/material.dart';
import 'package:autoease/core/shared/utils.dart';
import '../../../core/shared/constants.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../../auth/model/user_model.dart';
import '../model/booking_model.dart';
import '../model/service_model.dart';
import '../model/vehicle_model.dart';

class BookingViewModel extends BaseViewModel {
  final BuildContext context;
  Booking? booking;

  final PageController pageController = PageController();

  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // Booking Info
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? startAt;
  late TextEditingController startAtController;
  DateTime? endAt;
  late TextEditingController endAtController;

  // Car Info
  late Vehicle? carDetails;
  late TextEditingController carMakeController;
  late TextEditingController carModelController;
  late TextEditingController carYearController;
  late TextEditingController carPlateController;

  // Customer Info
  late User? customer;
  late TextEditingController customerNameController;
  late TextEditingController customerEmailController;
  late TextEditingController customerPhoneController;

  // Booking Services
  late List<Service> bookingServices;

  // Mechanic Info
  late User? mechanic;
  late TextEditingController mechanicNameController;
  late TextEditingController mechanicEmailController;
  late TextEditingController mechanicPhoneController;

  BookingViewModel(this.context, [this.booking]) {
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
    bookingServices = booking?.services ?? [];
  }

  previousPage() {
    switch (pageController.page!.round()) {
      case 0:
        Navigator.pop(context);
        break;
      default:
        pageController.previousPage(
          duration: kDefaultDuration,
          curve: Curves.easeInOut,
        );
    }
  }

  init() {
    fetchCustomers();
    fetchMechanics();
    fetchServices();
  }

  nextPage() {
    if (validate(formKeys[pageController.page!.round()])) {
      pageController.nextPage(
        duration: kDefaultDuration,
        curve: Curves.easeInOut,
      );
    }
  }

  toggleService(Service service) {
    if (bookingServices.contains(service)) {
      bookingServices.remove(service);
    } else {
      bookingServices.add(service);
    }
    notifyListeners();
  }

  // Customers
  List<User> customers = [];
  Future<void> fetchCustomers() async {
    setBusy(key: 'fetching_customers', true);
    setBusy(key: 'fetching_customers', false);
  }

  // Mechanics
  List<User> mechanics = [];
  Future<void> fetchMechanics() async {
    setBusy(key: 'fetching_mechanics', true);
    setBusy(key: 'fetching_mechanics', false);
  }

  // Services
  List<Service> services = [];
  Future<void> fetchServices() async {
    setBusy(key: 'fetching_services', true);
    setBusy(key: 'fetching_services', false);
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
