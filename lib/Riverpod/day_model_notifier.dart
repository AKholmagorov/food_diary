import 'package:flutter/material.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Presentation/Widgets/utils/symptom_types.dart';
import 'package:intl/intl.dart';

class DayModelNotifier extends ChangeNotifier {
  DayModel? currentDay;
  final FoodDiaryDB db;
  DateTime dayDate;

  DayModelNotifier(this.db, this.dayDate) {
    loadDay(dayDate);
  }

  Future<void> loadDay(DateTime date) async {
    currentDay = await db.getDay(date) ?? await db.getNewDay();
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