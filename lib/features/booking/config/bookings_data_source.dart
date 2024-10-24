import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../model/booking_model.dart';

class BookingsDataSource extends CalendarDataSource<Booking> {
  BookingsDataSource(this.source);

  List<Booking> source;

  @override
  List<Booking> get appointments => source;

  @override
  Object? getId(int index) {
    return source[index].uid;
  }

  @override
  DateTime getStartTime(int index) {
    return source[index].startAt;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].endAt;
  }

  @override
  String getSubject(int index) {
    return source[index].title;
  }

  @override
  String? getNotes(int index) {
    return source[index].description;
  }

  @override
  Color getColor(int index) {
    return source[index].alert;
  }

  @override
  bool isAllDay(int index) {
    return source[index].startAt.day != source[index].endAt.day;
  }
}
