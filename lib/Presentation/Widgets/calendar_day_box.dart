import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Screens/screen_day_info.dart';
import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';

class CalendarDayBox extends ConsumerStatefulWidget {
  const CalendarDayBox({
    super.key,
    required this.day, 
    required this.dayNumber
  });

  final DayModel? day;
  final int dayNumber;

  @override
  CalendarDayBoxState createState() => CalendarDayBoxState();
}

class CalendarDayBoxState extends ConsumerState<CalendarDayBox> {
  DayModel? _currentDay;
  
  @override
  void initState() {
    super.initState();
    _currentDay = widget.day;
  }

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
      onPressed: () async {
        if (widget.day == null) {
          null;
        } 
        else {
          await ref.read(currentDayProvider).loadDay(widget.day!.date);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ScreenDayInfo();
              }
            )
          );
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 7,
        backgroundColor: dayTypeColors[_currentDay?.dayType],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
        )
      ),
      child: Text(
        '${widget.dayNumber}',
        style: TextStyle(
          fontSize: 36,
          color: widget.day == null
            ? Color(0xFF818181)
            : Colors.white,
          fontWeight: FontWeight.w500
        ),
      )
    );
  }
}
