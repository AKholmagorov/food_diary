import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Riverpod/day_model_notifier.dart';
import 'package:food_diary/Riverpod/food_storage_notifier.dart';
import 'package:sqlite3/sqlite3.dart';

final databaseProvider = Provider<FoodDiaryDB>((ref) {
  final db = sqlite3.open('food_diary_db');
  return FoodDiaryDB(db: db);
});

final currentDayProvider = ChangeNotifierProvider<DayModelNotifier>((ref) {
  final db = ref.read(databaseProvider);
  return DayModelNotifier(db, DateTime.now());
});

final foodStorageProvider = ChangeNotifierProvider<FoodStorageNotifier>((ref) {
  final db = ref.read(databaseProvider);
  return FoodStorageNotifier(db);
});