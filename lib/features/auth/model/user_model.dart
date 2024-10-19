import 'dart:convert';
import '../../../core/shared/enums.dart';

class User {
  final String uid;
  final String? name;
  final String email;
  final String? phone;
  final Role role;

  const User({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    required this.role,
  });

  User copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    Role? role,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      name: map['name'],
      email: map['email'] ?? '',
      phone: map['phone'],
      role: Role.values.byName(map["role"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
