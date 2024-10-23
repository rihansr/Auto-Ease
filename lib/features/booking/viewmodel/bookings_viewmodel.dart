import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../core/service/firestore_service.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../config/bookings_data_source.dart';
import '../model/booking_model.dart';

class BookingsViewModel extends BaseViewModel {
  List<Booking> bookings = const [];
  CalendarDataSource? dataSource;
  final calendarController = CalendarController();

  BookingsViewModel();

  init() {
    _fetchAllBookings();
  }

  Future<void> _fetchAllBookings() async {
    setBusy(true, key: 'fetching_bookings');

    await firestoreService.invoke(
      onExecute: (firestore) => firestore.collection('bookings').get(),
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

  CalendarView get calendarView => calendarController.view ?? CalendarView.week;
  set calendarView(CalendarView view) => this..calendarController.view = view..notifyListeners();
}
