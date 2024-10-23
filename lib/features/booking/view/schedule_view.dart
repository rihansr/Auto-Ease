import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/strings.dart';
import '../../../core/shared/utils.dart';
import '../../../core/widget/base_widget.dart';
import '../viewmodel/bookings_viewmodel.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseWidget<BookingsViewModel>(
      model: BookingsViewModel(),
      onInit: (controller) => controller.init(),
      builder: (context, controller, child) => CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: Text(string.of(context).schedule),
            toolbarHeight: dimen.toolBarHeight,
            titleTextStyle: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            pinned: true,
            actions: const [
              Center(
                child: _CalenderViewOptions(
                  key: ValueKey('calender_view_options'),
                ),
              )
            ],
          ),
          const SliverFillRemaining(
            child: _CalenderView(
              key: ValueKey('calender_view'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalenderViewOptions extends StatelessWidget {
  const _CalenderViewOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingsViewModel>();
    final controller = context.read<BookingsViewModel>();
    return DropdownButton(
      value: listener.calendarView,
      underline: const SizedBox(),
      items: [CalendarView.day, CalendarView.week, CalendarView.month]
          .map(
            (view) => DropdownMenuItem(
              key: ObjectKey(view),
              value: view,
              child: Text(
                view.name.capitalize,
                style: const TextStyle(height: 1),
              ),
            ),
          )
          .toList(),
      onChanged: (value) => controller.calendarView = value!,
    );
  }
}

class _CalenderView extends StatelessWidget {
  const _CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<BookingsViewModel>();
    final controller = context.read<BookingsViewModel>();
    return SfCalendar(
      controller: controller.calendarController,
      view: controller.calendarView,
      dataSource: listener.dataSource,
      showNavigationArrow: true,
      showCurrentTimeIndicator: true,
      showDatePickerButton: true,
      cellEndPadding: 16,
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: true,
        agendaItemHeight: 64,
        agendaViewHeight: dimen.height * 0.25,
      ),
      onTap: (details) {
        if (details.appointments != null) {
          final appointment = details.appointments!.first;
        }
      },
    );
  }
}
