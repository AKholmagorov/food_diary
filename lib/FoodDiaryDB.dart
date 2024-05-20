import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Models/food_model.dart';
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

  Future<List<FoodModel>> getAllMeal() async {
    List<FoodModel> foodList = [];
    
    var resultSet = await db.select('''
      SELECT * FROM food;
    ''');

    for (var row in resultSet) {
      foodList.add(FoodModel.fromMap(row));
    }

    return foodList;
  }
}