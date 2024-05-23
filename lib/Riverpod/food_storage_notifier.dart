import 'package:flutter/material.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Models/food_model.dart';

class FoodStorageNotifier extends ChangeNotifier {
  final FoodDiaryDB db;
  late List<FoodModel> foodList;

  FoodStorageNotifier(this.db) {
    getAllMeal();
  }

  void getAllMeal() {
    foodList = db.getAllFood();
    notifyListeners();
  }

  FoodModel getFood(int id) {
    return foodList.firstWhere((e) => e.id == id);
  }

  void addFood(String foodName, String? composition) {
    db.db.execute('''
      INSERT INTO food (name, composition)
      VALUES ('$foodName', '$composition');
    ''');

    var res = db.db.select('''
      SELECT * FROM food WHERE id = ${db.db.lastInsertRowId};
    ''');

    foodList.add(FoodModel.fromMap(res.first));
    notifyListeners();
  }

  void editFood(int foodID, String newFoodName, String? newComposition) {
    db.db.execute('''
      UPDATE food
      SET name = '${newFoodName}', composition = '${newComposition}'
      WHERE id = $foodID;
    ''');

    var res = db.db.select('''
      SELECT * FROM food WHERE id = $foodID;
    ''');

    foodList.remove(foodList.firstWhere((e) => e.id == foodID));
    foodList.add(FoodModel.fromMap(res.first));
    getAllMeal();
    
    notifyListeners();
  }

  void removeFood(int foodID) {
    db.db.execute('''
      DELETE FROM food
      WHERE id = $foodID;
    ''');

    foodList.remove(foodList.firstWhere((e) => e.id == foodID));
    getAllMeal();
    
    notifyListeners();
  }
}