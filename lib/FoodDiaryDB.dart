import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:intl/intl.dart';

class FoodDiaryDB {
  Database db;

  FoodDiaryDB({required this.db});

  String _dateToString(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Future<DayModel> getNewDay() async {
    db.execute('''
      INSERT INTO days (date) VALUES ('${_dateToString(DateTime.now())}');
    ''');

    var result = await db.select('''
      SELECT * FROM days WHERE date = '${_dateToString(DateTime.now())}'; 
    ''');

    return DayModel.fromMap(result.first);
  }

  Future<DayModel?> getDay(DateTime date) async {
    var result = await db.select('''
      SELECT * FROM days 
      WHERE date = '${_dateToString(date)}';
    ''');

    if (!result.isEmpty)
      return DayModel.fromMap(result.first);
    else
      return null;
  }

  Future<List<MealModel>> getAllMeal() async {
    List<MealModel> mealList = [];
    
    var resultSet = await db.select('''
      SELECT * FROM meal;
    ''');

    for (var row in resultSet) {
      mealList.add(MealModel.fromMap(row));
    }

    return mealList;
  }
}