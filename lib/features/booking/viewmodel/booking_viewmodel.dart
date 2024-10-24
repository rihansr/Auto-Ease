import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/shared/debug.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/local_storage.dart';
import '../../../core/shared/strings.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/booking_model.dart';
import '../model/service_model.dart';
import '../service/receipt_generator.dart';
import '../view/new_booking_view.dart';
import '../view/receipt_preview.dart';
import 'bookings_viewmodel.dart';

class BookingViewModel extends BaseViewModel {
  final BuildContext context;
  late Booking booking;
  Role? role = localStorage.user?.role;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _subscription;

  BookingViewModel(this.context, this.booking);

  init() {
    _retrieveBookingDetails();
  }

  _retrieveBookingDetails() async {
    _subscription = FirebaseFirestore.instance
        .collection('bookings')
        .doc(booking.uid)
        .snapshots()
        .listen((documentSnapshot) {
      booking = Booking.fromMap(documentSnapshot.data()!);
      notifyListeners();
    });
    _subscription?.onError((error) {
      debug.print(error, tag: 'Firestore Exception');
    });
  }

  Future<void> acceptRequest({
    required FutureOr Function(Booking booking) onSuccess,
  }) async {
    setBusy(true, key: 'accepting_request');
    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection('bookings').doc(booking.uid).update(
        {
          'status': BookingStatus.accepted.name,
        },
      ),
      onCompleted: (_) async {
        booking = booking.copyWith(status: BookingStatus.accepted);
        context.read<BookingsViewModel>().booking = booking;
        await onSuccess(booking);
      },
    );
    setBusy(false, key: 'accepting_request');
  }

  Future<void> declineRequest({
    required FutureOr Function(Booking booking) onSuccess,
  }) async {
    setBusy(true, key: 'declining_request');
    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection('bookings').doc(booking.uid).update(
        {
          'mechanic': null,
          'status': BookingStatus.pending.name,
        },
      ),
      onCompleted: (_) async {
        showMessage(string.of(context).requestDeclined, type: AlertType.error);
        context.read<BookingsViewModel>().removeBooking(booking);
        booking =
            booking.updateWith(mechanic: null, status: BookingStatus.pending);
        await onSuccess(booking);
      },
    );
    setBusy(false, key: 'declining_request');
  }

  bool get allServicesCompleted =>
      booking.services.every((service) => (service.isCompleted ?? false));

  bool get notStartedYet =>
      booking.services.every((service) => !(service.isCompleted ?? false));

  Future<void> updateService(Service service, int at) async {
    if (booking.status == BookingStatus.completed) return;
    final services = booking.services;
    services[at] = service;

    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection('bookings').doc(booking.uid).update(
        {
          'services': services.map((x) => x.toMap()).toList(),
        },
      ),
      onCompleted: (_) {
        booking = booking.copyWith(services: services);
        context.read<BookingsViewModel>().booking = booking;
      },
    );
  }

  editBooking() => showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (context) => NewBookingView(booking: booking),
      ).then(
        (booking) {
          if (booking != null) {
            this
              ..booking = booking
              ..notifyListeners();
          }
        },
      );

  Future<void> deleteBooking() async {
    setBusy(true, key: 'deleting_booking');
    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection('bookings').doc(booking.uid).delete(),
      onCompleted: (_) {
        context.read<BookingsViewModel>().removeBooking(booking);
        Navigator.pop(context);
      },
    );
    setBusy(false, key: 'deleting_booking');
  }

  Future<void> completeBooking([String? notes]) async {
    setBusy(true, key: 'completing_booking');
    await firestoreService.invoke(
      onExecute: (firestore) async =>
          await firestore.collection('bookings').doc(booking.uid).update(
        {
          if (notes != null) 'notes': notes,
          'status': BookingStatus.completed.name,
        },
      ),
      onCompleted: (_) {
        booking = booking.copyWith(
          status: BookingStatus.completed,
          notes: notes,
        );
        context.read<BookingsViewModel>().booking = booking;
        Navigator.pop(context);
      },
    );
    setBusy(false, key: 'completing_booking');
  }

  generateReceipt() => showCupertinoModalPopup(
        context: context,
        builder: (_) => ReceiptPreview(
          generator: (format) => ReceiptGenerator(booking: booking).generate(),
        ),
      );

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
