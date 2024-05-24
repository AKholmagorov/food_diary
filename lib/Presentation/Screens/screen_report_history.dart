import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/report_model.dart';
import 'package:food_diary/Presentation/Screens/screen_ai_report_page.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:intl/intl.dart';

class ScreenReportHistory extends ConsumerStatefulWidget {
  const ScreenReportHistory({super.key});

  @override
  ScreenReportHistoryState createState() => ScreenReportHistoryState();
}

class ScreenReportHistoryState extends ConsumerState<ScreenReportHistory> {
  @override
  Widget build(BuildContext context) {
    List<ReportModel> reportList = ref.watch(reportProvider).reportList;

    return Scaffold(
      body: reportList.isEmpty
        ? Center(child: Text('Список отчетов пуст'))
        : ListView.separated(
            itemCount: reportList.length,
            itemBuilder: (_, index) {
              DateFormat formatter = DateFormat('dd-MM-yyyy');

              return FoodDiaryTile(
                title: 'Отчет ${formatter.format(reportList[index].date)}',
                subtitle: 'Модель: ${reportList[index].modelName}',
                trailingIcon: CircleAvatar(
                  radius: 24,
                  backgroundImage: reportList[index].modelImage.image,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ScreenAIReportPage(report: reportList[index])
                    )
                  );
                },
              );
            }, 
            separatorBuilder: (_, __) => SizedBox(height: 10)
          )
        );
  }
}