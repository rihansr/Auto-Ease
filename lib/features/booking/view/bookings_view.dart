import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/base_widget.dart';
import '../../home/component/booking_item.dart';
import '../../home/viewmodel/home_viewmodel.dart';
import '../viewmodel/bookings_viewmodel.dart';
import 'new_booking_view.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BookingsViewModel>(
      model: Provider.of<BookingsViewModel>(context),
      onInit: (model) => model.init(),
      builder: (context, cotroller, child) => const CustomScrollView(
        slivers: [
          _AppBar(
            key: Key('app_bar'),
          ),
          _Bookings(
            key: Key('bookings'),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final role = context.read<HomeViewModel>().role;
    final controller = context.read<BookingsViewModel>();

    return SliverAppBar(
      centerTitle: false,
      title: Text(
        role == Role.admin
            ? string.of(context).bookings
            : string.of(context).requests,
      ),
      toolbarHeight: dimen.toolBarHeight,
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      pinned: true,
      actions: [
        if (role == Role.admin)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showCupertinoModalPopup(
              context: context,
              barrierDismissible: false,
              builder: (context) => const NewBookingView(),
            ).then((booking) {
              if (booking != null) {
                controller.booking = booking;
              }
            }),
          ),
      ],
    );
  }
}

class _Bookings extends StatelessWidget {
  const _Bookings({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.read<HomeViewModel>().role;
    final listener = context.watch<BookingsViewModel>();
    bool isLoading =
        listener.isLoading(key: 'fetching_bookings', orElse: false);
    final bookings = isLoading ? List.filled(3, null) : listener.bookings;
    return SliverSkeletonizer(
      enabled: isLoading,
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final booking = bookings[index];
            return BookingItem(
              key: ValueKey(booking?.uid ?? index),
              booking: booking,
              role: role,
            );
          },
          childCount: bookings.length,
        ),
      ),
    );
  }
}
