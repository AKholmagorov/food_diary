import 'package:flutter/material.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Models/food_model.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:food_diary/Presentation/Widgets/utils/symptom_types.dart';
import 'package:intl/intl.dart';

class DayModelNotifier extends ChangeNotifier {
  final FoodDiaryDB db;

  DayModel? currentDay;
  DateTime dayDate;
  List<MealModel> meals = [];

  DayModelNotifier(this.db, this.dayDate) {
    loadDay(dayDate);
  }

  Future<void> loadDay(DateTime date) async {
    currentDay = await db.getDay(date) ?? await db.getNewDay();
    loadMeal(date);
    notifyListeners();
  }

  void loadMeal(DateTime date) {
    meals.clear();

    var resultSet = db.db.select('''
      SELECT id FROM meal
      WHERE date = '${_dateToString(date)}'
    ''');

    for (var value in resultSet) {
      List<FoodModel> foodList = [];

      var set = db.db.select('''
        SELECT food.id, food.name, food.composition
        FROM food
        JOIN m2m_meal_food ON food.id = m2m_meal_food.food
        WHERE m2m_meal_food.meal = ${value['id']};
      ''');

      for (var value in set) {
        foodList.add(FoodModel.fromMap(value));
      }
      meals.add(MealModel(food: foodList, id: value['id']));
    }

    notifyListeners();
  }

  void addMeal(List<FoodModel> foodList) {
    db.db.execute('''
      INSERT INTO meal (date) VALUES ('${_dateToString(currentDay!.date)}');
    ''');

    int mealID = db.db.lastInsertRowId;
    for (var food in foodList) {
      db.db.execute('''
        INSERT INTO m2m_meal_food (meal, food) 
        VALUES ($mealID, ${food.id});
      ''');
    }

    meals.add(MealModel(food: foodList, id: mealID));
    notifyListeners();
  }

  void editMeal(List<FoodModel> foodList, int mealID) {
    db.db.execute('''
      DELETE FROM m2m_meal_food
      WHERE meal = $mealID
    ''');
    
    for (var food in foodList) {
      db.db.execute('''
        INSERT INTO m2m_meal_food (meal, food) 
        VALUES ($mealID, ${food.id});
      ''');
    }

    meals.firstWhere((e) => e.id == mealID).food = foodList;
    notifyListeners();
  }

  void removeMeal(int mealID) {
    db.db.execute('''
      DELETE FROM meal WHERE id = $mealID
    ''');
    
    meals.remove(meals.firstWhere((e) => e.id == mealID));
    notifyListeners();
  }

  void updateSleepTime(double value) {
    currentDay!.sleepHours = value;
    db.db.execute('''
      UPDATE days 
      SET sleep_hours = $value 
      WHERE date = '${_dateToString(currentDay!.date)}';
    ''');
    notifyListeners();
  }

  void updateWaterCount(int value) {
    currentDay!.waterCount = value;
    db.db.execute('''
      UPDATE days 
      SET water_count = $value 
      WHERE date = '${_dateToString(currentDay!.date)}';
    ''');
    notifyListeners();
  }

  void updateNoteText(String value) {
    currentDay!.noteText = value;
    db.db.execute('''
      UPDATE days 
      SET note = '$value'
      WHERE date = '${_dateToString(currentDay!.date)}';
    ''');
    notifyListeners();
  }

  void updateSymptomValue(SymptomTypes symptomType, int newValue) {
    db.db.execute('''
      UPDATE days 
      SET ${symptomType.name} = $newValue
      WHERE date = '${_dateToString(currentDay!.date)}';
    ''');
    notifyListeners();
  }

  String _dateToString(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}