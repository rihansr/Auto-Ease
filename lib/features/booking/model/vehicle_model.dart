class Vehicle {
  final String uid;
  final String? make;
  final String? model;
  final String? year;
  final String plate;

  const Vehicle({
    required this.uid,
    this.make,
    this.model,
    this.year,
    required this.plate,
  });

  Vehicle copyWith({
    String? uid,
    String? make,
    String? model,
    String? year,
    String? plate,
  }) {
    return Vehicle(
      uid: uid ?? this.uid,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      plate: plate ?? this.plate,
    );
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      uid: map['uid'],
      make: map['make'],
      model: map['model'],
      year: map['year'],
      plate: map['plate_no'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'make': make,
      'model': model,
      'year': year,
      'plate_no': plate,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vehicle && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
