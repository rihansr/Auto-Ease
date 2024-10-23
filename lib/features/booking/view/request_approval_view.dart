import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../../core/shared/colors.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/utils.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/modal_bottomsheet.dart';
import '../model/booking_model.dart';
import '../viewmodel/booking_viewmodel.dart';
import '../viewmodel/bookings_viewmodel.dart';
import 'booking_details_view.dart';

class RequestApprovalView extends StatelessWidget {
  const RequestApprovalView({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider<BookingViewModel>.value(
      value: BookingViewModel(context, booking),
      child: Consumer<BookingViewModel>(
        builder: (context, controller, _) => ModalBottomSheet(
          title: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                booking.bookedBy.name?.first ?? '',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            title: Text(
              booking.bookedBy.name ?? string.of().anonymous,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              validator.string(
                    booking.bookedBy.phone,
                    orElse: booking.bookedBy.email,
                  ) ??
                  'N/A',
              style: theme.textTheme.labelMedium,
            ),
          ),
          content: FixedTimeline.tileBuilder(
            theme: TimelineThemeData(
              nodePosition: 0,
            ),
            builder: TimelineTileBuilder.connected(
              connectionDirection: ConnectionDirection.before,
              itemCount: 2,
              contentsBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Text(
                  index == 0
                      ? booking.startAt.EEEMMMdhhmma
                      : booking.endAt.EEEMMMdhhmma,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              indicatorBuilder: (context, index) => DotIndicator(
                color: theme.colorScheme.secondary,
                child: Icon(
                  index == 0 ? Iconsax.clock : Iconsax.clock,
                  size: 16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              connectorBuilder: (context, index, type) => SolidLineConnector(
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          actions: [
            Button(
              label: string.of(context).accept,
              margin: const EdgeInsets.all(0),
              loading:
                  controller.isLoading(key: 'accepting_request', orElse: false),
              onPressed: () => controller.acceptRequest(
                onSuccess: (booking) {
                  context.read<BookingsViewModel>().booking = booking;
                  Navigator.pop(context);
                  showCupertinoModalPopup(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => BookingDetailsView(booking: booking),
                  );
                },
              ),
            ),
            Button(
              label: string.of(context).decline,
              background: Colors.transparent,
              fontColor: theme.colorScheme.tertiary,
              fontWeight: FontWeight.w600,
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
              loading:
                  controller.isLoading(key: 'declining_request', orElse: false),
              onPressed: () => controller.declineRequest(
                onSuccess: (booking) {
                  context.read<BookingsViewModel>()
                    ..bookings.remove(booking)
                    ..notify;
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
