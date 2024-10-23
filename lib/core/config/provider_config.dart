import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../features/account/viewmodel/account_viewmodel.dart';
import '../../features/booking/viewmodel/bookings_viewmodel.dart';

List<SingleChildWidget> providers = [
  ...independentService,
  ...universalService,
];

List<SingleChildWidget> independentService = [];

List<SingleChildWidget> universalService = [
  ChangeNotifierProvider<AccountViewModel>(
    create: (context) => AccountViewModel(),
  ),
  ChangeNotifierProvider<BookingsViewModel>(
    create: (context) => BookingsViewModel(),
  ),
];
