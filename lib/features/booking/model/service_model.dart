import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String title;
  final bool isCompleted;
  final DateTime? completedAt;

  const Service({
    required this.title,
    this.isCompleted = false,
     this.completedAt,
  });

  Service copyWith({
    String? title,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Service(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      title: map['title'],
      isCompleted: map['is_completed'] ?? false,
      completedAt: (map['completed_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'is_completed': isCompleted,
      'completed_at': completedAt,
    };
  }
}
