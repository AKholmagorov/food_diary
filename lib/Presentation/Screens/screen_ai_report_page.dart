import 'package:flutter/material.dart';
import 'package:food_diary/Models/report_model.dart';
import 'package:food_diary/Presentation/Widgets/content_box.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';
import 'package:intl/intl.dart';

class ScreenAIReportPage extends StatelessWidget {
  const ScreenAIReportPage({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(title: Text('Просмотр отчета')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FoodDiaryTile(
                    isExpanded: false,
                    title: 'Дата создания',
                    subtitle: '${formatter.format(report.date)}',
                  ),
                  SizedBox(width: 10),
                  FoodDiaryTile(
                    isExpanded: false,
                    title: 'Период',
                    subtitle: '${report.period} дней',
                  ),
                ],
              ),
              SizedBox(height: 10),
              FoodDiaryTile(
                title: 'Модель',
                subtitle: '${report.modelName}',
                isExpanded: true,
                trailingIcon: CircleAvatar(
                  radius: 20,
                  backgroundImage: report.modelImage.image,
                ),
              ),
              SizedBox(height: 10),
              ContentBox(
                title: 'Рекомендация',
                content: [
                  Text('${report.recommendationText}'),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
