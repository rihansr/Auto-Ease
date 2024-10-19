import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/profile/viewmodel/account_viewmodel.dart';

List<SingleChildWidget> providers = [
  ...independentService,
  ...universalService,
];

List<SingleChildWidget> independentService = [];

List<SingleChildWidget> universalService = [
  ChangeNotifierProvider<AccountViewModel>(
    create: (context) => AccountViewModel(context),
  ),
];
