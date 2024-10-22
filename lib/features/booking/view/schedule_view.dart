import 'package:flutter/material.dart';
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
      onInit: (cotroller) => cotroller.init(),
      builder: (context, cotroller, child) => CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title: Text(string.of(context).schedule),
            toolbarHeight: dimen.toolBarHeight,
            titleTextStyle: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            pinned: true,
            actions: [
              Center(
                child: DropdownButton(
                  value: cotroller.calendarView,
                  underline: const SizedBox(),
                  items:
                      [CalendarView.day, CalendarView.week, CalendarView.month]
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
                  onChanged: (value) => cotroller.calendarView = value!,
                ),
              )
            ],
          ),
          SliverFillRemaining(
            child: SfCalendar(
              controller: cotroller.calendarController,
              view: cotroller.calendarView,
              dataSource: cotroller.dataSource,
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
            ),
          ),
        ],
      ),
    );
  }
}
