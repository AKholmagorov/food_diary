class FoodModel {
  final int id;
  final String name;
  final String? composition;

  FoodModel({
    required this.id,
    required this.name, 
    required this.composition,
  });

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'] as int,
      name: map['name'] as String,
      composition: map['composition'] as String?
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodModel &&
      other.id == id;
  }
}