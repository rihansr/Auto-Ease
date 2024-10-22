import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String uid;
  final String name;
  final bool? isCompleted;
  final num price;
  final DateTime? completedAt;

  const Service({
    required this.uid,
    required this.name,
    this.price = 0,
    this.isCompleted,
    this.completedAt,
  });

  Service copyWith({
    String? name,
    num? price,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Service(
      uid: uid,
      name: name ?? this.name,
      price: price ?? this.price,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      uid: map['uid'],
      name: map['name'],
      price: map['price'] ?? 0,
      isCompleted: map['is_completed'],
      completedAt: (map['completed_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'price': price,
      if(isCompleted != null) 'is_completed': isCompleted,
      if(completedAt != null) 'completed_at': completedAt,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service && other.uid == uid;
  }

  @override
  int get hashCode {
    return uid.hashCode;
  }
}
