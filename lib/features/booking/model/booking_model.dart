import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/shared/enums.dart';
import '../../auth/model/user_model.dart';
import 'vehicle_model.dart';
import 'service_model.dart';

class Booking {
  final String uid;
  final String title;
  final String? description;
  final User customer;
  final Vehicle carDetails;
  final DateTime startAt;
  final DateTime endAt;
  final User? mechanic;
  final BookingStatus status;
  final List<Service> services;
  final String? notes;

  const Booking({
    required this.uid,
    required this.title,
    this.description,
    required this.customer,
    required this.carDetails,
    required this.startAt,
    required this.endAt,
    this.mechanic,
    this.status = BookingStatus.pending,
    this.services = const [],
    this.notes,
  });

  Booking copyWith({
    String? uid,
    String? title,
    String? description,
    User? customer,
    Vehicle? carDetails,
    DateTime? startAt,
    DateTime? endAt,
    User? mechanic,
    BookingStatus? status,
    List<Service>? services,
    String? notes,
  }) {
    return Booking(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      customer: customer ?? this.customer,
      carDetails: carDetails ?? this.carDetails,
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
      uid: map['id'],
      title: map['title'],
      description: map['description'],
      customer: User.fromMap(map['customer'] ?? {}),
      carDetails: Vehicle.fromMap(map['car_details'] ?? {}),
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
      'id': uid,
      'title': title,
      'car_details': carDetails.toMap(),
      'customer': customer.toMap(),
      'start_at': startAt,
      'end_at': endAt,
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
