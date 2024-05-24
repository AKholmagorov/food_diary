import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Models/food_model.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:intl/intl.dart';

class PromtGenerator extends ConsumerWidget {
  const PromtGenerator({super.key});

  final int period = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var db = ref.watch(databaseProvider);
    DateTime dateFrom = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);
    DateTime dateTo = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    String promt = '';
    List<FoodModel> uniquePeriodFood = [];

    var rows = db.db.select('''
      SELECT DISTINCT food.id, food.name, food.composition FROM meal
      JOIN m2m_meal_food ON meal.id = m2m_meal_food.meal
      JOIN food ON m2m_meal_food.food = food.id
      WHERE meal.date >= '${_dateToString(dateFrom)}' and meal.date <= '${_dateToString(dateTo)}'
    ''');

    for (var row in rows) {
      uniquePeriodFood.add(FoodModel.fromMap(row));
    }

    promt += 'Пища: ';
    for (var food in uniquePeriodFood) {
      String foodComposition = food.composition != '' ? ' (${food.composition})' : '';
      promt += '${food.name}$foodComposition, ';
    }

    promt = promt.substring(0, promt.length - 2);

    int dayNumber = 0;
    for (var i = 0; i < period; i++) {
      DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day-i);
      var mealRows = db.db.select('''
        SELECT * FROM meal WHERE date = '${_dateToString(date)}'
      ''');

      if (mealRows.isEmpty)
        continue;
      else
        dayNumber++;

      promt += '\nДень ${dayNumber}';

      for (int j = 0; j < mealRows.length; j++) {
        var meal = mealRows[j];
        promt += '\t\nПрием ${j+1}: ';

        var foodRows = db.db.select('''
          SELECT DISTINCT food.name FROM meal
          JOIN m2m_meal_food ON meal.id = m2m_meal_food.meal
          JOIN food ON m2m_meal_food.food = food.id
          WHERE meal.id = ${meal['id']}
        ''');

        for (var foodRow in foodRows) {
          promt += '${foodRow['name']}, ';
        }

        promt = promt.substring(0, promt.length - 2);
      }

      var dayRows = db.db.select('''
        SELECT * FROM days WHERE date = '${_dateToString(date)}'
      ''');
      DayModel dayModel = DayModel.fromMap(dayRows.first);

      List<String>? symptoms = [];

      dayModel.pain > 0 ? symptoms.add('Боль: ${dayModel.pain}/5, ') : null;
      dayModel.blood > 0 ? symptoms.add('Кровь: ${dayModel.pain}/5, ') : null;
      dayModel.slime > 0 ? symptoms.add('Слизь: ${dayModel.pain}/5, ') : null;
      dayModel.diarrhea > 0 ? symptoms.add('Диарея: ${dayModel.pain}/5, ') : null;
      dayModel.flatulence > 0 ? symptoms.add('Метеоризм: ${dayModel.pain}/5, ') : null;

      promt += '\nСимптомы: ';
      if (symptoms.isEmpty) {
        promt += 'отсутствуют';
      }
      else {
        for (var symptom in symptoms) {
          promt += symptom; 
        }
        promt = promt.substring(0, promt.length - 2);
      }
    }

    print(promt);
    return const Placeholder();
  }

  String _dateToString(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}