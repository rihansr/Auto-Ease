import 'dart:async';
import '../../../core/service/firestore_service.dart';
import '../../../core/shared/enums.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../model/booking_model.dart';

class BookingViewModel extends BaseViewModel {
  late Booking booking;

  BookingViewModel(this.booking);

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
      onCompleted: (_) async => {
        showMessage('Request accepted', type: AlertType.success),
        await onSuccess(
          booking.copyWith(
            status: BookingStatus.accepted,
          ),
        ),
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
      onCompleted: (_) async => {
        showMessage('Request declined', type: AlertType.error),
        await onSuccess(
          booking.copyWith(
            mechanic: null,
            status: BookingStatus.pending,
          ),
        ),
      },
    );
    setBusy(false, key: 'declining_request');
  }
}
