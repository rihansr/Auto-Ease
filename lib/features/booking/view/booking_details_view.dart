import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/enums.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/utils.dart';
import '../../../core/shared/validator.dart';
import '../../../core/widget/backdrop.dart';
import '../../../core/widget/base_widget.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/clipper_widget.dart';
import '../model/booking_model.dart';
import '../viewmodel/booking_viewmodel.dart';
import 'add_notes_view.dart';

class BookingDetailsView extends StatelessWidget {
  final Booking booking;
  const BookingDetailsView({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: BookingViewModel(context, booking),
      onInit: (model) => model.init(),
      onDispose: (model) => model.dispose(),
      builder: (context, controller, _) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: Text(string.of(context).bookingDetails),
          actions: const [
            _PopupActions(
              key: ValueKey('popup_actions'),
            )
          ],
        ),
        body: Backdrop(
          child: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: const [
                _BookingInfo(
                  key: ValueKey('booking_info'),
                ),
                _UsersInfo(
                  key: ValueKey('users_info'),
                ),
                _CarInfo(
                  key: ValueKey('car_info'),
                ),
                _BookingServices(
                  key: ValueKey('booking_services'),
                ),
                _BookingNotes(
                  key: ValueKey('booking_notes'),
                ),
                _PaymentSummary(
                  key: ValueKey('payment_summary'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const _BottomActions(
          key: ValueKey('booking_actions'),
        ),
      ),
    );
  }
}

class _BookingInfo extends StatelessWidget {
  const _BookingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listener = context.watch<BookingViewModel>();
    final timeRange = [
      listener.booking.startAt,
      listener.booking.endAt,
    ];
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 4),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        title: Row(
          children: [
            Text(
              string.of(context).bookingId,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            Clipper(
              shape: const StadiumBorder(),
              color: listener.booking.alert.withOpacity(0.25),
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
              child: Text(
                listener.booking.status.name.capitalize,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: listener.booking.alert, height: 1),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listener.booking.uid,
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.6,
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: string.of(context).bookedOn,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const TextSpan(text: '  '),
                  TextSpan(
                    text: listener.booking.bookedAt.EEEMMMdhhmma,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                nodePosition: 0.0,
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: timeRange.length,
                contentsBuilder: (context, index) {
                  final date = timeRange[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      (() {
                        switch (index) {
                          case 0:
                            return string.of(context).startAt;
                          case 1:
                            return string.of(context).endAt;
                          default:
                            return '';
                        }
                      }()),
                    ),
                    subtitle: Text(date.Mdyyhhmma),
                  );
                },
                indicatorBuilder: (context, index) {
                  return DotIndicator(
                    color: theme.colorScheme.primary,
                    child: Icon(
                      Iconsax.clock,
                      size: 16,
                      color: theme.colorScheme.onPrimary,
                    ),
                  );
                },
                connectorBuilder: (context, index, type) => DashedLineConnector(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopupActions extends StatelessWidget {
  const _PopupActions({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingViewModel>();
    final controller = context.read<BookingViewModel>();

    return listener.booking.status != BookingStatus.completed &&
            controller.role == Role.admin
        ? PopupMenuButton(
            itemBuilder: (context) {
              return {
                0: {
                  'icon': Iconsax.edit,
                  'label': string.of(context).edit,
                },
                1: {
                  'icon': Iconsax.trash,
                  'label': string.of(context).delete,
                }
              }
                  .entries
                  .map(
                    (entry) => PopupMenuItem(
                      value: entry.key,
                      child: ListTile(
                        dense: true,
                        minLeadingWidth: 0,
                        leading: Icon(
                          entry.value['icon'] as IconData,
                          size: 16,
                        ),
                        title: Text(entry.value['label'] as String),
                      ),
                    ),
                  )
                  .toList();
            },
            onSelected: (int value) {
              switch (value) {
                case 0:
                  controller.editBooking();
                  break;
                case 1:
                  controller.deleteBooking();
                  break;
              }
            },
          )
        : const SizedBox.shrink();
  }
}

class _UsersInfo extends StatelessWidget {
  const _UsersInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<BookingViewModel>();
    final booking = context.watch<BookingViewModel>().booking;
    final users = controller.role == Role.admin
        ? [
            booking.customer,
            if (booking.mechanic != null) booking.mechanic!,
          ]
        : [
            booking.bookedBy,
          ];
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0.35,
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: users.length,
          contentsBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              dense: true,
              title: Text(
                user.name ?? string.of(context).annonymous,
              ),
              subtitle: Text(
                validator.string(user.phone, orElse: user.email ?? '')!,
              ),
            );
          },
          oppositeContentsBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(
                (() {
                  switch (user.role) {
                    case Role.admin:
                      return string.of(context).assignedBy;
                    case Role.mechanic:
                      return string.of(context).mechanic;
                    case Role.customer:
                      return string.of(context).customer;
                  }
                }()),
              ),
              titleTextStyle: theme.textTheme.labelMedium?.copyWith(height: 1),
            );
          },
          indicatorBuilder: (context, index) {
            final role = users[index].role;
            return DotIndicator(
              color: theme.colorScheme.primary,
              size: 20,
              child: Icon(
                (() {
                  switch (role) {
                    case Role.admin:
                      return Iconsax.user_octagon;
                    case Role.mechanic:
                      return Iconsax.user_tag;
                    default:
                      return Iconsax.profile_circle;
                  }
                }()),
                size: 16,
                color: theme.colorScheme.onPrimary,
              ),
            );
          },
          connectorBuilder: (context, index, type) => DashedLineConnector(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _CarInfo extends StatelessWidget {
  const _CarInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final carDetails = context.watch<BookingViewModel>().booking.carDetails;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: ListTile(
        dense: true,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: [carDetails.make, carDetails.model].join(' '),
                style: theme.textTheme.bodyMedium,
              ),
              if (carDetails.year != null)
                TextSpan(
                  text: ' (${carDetails.year})',
                  style: theme.textTheme.bodySmall,
                ),
            ],
          ),
        ),
        subtitle: Text(carDetails.plate),
      ),
    );
  }
}

class _BookingServices extends StatelessWidget {
  const _BookingServices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<BookingViewModel>();
    final listener = context.watch<BookingViewModel>();
    final services = listener.booking.services;
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Column(
        children: [
          ListTile(
            title: Text(
              string.of(context).bookingServices,
              style: theme.textTheme.bodyMedium,
            ),
            subtitle: listener.booking.description != null
                ? Text(listener.booking.description!)
                : null,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                nodePosition: 0,
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: services.length,
                contentsBuilder: (context, index) {
                  final service = services[index];
                  bool isCompleted = service.isCompleted ?? false;
                  return ListTile(
                    dense: true,
                    title: Text(service.name),
                    subtitle: service.completedAt != null
                        ? Text(service.completedAt!.Mdyyhhmma)
                        : null,
                    onTap: () {
                      if (controller.role == Role.admin || !isCompleted) {
                        controller.updateService(
                          service.copyWith(
                            isCompleted: !isCompleted,
                            completedAt: DateTime.now(),
                          ),
                          index,
                        );
                      }
                    },
                  );
                },
                indicatorBuilder: (context, index) {
                  final service = services[index];
                  bool isCompleted = service.isCompleted ?? false;
                  return Checkbox(
                    value: isCompleted,
                    onChanged: (_) {
                      if (controller.role == Role.admin || !isCompleted) {
                        controller.updateService(
                          service.copyWith(
                            isCompleted: !isCompleted,
                            completedAt: DateTime.now(),
                          ),
                          index,
                        );
                      }
                    },
                  );
                },
                connectorBuilder: (context, index, type) {
                  final service = services[index];
                  return DashedLineConnector(
                    color: service.isCompleted ?? false
                        ? theme.colorScheme.primary
                        : theme.hintColor,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingNotes extends StatelessWidget {
  const _BookingNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final booking = context.read<BookingViewModel>().booking;
    return validator.isEmpty(booking.notes)
        ? const SizedBox.shrink()
        : Card(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: ListTile(
              title: Text(
                string.of(context).notes,
                style: theme.textTheme.bodyMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '"${booking.notes}"',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          );
  }
}

class _PaymentSummary extends StatelessWidget {
  const _PaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BookingViewModel>();
    return controller.role != Role.mechanic
        ? Card(
            margin: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    string.of(context).paymentSummary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(string.of(context).subtotal),
                  trailing: Text(
                    string.of(context).amount(
                        context.watch<BookingViewModel>().booking.total),
                  ),
                ),
                const Divider(indent: 16, endIndent: 16),
                ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(string.of(context).total),
                  trailing: Text(
                    '\$${context.watch<BookingViewModel>().booking.total}',
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingViewModel>();
    final controller = context.read<BookingViewModel>();
    return controller.role != Role.admin &&
            listener.booking.status == BookingStatus.completed
        ? const SizedBox.shrink()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.role == Role.admin &&
                      listener.booking.status == BookingStatus.completed
                  ? Button(
                      label: string.of(context).receipt,
                      margin: EdgeInsets.fromLTRB(16, 0, 16, dimen.bottom(16)),
                      onPressed: () => controller.generateReceipt(),
                      
                    )
                  : Button(
                      label: string.of(context).complete,
                      loading: listener.isLoading(
                          key: 'completing_booking', orElse: false),
                      disable: !listener.allServicesCompleted,
                      margin: EdgeInsets.fromLTRB(16, 0, 16, dimen.bottom(16)),
                      onPressed: controller.role == Role.mechanic
                          ? () => showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                barrierColor: Colors.transparent,
                                builder: (context) => const AddNotesView(),
                              ).then(
                                (notes) => controller
                                    .completeBooking(notes as String?),
                              )
                          : () => controller.completeBooking(),
                    ),
            ],
          );
  }
}
