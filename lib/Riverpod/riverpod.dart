import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Riverpod/day_model_notifier.dart';
import 'package:food_diary/Riverpod/drug_storage_notifier.dart';
import 'package:food_diary/Riverpod/food_storage_notifier.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as path;

// TODO: remove?
Future<void> getPath() async {
  final directory = await getApplicationDocumentsDirectory();
  final dbPath = path.join(directory.path, 'food_diary_db');
  Database db = sqlite3.open(dbPath);
}

final databaseProvider = Provider<FoodDiaryDB>((ref) {
  // android path
  // final db = sqlite3.open('/data/user/0/com.example.food_diary/app_flutter/food_diary_db');
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

final drugStorageProvider = ChangeNotifierProvider<DrugStorageNotifier>((ref) {
  final db = ref.read(databaseProvider);
  return DrugStorageNotifier(db);
});