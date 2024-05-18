class MealModel {
  final int id;
  final String name;
  final String composition;

  MealModel({required this.id, required this.name, required this.composition});

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'] as int,
      name: map['name'] as String,
      composition: map['composition'] as String
    );
  }
}