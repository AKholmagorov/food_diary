import 'package:flutter/material.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Models/drug_model.dart';
import 'package:food_diary/Models/food_model.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:food_diary/Models/medication_model.dart';
import 'package:food_diary/Presentation/Widgets/utils/symptom_types.dart';
import 'package:intl/intl.dart';

class DayModelNotifier extends ChangeNotifier {
  final FoodDiaryDB db;

  DayModel? currentDay;
  DateTime dayDate;
  List<MealModel> meals = [];
  List<MedicationModel> medications = [];

  DayModelNotifier(this.db, this.dayDate) {
    loadDay(dayDate);
  }

  Future<void> loadDay(DateTime date) async {
    currentDay = await db.getDay(date) ?? await db.getNewDay();
    loadMeal();
    loadMedications();
    notifyListeners();
  }

  void loadMeal() {
    meals.clear();

    var resultSet = db.db.select('''
      SELECT id FROM meal
      WHERE date = '${_dateToString(currentDay != null ? currentDay!.date : dayDate)}'
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

  void loadMedications() {
    medications.clear();

    var resultSet = db.db.select('''
      SELECT id FROM medications
      WHERE date = '${_dateToString(currentDay != null ? currentDay!.date : dayDate)}'
    ''');

    for (var value in resultSet) {
      List<DrugModel> drugsList = [];

      var set = db.db.select('''
        SELECT drugs.id, drugs.name
        FROM drugs
        JOIN m2m_medication_drugs ON drugs.id = m2m_medication_drugs.drug
        WHERE m2m_medication_drugs.medication = ${value['id']};
      ''');

      for (var value in set) {
        drugsList.add(DrugModel.fromMap(value));
      }
      medications.add(MedicationModel(drugs: drugsList, id: value['id']));
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

  void addMedication(List<DrugModel> drugList) {
    db.db.execute('''
      INSERT INTO medications (date) VALUES ('${_dateToString(currentDay!.date)}');
    ''');

    int medicationID = db.db.lastInsertRowId;
    for (var drug in drugList) {
      db.db.execute('''
        INSERT INTO m2m_medication_drugs (medication, drug) 
        VALUES ($medicationID, ${drug.id});
      ''');
    }

    medications.add(MedicationModel(drugs: drugList, id: medicationID));
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

  void editMedication(List<DrugModel> drugList, int medicationID) {
    db.db.execute('''
      DELETE FROM m2m_medication_drugs
      WHERE medication = $medicationID
    ''');
    
    for (var drug in drugList) {
      db.db.execute('''
        INSERT INTO m2m_medication_drugs (medication, drug) 
        VALUES ($medicationID, ${drug.id});
      ''');
    }

    medications.firstWhere((e) => e.id == medicationID).drugs = drugList;
    notifyListeners();
  }

  void removeMeal(int mealID) {
    db.db.execute('''
      DELETE FROM meal WHERE id = $mealID
    ''');

    meals.remove(meals.firstWhere((e) => e.id == mealID));
    notifyListeners();
  }

  void removeMedication(int medicationID) {
    db.db.execute('''
      DELETE FROM medications WHERE id = $medicationID
    ''');

    medications.remove(medications.firstWhere((e) => e.id == medicationID));
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