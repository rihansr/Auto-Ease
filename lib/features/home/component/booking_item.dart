import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/utils.dart';
import '../../../core/widget/modal_bottomsheet.dart';
import '../../booking/model/booking_model.dart';
import '../../booking/view/booking_details_view.dart';
import '../../booking/view/request_approval_view.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({
    super.key,
    required this.booking,
    required this.role,
  });

  final Booking? booking;
  final Role? role;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = role == Role.admin ? booking?.customer : booking?.bookedBy;
    return InkWell(
      onTap: booking == null
          ? null
          : () {
              if (role == Role.admin || booking?.status != BookingStatus.pending) {
                showCupertinoModalPopup(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => BookingDetailsView(booking: booking!),
                );
              } else {
                ModalBottomSheet.show(
                  context,
                  (context) => RequestApprovalView(booking: booking!),
                );
              }
            },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              dense: true,
              horizontalTitleGap: 12,
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  user?.name?.first ?? '',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  user?.name ?? string.of(context).anonymous,
                  maxLines: 1,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: booking?.alert ?? theme.colorScheme.outline,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        const TextSpan(text: " "),
                        TextSpan(
                          text: booking?.status.name.capitalize ?? 'pending',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.hintColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    "${booking?.startAt.Mdyyhhmma ?? '--:-- a -/-/--'}"
                    " - "
                    "${booking?.endAt.Mdyyhhmma ?? '--:-- a -/-/--'}",
                    maxLines: 1,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                booking?.service ?? '',
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.textTheme.headlineMedium?.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
