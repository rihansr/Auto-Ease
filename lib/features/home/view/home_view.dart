import 'package:autoease/core/widget/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../../../core/widget/badge_widget.dart';
import '../../../core/widget/base_widget.dart';
import '../../account/viewmodel/account_viewmodel.dart';
import '../../booking/view/bookings_view.dart';
import '../../account/view/settings_view.dart';
import '../../booking/view/schedule_view.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(),
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Backdrop(
          child: SafeArea(
            child: IndexedStack(
              index: controller.selectedTab,
              children: const [
                ScheduleView(key: PageStorageKey('schedule_nav_view_key')),
                BookingsView(key: PageStorageKey('bookings_nav_view_key')),
                SettingsView(key: PageStorageKey('settings_nav_view_key')),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 72,
          child: BottomNavigationBar(
            currentIndex: controller.selectedTab,
            onTap: (i) => controller.selectedTab = i,
            items: (provider<AccountViewModel>().user?.role == Role.admin
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
                      })
                .entries
                .map(
                  (e) => BottomNavigationBarItem(
                    key: ValueKey(e.key),
                    icon: Badges(
                      isVisible:
                          provider<AccountViewModel>().user?.role == Role.admin
                              ? e.key == 1
                              : e.key == 0,
                      child: Icon(e.value['icon'] as IconData),
                    ),
                    activeIcon: Icon(e.value['active_icon'] as IconData),
                    label: e.value['label'] as String,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
