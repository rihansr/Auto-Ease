class Vehicle {
  final String uid;
  final String? brand;
  final String? model;
  final int? year;
  final String regPlate;

  const Vehicle({
    required this.uid,
    this.brand,
    this.model,
    this.year,
    required this.regPlate,
  });

  Vehicle copyWith({
    String? uid,
    String? brand,
    String? model,
    int? year,
    String? regPlate,
  }) {
    return Vehicle(
      uid: uid ?? this.uid,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      regPlate: regPlate ?? this.regPlate,
    );
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      uid: map['id'],
      brand: map['brand'],
      model: map['model'],
      year: map['year'],
      regPlate: map['registration_plate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'brand': brand,
      'model': model,
      'year': year,
      'registration_plate': regPlate,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vehicle && runtimeType == other.runtimeType && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
