import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_home.dart';
import 'package:food_diary/Presentation/Widgets/content_box.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_meal_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';
import 'package:food_diary/Presentation/Widgets/utils/get_month_name.dart';

import '../Widgets/tiles/fd_tile.dart';

class ScreenDayInfo extends StatelessWidget {
  const ScreenDayInfo({super.key, required this.day, required this.month});

  final int day;
  final int month;

  String geReplacedMonthLastLetter(int month) {
    String monthName = getMonthName(month);
    if (month == 3 || month == 8)
      return monthName + 'а';
    else
      return monthName.substring(0, monthName.length - 1) + 'я';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$day ${geReplacedMonthLastLetter(month)}')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ScreenHome(isEditMode: true)
            )
          );
        },
        child: Icon(Icons.edit),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FoodDiaryTile(
                    title: 'Сон',
                    subtitle: '8ч',
                    isExpanded: false,
                    trailingIcon: Icon(Icons.nights_stay, color: Colors.black, size: 32),
                  ),
                  SizedBox(width: 10),
                  FoodDiaryTile(
                    title: 'Вода',
                    subtitle: '7 ст.',
                    isExpanded: false,
                    trailingIcon: Icon(Icons.local_drink, color: Colors.black, size: 32),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ContentBox(
                  title: 'Симптомы',
                  content: [
                    ItemCheap(label: 'Боль (1/5)'),
                    ItemCheap(label: 'Боль (1/5)'),
                    ItemCheap(label: 'Боль (1/5)'),
                    ItemCheap(label: 'Боль (1/5)'),
                  ]
              ),
              SizedBox(height: 10),
              ContentBox(
                  title: 'Продукты',
                  content: [
                    ItemCheap(
                      label: 'Творог 5%',
                      editDialog: AddMealDialog(
                        title: 'Творог 5%',
                        isEdit: false,
                        isReadOnly: true,
                      )
                    ),
                  ]
              ),
              SizedBox(height: 10),
              ContentBox(
                  title: 'Препараты',
                  content: [
                    ItemCheap(label: 'Месакол'),
                    ItemCheap(label: 'Бифиформ'),
                  ]
              ),
              SizedBox(height: 10),
              ContentBox(
                title: 'Примечание',
                spaceBetweenTitleAndContent: 7,
                content: [
                  Text(
                    'Отсутствует',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF818181),
                      fontWeight: FontWeight.w700)
                  )
                ]
              )
            ],
          ),
        ),
      )
    );
  }
}
