import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/calendar_day_box.dart';
import 'package:food_diary/Presentation/Widgets/utils/day_types.dart';
import 'package:food_diary/Presentation/Widgets/utils/get_month_name.dart';

class ScreenCalendar extends StatefulWidget {
  const ScreenCalendar({super.key});

  @override
  State<ScreenCalendar> createState() => _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  DateTime selectedDate = DateTime.now();
  int monthOffset = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(24),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 72,
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemCount: DateTime(selectedDate.year, selectedDate.month + monthOffset, 0).day,
            itemBuilder: (context, index) {
              if (index + 1 <= DateTime.now().day || selectedDate.month < DateTime.now().month || selectedDate.year < DateTime.now().year)
                return CalendarDayBox(
                  dayNumber: index + 1,
                  month: selectedDate.month,
                  dayType: DayType.good
                );
              else
                return CalendarDayBox(
                  dayNumber: index + 1,
                  month: selectedDate.month,
                  dayType: DayType.unavailable
                );
            },
          )
        ),
        Container(
          height: 64,
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            border: Border.all(
              width: 0.3,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, -4),
                color: Colors.black.withOpacity(0.25)
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
                  });
                },
                icon: Icon(Icons.arrow_back_ios)
              ),
              Spacer(),
              Text(
                '${getMonthName(selectedDate.month)} ${selectedDate.year}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  if (selectedDate.month < DateTime.now().month || selectedDate.year < DateTime.now().year) {
                    setState(() {
                      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
                    });
                  }
                },
                icon: Icon(Icons.arrow_forward_ios),
                disabledColor: Colors.red,
              ),
            ]
          ),
        )
      ],
    );
  }
}
