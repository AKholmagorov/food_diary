import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class DayModel {
  final int id;
  final DateTime date;
  final DayType dayType;
  final int sleepHours;
  final int waterCount;
  final String? noteText;

  DayModel({
    required this.id,
    required this.date, 
    required this.dayType, 
    required this.sleepHours, 
    required this.waterCount, 
    required this.noteText
  });

  factory DayModel.fromMap(Map<String, dynamic> map) {
    DayType extractGetType(String strType) {
      switch (strType) {
        case 'empty':
          return DayType.empty;
        case 'good':
          return DayType.good;
        case 'not_good':
          return DayType.not_good;
        case 'bad':
          return DayType.bad;
        case 'unavailable':
          return DayType.unavailable;
        default:
          throw ArgumentError('Invalid day type: $strType');
      }
    }
    
    return DayModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date']),
      dayType: extractGetType(map['day_type'] as String),
      sleepHours: map['sleep_hours'] as int,
      waterCount: map['water_count'] as int,
      noteText: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'dayType': dayType,
      'sleepHours': sleepHours,
      'waterCount': waterCount,
      'noteText': noteText,
    };
  }
}