import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/enums.dart';
import '../../../core/viewmodel/base_viewmodel.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/badge_widget.dart';
import '../../account/viewmodel/account_viewmodel.dart';
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
          appBar: _AppBar(
            key: ValueKey('app_bar_key'),
          ),
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
            key: ValueKey('bottom_nav_bar'),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(dimen.toolBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<HomeViewModel>();
    return AppBar(
      centerTitle: false,
      title: Text(
        (controller.navItems[controller.selectedTab]?['label'] as String?) ??
            '',
      ),
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _NavBarView extends StatelessWidget {
  const _NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTab = context.watch<HomeViewModel>().selectedTab;
    return IndexedStack(
      index: currentTab,
      children: const [
        ScheduleView(key: PageStorageKey('schedule_nav_view_key')),
        BookingsView(key: PageStorageKey('bookings_nav_view_key')),
        SettingsView(key: PageStorageKey('settings_nav_view_key')),
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
    );
  }
}
