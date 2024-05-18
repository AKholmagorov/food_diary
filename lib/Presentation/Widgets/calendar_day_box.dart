import 'package:flutter/material.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Screens/screen_day_info.dart';
import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class CalendarDayBox extends StatelessWidget {
  const CalendarDayBox({
    super.key,
    required this.day, 
    required this.dayNumber
  });

  final DayModel? day;
  final int dayNumber;

  @override
  Widget build(BuildContext context) {
    Map<DayType?, Color> dayTypeColors = {
      DayType.good: Color(0xFF75B76A),
      DayType.not_good: Color(0xFFF9C74F),
      DayType.bad: Color(0xFFE63946),
      DayType.empty: Color(0xFFD3D3D3),
      null: Color(0xFFF1F1F1)
    };
    return ElevatedButton(
      onPressed: () {
        if (day == null) {
          null;
        } 
        else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ScreenDayInfo(day: day!)
            )
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 7,
        backgroundColor: dayTypeColors[day?.dayType],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      child: Text(
        '${dayNumber}',
        style: TextStyle(
          fontSize: 36,
          color: day == null
            ? Color(0xFF818181)
            : Colors.white,
          fontWeight: FontWeight.w500
        ),
      )
    );
  }
}
