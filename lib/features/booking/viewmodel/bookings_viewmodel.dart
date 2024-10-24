import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/local_storage.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../config/bookings_data_source.dart';
import '../model/booking_model.dart';

class BookingsViewModel extends BaseViewModel {
  List<Booking> bookings = [];
  CalendarDataSource? dataSource;
  final calendarController = CalendarController();

  BookingsViewModel();

  init() {
    _fetchAllBookings();
  }

  CalendarView get calendarView => calendarController.view ?? CalendarView.week;
  set calendarView(CalendarView view) => this
    ..calendarController.view = view
    ..notifyListeners();

  Future<void> _fetchAllBookings() async {
    setBusy(true, afterBinding: true, key: 'fetching_bookings');
    final Role? role = localStorage.user?.role;

    await firestoreService.invoke(
      onExecute: (firestore) async => role == Role.admin
          ? await firestore.collection('bookings').get()
          : await firestore
              .collection('bookings')
              .where('mechanic.uid', isEqualTo: authService.user?.uid)
              .get(),
      onCompleted: (snapshot) {
        bookings = snapshot.docs
            .map(
              (doc) => Booking.fromMap(doc.data()),
            )
            .toList();
        dataSource = BookingsDataSource(bookings);
      },
    );
    setBusy(false, key: 'fetching_bookings');
  }

  set booking(Booking booking) {
    int index = bookings.indexWhere((element) => element == booking);
    if (index != -1) {
      bookings[index] = booking;
    } else {
      bookings.add(booking);
    }
    dataSource = BookingsDataSource(bookings);
    notifyListeners();
  }

  removeBooking(Booking booking) {
    bookings.remove(booking);
    dataSource = BookingsDataSource(bookings);
    notifyListeners();
  }

  reset() => this
    ..bookings.clear()
    ..dataSource = null
    ..notifyListeners();
}
