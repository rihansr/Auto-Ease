import 'package:autoease/core/service/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:autoease/core/shared/utils.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/shared/constants.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/validator.dart';
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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime _startAt;
  TextEditingController startAtController = TextEditingController();
  late DateTime? _endAt;
  TextEditingController endAtController = TextEditingController();

  // Car Info
  late Vehicle? _carDetails;
  TextEditingController carMakeController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carYearController = TextEditingController();
  TextEditingController carPlateController = TextEditingController();

  // Customer Info
  late User? _customer;
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();

  // Booking Services
  late List<Service> bookedServices;

  // Mechanic Info
  late User? _mechanic;
  TextEditingController mechanicNameController = TextEditingController();
  TextEditingController mechanicEmailController = TextEditingController();
  TextEditingController mechanicPhoneController = TextEditingController();

  BookingViewModel(this.context, [this.booking]) {
    titleController.text = booking?.title ?? '';
    descriptionController.text = booking?.description ?? '';
    startAt = booking?.startAt ?? DateTime.now();
    endAt = booking?.endAt;
    carDetails = booking?.carDetails;
    customer = booking?.customer;
    bookedServices = booking?.services ?? [];
    mechanic = booking?.mechanic;
  }

  init() {
    _fetchCustomers();
    _fetchMechanics();
    _fetchServices();
  }

  // Booking info
  DateTime get startAt => _startAt;
  set startAt(DateTime at) => this
    .._startAt = at
    ..startAtController.text = at.hhmmaMdyy;

  DateTime? get endAt => _endAt;
  set endAt(DateTime? at) => this
    .._endAt = at
    ..startAtController.text = at?.hhmmaMdyy ?? '';

  // Customer Info
  User? get customer => _customer;
  set customer(User? customer) => this
    .._customer = customer
    ..customerNameController.text = customer?.name ?? ''
    ..customerEmailController.text = customer?.email ?? ''
    ..customerPhoneController.text = customer?.phone ?? '';

  bool _saveCustomer = false;
  bool get saveCustomer => _saveCustomer;
  set saveCustomer(bool state) => this
    .._saveCustomer = state
    ..notifyListeners();

  Future<void> saveCustomerInfo() async {
    setBusy(true, key: 'saving_customer');
    final user = User(
      uid: firestoreService.uniqueId,
      name: validator.string(customerNameController)!,
      email: validator.string(customerEmailController, orElse: null)!,
      phone: validator.string(customerPhoneController)!,
      role: Role.customer,
    );

    await firestoreService.invoke(
      onExecute: (firestore) async => firestore.collection(user.role.table).set(
            id: user.uid!,
            data: user.toMap(),
          ),
      onCompleted: (_) async {
        customer = user;
        _saveCustomer = false;
      },
    );

    setBusy(false, key: 'saving_customer');
  }

  List<User> customers = [];
  Future<void> _fetchCustomers() async {
    firestoreService.invoke(
      onExecute: (firestore) => firestore.collection(Role.customer.table).get(),
      onCompleted: (snapshot) {
        customers = snapshot.docs
            .map(
              (doc) => User.fromMap(doc.data()),
            )
            .toList();
      },
    );
  }

  // Car Info
  Vehicle? get carDetails => _carDetails;
  set carDetails(Vehicle? carDetails) => this
    .._carDetails = carDetails
    ..carMakeController.text = carDetails?.make ?? ''
    ..carModelController.text = carDetails?.model ?? ''
    ..carYearController.text = carDetails?.year ?? ''
    ..carPlateController.text = carDetails?.plate ?? '';

  // Booking Services
  set selectedService(Service service) {
    if (bookedServices.contains(service)) {
      bookedServices.remove(service);
    } else {
      bookedServices.add(service);
    }
    notifyListeners();
  }

  // Services
  set service(Service service) => this
    ..services.add(service)
    ..notifyListeners();

  List<Service> services = [];
  Future<void> _fetchServices() async {
    setBusy(true, key: 'fetching_services');
    await firestoreService.invoke(
      onExecute: (firestore) => firestore.collection('services').get(),
      onCompleted: (snapshot) {
        services = snapshot.docs
            .map(
              (doc) => Service.fromMap(doc.data()),
            )
            .toList();
      },
    );
    setBusy(false, key: 'fetching_services');
  }

  // Mechanic Info
  User? get mechanic => _mechanic;
  set mechanic(User? mechanic) => this
    .._mechanic = mechanic
    ..mechanicNameController.text = mechanic?.name ?? ''
    ..mechanicEmailController.text = mechanic?.email ?? ''
    ..mechanicPhoneController.text = mechanic?.phone ?? '';

  bool _saveMechanic = false;
  bool get saveMechanic => _saveMechanic;
  set saveMechanic(bool state) => this
    .._saveMechanic = state
    ..notifyListeners();

  Future<void> saveMechanicInfo() async {
    setBusy(true, key: 'saving_mechanic');

    await authService.invoke(
      isolatedAuth: true,
      onExecute: (auth) async => auth.createUserWithEmailAndPassword(
        email: validator.string(mechanicEmailController)!,
        password: firestoreService.uniqueId,
      ),
      onCompleted: (credentials) async {
        if (credentials.user == null) return;
        final user = User(
          uid: credentials.user!.uid,
          name: validator.string(mechanicNameController)!,
          email: validator.string(mechanicEmailController)!,
          phone: validator.string(mechanicPhoneController)!,
          role: Role.mechanic,
        );
        await firestoreService.invoke(
          onExecute: (firestore) async =>
              firestore.collection(user.role.table).set(
                    id: user.uid!,
                    data: user.toMap(),
                  ),
          onCompleted: (_) async {
            mechanic = user;
            _saveMechanic = false;
          },
        );
      },
    );

    setBusy(false, key: 'saving_mechanic');
  }

  List<User> mechanics = [];
  Future<void> _fetchMechanics() async {
    firestoreService.invoke(
      onExecute: (firestore) => firestore
          .collection(Role.mechanic.table)
          .where('role', isEqualTo: Role.mechanic.name)
          .get(),
      onCompleted: (snapshot) {
        mechanics = snapshot.docs
            .map(
              (doc) => User.fromMap(doc.data()),
            )
            .toList();
      },
    );
  }

  // Page Navigation
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

  nextPage() {
    final currentPage = pageController.page!.round();
    if (!validate(formKeys[currentPage])) {
      return;
    } else if (currentPage == 3 && bookedServices.isEmpty) {
      showMessage(string.of(context).noServiceSelected);
      return;
    }
    switch (currentPage) {
      case 4:
        Future.wait([
          if (_saveCustomer) saveCustomerInfo(),
          if (_saveMechanic) saveMechanicInfo(),
        ]).then((_) => book());
        break;
      default:
        pageController.nextPage(
          duration: kDefaultDuration,
          curve: Curves.easeInOut,
        );
    }
  }

  Future<void> book() async {
    setBusy(true, key: 'booking');
    final booking = Booking(
      uid: this.booking?.uid ?? firestoreService.uniqueId,
      bookedBy: authService.user?.uid ?? '',
      title: titleController.text,
      description: descriptionController.text,
      bookedAt: DateTime.now(),
      startAt: startAt,
      endAt: endAt!,
      carDetails: Vehicle(
        uid: carDetails?.uid ?? firestoreService.uniqueId,
        make: validator.string(carMakeController.text, orElse: null),
        model: validator.string(carModelController.text, orElse: null),
        year: validator.string(carYearController.text, orElse: null),
        plate: validator.string(carPlateController.text)!,
      ),
      customer: User(
        uid: customer?.uid,
        name: validator.string(customerNameController.text),
        email: validator.string(customerEmailController.text, orElse: null),
        phone: validator.string(customerPhoneController.text),
        role: Role.customer,
      ),
      mechanic: User(
        uid: mechanic?.uid,
        name: validator.string(mechanicNameController.text),
        email: validator.string(mechanicEmailController.text),
        phone: validator.string(mechanicPhoneController.text),
        role: Role.mechanic,
      ),
      services: bookedServices,
    );

    await firestoreService.invoke(
      onExecute: (firestore) async => firestore.collection('bookings').set(
            id: booking.uid,
            data: booking.toMap(),
          ),
      onCompleted: (_) async {
        Navigator.pop(context);
      },
    );

    setBusy(false, key: 'booking');
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
