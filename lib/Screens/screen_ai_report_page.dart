import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/content_box.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';

class ScreenAIReportPage extends StatelessWidget {
  const ScreenAIReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Просмотр отчета')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FoodDiaryTile(
                title: 'Модель',
                subtitle: 'GPT-4',
                isExpanded: false,
                trailingIcon: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/gpt-4.jpg'),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  FoodDiaryTile(
                    isExpanded: false,
                    title: 'Дата создания',
                    subtitle: '23-03-2024',
                  ),
                  SizedBox(width: 10),
                  FoodDiaryTile(
                    isExpanded: false,
                    title: 'Период',
                    subtitle: '7 дней',
                  ),
                ],
              ),
              SizedBox(height: 10),
              ContentBox(
                title: 'Рекомендация',
                content: [
                  Text(
                    'Исходя из предоставленных данных, у вас наблюдается регулярный прием пищи, который включает в себя овсянку, гречку, чай, макароны, творожную запеканку и суп с курицей. Однако, стоит обратить внимание на то, что в вашем рационе присутствует большое количество углеводов и малое количество белков и жиров. Это может привести к проблемам с пищеварением, таким как вздутие живота.',
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
