import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_day_info.dart';
import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class CalendarDayBox extends StatelessWidget {
  const CalendarDayBox({
    super.key,
    required this.dayNumber,
    this.dayType = DayType.good,
    required this.month
  });

  final int dayNumber;
  final int month;
  final DayType dayType;

  @override
  Widget build(BuildContext context) {
    Map<DayType, Color> dayTypeColors = {
      DayType.good: Color(0xFF75B76A),
      DayType.unavailable: Color(0xFFF1F1F1)
    };
    return ElevatedButton(
      onPressed: () {
        if (dayType == DayType.unavailable) {
          null;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ScreenDayInfo(day: dayNumber, month: month)
            )
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 7,
        backgroundColor: dayTypeColors[dayType],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      child: Text(
        '${dayNumber}',
        style: TextStyle(
            fontSize: 36,
            color: dayType == DayType.unavailable
              ? Color(0xFF818181)
              : Colors.white,
            fontWeight: FontWeight.w500),
      )
    );
  }
}
