import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../../account/viewmodel/account_viewmodel.dart';

class HomeViewModel extends ChangeNotifier {
  final BuildContext context;
  HomeViewModel(this.context);

  Map<int, Map<String, Object>> get navItems =>
      provider<AccountViewModel>().user?.role == Role.admin
          ? {
              0: {
                'icon': Iconsax.calendar_2,
                'active_icon': Iconsax.calendar_25,
                'label': string.of(context).schedule
              },
              1: {
                'icon': Iconsax.note_text4,
                'active_icon': Iconsax.note_text5,
                'label': string.of(context).bookings
              },
              2: {
                'icon': Iconsax.setting_44,
                'active_icon': Iconsax.setting_45,
                'label': string.of(context).settings
              },
            }
          : {
              0: {
                'icon': Iconsax.note_text4,
                'active_icon': Iconsax.note_text5,
                'label': string.of(context).requests
              },
              1: {
                'icon': Iconsax.setting_44,
                'active_icon': Iconsax.setting_45,
                'label': string.of(context).settings
              },
            };

  /// Setter & Getter for the selected tab index.
  /// This setter updates the [_selectedTab] field and notifies listeners
  /// about the change.
  /// Getter for the selected tab index.
  int _selectedTab = 0;
  int get selectedTab => _selectedTab;
  set selectedTab(int tab) => this
    .._selectedTab = tab
    ..notifyListeners();
}
