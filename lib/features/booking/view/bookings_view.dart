import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/widget/base_widget.dart';
import '../../account/viewmodel/account_viewmodel.dart';
import '../viewmodel/bookings_viewmodel.dart';
import 'new_booking_view.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final account = context.watch<AccountViewModel>();
    return BaseWidget<BookingsViewModel>(
      model: BookingsViewModel(),
      builder: (context, cotroller, child) => CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: Text(
              account.user?.role == Role.admin
                  ? string.of(context).bookings
                  : string.of(context).requests,
            ),
            toolbarHeight: dimen.toolBarHeight,
            titleTextStyle: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            pinned: true,
            actions: [
              if (account.user?.role == Role.admin)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => showCupertinoModalPopup(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const NewBookingView(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
