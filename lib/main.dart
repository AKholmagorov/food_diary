import 'package:flutter/material.dart';
import 'package:food_diary/Data/DataSources/day_data_source.dart';
import 'package:food_diary/Data/Models/day_model.dart';
import 'package:food_diary/Data/Repositories/day_repository_impl.dart';
import 'package:food_diary/Domain/Repositories/day_repository.dart';
import 'package:food_diary/Presentation/Widgets/fd_nav_bar.dart';
import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';
import 'package:food_diary/Presentation/Widgets/utils/theme_constants.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {/* 
  Database db = sqlite3.open('food_diary_db');
  DayRepository dayRep = DayRepositoryImpl(dayDataSource: DayDataSource(db: db));

  DayModel day = DayModel(
    id: -1, 
    date: '2024-05-10', 
    dayType: DayType.good, 
    sleepHours: 8, 
    waterCount: 12, 
    noteText: 'note_texxxt'
  );

  // dayRep.addDay(day);
  DayModel dayModel = await dayRep.getDay(DateTime.now());
  print(dayModel.noteText);
 */
  runApp(AppEntryPoint());
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: foodDiaryDarkTheme,
      themeMode: ThemeMode.dark,
      home: FoodDiaryNavBar(),
    );
  }
}

