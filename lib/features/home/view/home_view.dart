import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/enums.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/badge_widget.dart';
import '../../booking/view/bookings_view.dart';
import '../../account/view/settings_view.dart';
import '../../booking/view/schedule_view.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: HomeViewModel(context),
      child: Consumer<HomeViewModel>(
        builder: (context, controller, _) => const Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: Backdrop(
            child: SafeArea(
              child: _NavBarView(
                key: ValueKey('nav_bar_view_key'),
              ),
            ),
          ),
          bottomNavigationBar: _NavBar(
            key: ValueKey('nav_bar_key'),
          ),
        ),
      ),
    );
  }
}

class _NavBarView extends StatelessWidget {
  const _NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeViewModel>();
    return IndexedStack(
      index: controller.selectedTab,
      children: [
        if (controller.role == Role.admin)
          const ScheduleView(key: PageStorageKey('schedule_nav_view_key')),
        const BookingsView(key: PageStorageKey('bookings_nav_view_key')),
        const SettingsView(key: PageStorageKey('settings_nav_view_key')),
      ],
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeViewModel>();
    return SizedBox(
      height: dimen.navBarHeight,
      child: BottomNavigationBar(
        currentIndex: controller.selectedTab,
        onTap: (i) => controller.selectedTab = i,
        items: controller.navItems.entries
            .map(
              (e) => BottomNavigationBarItem(
                key: ValueKey(e.key),
                icon: Badges(
                  isVisible: e.key == 1,
                  child: Icon(e.value['icon'] as IconData),
                ),
                activeIcon: Icon(e.value['active_icon'] as IconData),
                label: e.value['label'] as String,
              ),
            )
            .toList(),
      ),
    );
  }
}
