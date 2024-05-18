import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class DayModel {
  final int id;
  final DateTime date;
  DayType dayType;
  double sleepHours;
  int waterCount;
  String? noteText;
  int blood;
  int slime;
  int pain;
  int flatulence;
  int diarrhea;

  DayModel({
    required this.id,
    required this.date, 
    required this.dayType, 
    required this.sleepHours, 
    required this.waterCount, 
    required this.noteText,
    required this.blood,
    required this.diarrhea,
    required this.flatulence,
    required this.pain,
    required this.slime,
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
      sleepHours: map['sleep_hours'] as double,
      waterCount: map['water_count'] as int,
      noteText: map['note'],
      pain: map['pain'],
      blood: map['blood'],
      diarrhea: map['diarrhea'],
      flatulence: map['flatulence'],
      slime: map['slime']
    );
  }

/*   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'dayType': dayType,
      'sleepHours': sleepHours,
      'waterCount': waterCount,
      'noteText': noteText,
    };
  } */
}