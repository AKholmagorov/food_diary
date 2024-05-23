class DrugModel {
  final int id;
  final String name;

  DrugModel({required this.id, required this.name});

  factory DrugModel.fromMap(Map<String, dynamic> map) {
    return DrugModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrugModel &&
      other.id == id;
  }
}