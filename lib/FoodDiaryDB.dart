import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:intl/intl.dart';

class FoodDiaryDB {
  Database db;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  FoodDiaryDB({required this.db});

  Future<DayModel> getNewDay() async {
    String dateStr = formatter.format(DateTime.now());
    
    db.execute('''
      INSERT INTO days (date) VALUES ('$dateStr');
    ''');

    var result = await db.select('''
      SELECT * FROM days WHERE date = '$dateStr'; 
    ''');

    return DayModel.fromMap(result.first);
  }

  Future<DayModel?> getDay(DateTime date) async {
    String dateStr = formatter.format(date);

    var result = await db.select('''
      SELECT * FROM days 
      WHERE date = '$dateStr';
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