import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/service/navigation_service.dart';
import '../../../core/shared/dimens.dart';
import '../../../core/shared/strings.dart';

showCustomDateTimePicker({
  BuildContext? context,
  DateTime? initialDateTime,
  CupertinoDatePickerMode? mode,
  Text? title,
  Function(DateTime)? onChanged,
  Function(DateTime)? onSelected,
}) {
  showModalBottomSheet(
    context: context ?? navigator.context,
    builder: (_) {
      return _DateRangePicker(
        key: const Key('date_time_picker_key'),
        dateTime: initialDateTime,
        mode: mode ?? CupertinoDatePickerMode.dateAndTime,
        title: title,
        onChanged: onChanged,
        onSelected: onSelected,
      );
    },
  );
}

// ignore: must_be_immutable
class _DateRangePicker extends StatelessWidget {
  final DateTime? dateTime;
  final CupertinoDatePickerMode mode;
  final Text? title;
  final Function(DateTime)? onChanged;
  final Function(DateTime)? onSelected;
  late DateTime? _tempDateTime;

  _DateRangePicker({
    super.key,
    this.dateTime,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.title,
    this.onChanged,
    this.onSelected,
  }) : _tempDateTime = dateTime;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          tileColor: theme.colorScheme.shadow,
          trailing: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (_tempDateTime != null) onSelected?.call(_tempDateTime!);
            },
            child: Text(
              string.of(context).next.toUpperCase(),
              style: theme.textTheme.titleMedium!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: DefaultTextStyle(
              style: theme.textTheme.titleSmall!,
              child: title!,
            ),
          ),
        SizedBox(
          height: dimen.height * 0.25,
          child: CupertinoDatePicker(
            key: const Key('date_range_picker_from_key'),
            mode: mode,
            initialDateTime: dateTime,
            maximumDate: DateTime.now().add(const Duration(days: 90)),
            onDateTimeChanged: (DateTime value) {
              _tempDateTime = value;
              onChanged?.call(value);
            },
          ),
        ),
        const SafeArea(
          top: false,
          child: SizedBox.shrink(),
        )
      ],
    );
  }
}
