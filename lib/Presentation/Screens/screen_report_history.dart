import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_ai_report_page.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';

class ScreenReportHistory extends StatelessWidget {
  const ScreenReportHistory.ScreenReportHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          FoodDiaryTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ScreenAIReportPage()
                )
              );
            },
            title: 'Отчет 23-03-2024',
            subtitle: 'Модель: GPT-4',
            trailingIcon: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/gpt-4.jpg'),
            ),
          ),
          SizedBox(height: 5),
          FoodDiaryTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ScreenAIReportPage()
                )
              );
            },
            title: 'Отчет 23-03-2024',
            subtitle: 'Модель: GPT-4',
            trailingIcon: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/gpt-4.jpg'),
            ),
          ),
        ],
      )
    );
  }
}
