import 'package:food_diary/Data/Models/day_model.dart';
import 'package:intl/intl.dart';
import 'package:sqlite3/sqlite3.dart';

class DayDataSource {
  final Database db;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');


  DayDataSource({required this.db});

  Future<void> addDay(DayModel dayModel) async {
    db.execute('''
      INSERT INTO days 
      (date, day_type, sleep_hours, water_count, note)
      VALUES (
        '${dayModel.date}',
        '${dayModel.dayType.name}', 
        ${dayModel.sleepHours}, 
        ${dayModel.waterCount}, 
        '${dayModel.noteText}'
      );
    ''');
  }

  Future<DayModel> getDay(DateTime date) async {
    String dateString = formatter.format(date);

    var result = await db.select('''
      SELECT * FROM days 
      WHERE date = '$dateString';
    ''');

    return DayModel.fromMap(result.first);
  }
}