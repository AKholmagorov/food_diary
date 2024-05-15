import 'package:food_diary/Domain/Entities/day_entity.dart';
import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class DayModel extends Day {
  DayModel({
    required super.id, 
    required super.date, 
    required super.dayType, 
    required super.sleepHours, 
    required super.waterCount, 
    required super.noteText
  });

  factory DayModel.fromMap(Map<String, dynamic> map) {
    return DayModel(
      id: map['id'],
      date: map['date'],
      dayType: map['dayType'] == 'good' ? DayType.good : DayType.good,
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