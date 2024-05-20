import 'package:flutter/material.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Models/food_model.dart';

class FoodStorageNotifier extends ChangeNotifier {
  final FoodDiaryDB db;
  late Future<List<FoodModel>> foodList;

  FoodStorageNotifier(this.db) {
    getAllMeal();
  }

  Future<void> getAllMeal() async {
    foodList = db.getAllMeal();
    notifyListeners();
  }

  Future<FoodModel> getFood(int id) async {
    final _foodList = await foodList;
    return _foodList.firstWhere((e) => e.id == id);
  }

  void addFood(String foodName, String? composition) {
    db.db.execute('''
      INSERT INTO food (name, composition)
      VALUES ($foodName, $composition);
    ''');

    var res = db.db.select('''
      SELECT * FROM food WHERE id = ${db.db.lastInsertRowId};
    ''');

    
  }
}