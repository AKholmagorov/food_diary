import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class Day {
  final int id;
  final String date;
  final DayType dayType;
  final int sleepHours;
  final int waterCount;
  final String noteText;

  Day({
    required this.id,
    required this.date, 
    required this.dayType, 
    required this.sleepHours, 
    required this.waterCount, 
    required this.noteText
  });
}