import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/shared/colors.dart';
import '../../../core/shared/enums.dart';
import '../../auth/model/user_model.dart';
import 'vehicle_model.dart';
import 'service_model.dart';

class Booking {
  final String uid;
  final User bookedBy;
  final String title;
  final String? description;
  final User customer;
  final Vehicle carDetails;
  final DateTime bookedAt;
  final DateTime startAt;
  final DateTime endAt;
  final User? mechanic;
  final BookingStatus status;
  final List<Service> services;
  final String? notes;

  const Booking({
    required this.uid,
    required this.bookedBy,
    required this.title,
    this.description,
    required this.customer,
    required this.carDetails,
    required this.bookedAt,
    required this.startAt,
    required this.endAt,
    this.mechanic,
    this.status = BookingStatus.pending,
    this.services = const [],
    this.notes,
  });

  Booking copyWith({
    String? uid,
    User? bookedBy,
    String? title,
    String? description,
    User? customer,
    Vehicle? carDetails,
    DateTime? bookedAt,
    DateTime? startAt,
    DateTime? endAt,
    User? mechanic,
    BookingStatus? status,
    List<Service>? services,
    String? notes,
  }) {
    return Booking(
      uid: uid ?? this.uid,
      bookedBy: bookedBy ?? this.bookedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      customer: customer ?? this.customer,
      carDetails: carDetails ?? this.carDetails,
      bookedAt: bookedAt ?? this.bookedAt,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      mechanic: mechanic ?? this.mechanic,
      status: status ?? this.status,
      services: services ?? this.services,
      notes: notes ?? this.notes,
    );
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      uid: map['uid'],
      bookedBy: User.fromMap(map['booked_by'] ?? {}),
      title: map['title'],
      description: map['description'],
      customer: User.fromMap(map['customer'] ?? {}),
      carDetails: Vehicle.fromMap(map['car_details'] ?? {}),
      bookedAt: (map['booked_at'] as Timestamp).toDate(),
      startAt: (map['start_at'] as Timestamp).toDate(),
      endAt: (map['end_at'] as Timestamp).toDate(),
      mechanic: map['mechanic'] != null ? User.fromMap(map['mechanic']) : null,
      status: map['status'] == null
          ? BookingStatus.pending
          : BookingStatus.values.byName(map['status']),
      services: List<Service>.from(
        map['services']?.map((x) => Service.fromMap(x)) ?? [],
      ),
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'booked_by': bookedBy.toMap(),
      'title': title,
      'car_details': carDetails.toMap(),
      'customer': customer.toMap(),
      'booked_at': Timestamp.fromDate(bookedAt),
      'start_at': Timestamp.fromDate(startAt),
      'end_at': Timestamp.fromDate(endAt),
      'mechanic': mechanic?.toMap(),
      'status': status.name,
      'services': services.map((x) => x.toMap()).toList(),
      'notes': notes,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Booking && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

extension BookingExtensions on Booking {
  String get service {
    return services.map((e) => e.name).join(', ');
  }

  Color get alert {
    return (() {
      switch (status) {
        case BookingStatus.pending:
          return ColorPalette.dark().tertiary;
        case BookingStatus.accepted:
          return ColorPalette.dark().primary;
        default:
          return ColorPalette.dark().secondary;
      }
    }());
  }
}
