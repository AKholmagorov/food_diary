import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Presentation/Screens/screen_home.dart';
import 'package:food_diary/Presentation/Widgets/content_box.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_meal_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';
import 'package:food_diary/Presentation/Widgets/utils/get_month_name.dart';

import '../Widgets/tiles/fd_tile.dart';

class ScreenDayInfo extends ConsumerWidget {
  const ScreenDayInfo({super.key});

  String replaceLastLetter(int month) {
    String monthName = getMonthName(month);
    if (month == 3 || month == 8)
      return monthName + 'а';
    else
      return monthName.substring(0, monthName.length - 1) + 'я';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DayModel? currentDay = ref.watch(currentDayProvider).currentDay;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${currentDay!.date.day} ${replaceLastLetter(currentDay.date.month)}'
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ScreenHome(
                  isEditMode: true,
                  selectedDayDate: currentDay.date,
                );
              }
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
                    subtitle: '${currentDay.sleepHours}ч',
                    isExpanded: false,
                    trailingIcon: Icon(Icons.nights_stay, color: Colors.black, size: 32),
                  ),
                  SizedBox(width: 10),
                  FoodDiaryTile(
                    title: 'Вода',
                    subtitle: '${currentDay.waterCount} ст.',
                    isExpanded: false,
                    trailingIcon: Icon(Icons.local_drink, color: Colors.black, size: 32),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ContentBox(
                  title: 'Симптомы',
                  content: [
                   /*  ItemCheap(label: 'Боль (1/5)'),
                    ItemCheap(label: 'Боль (1/5)'),
                    ItemCheap(label: 'Боль (1/5)'),
                    ItemCheap(label: 'Боль (1/5)'), */
                  ]
              ),
              SizedBox(height: 10),
              ContentBox(
                  title: 'Продукты',
                  content: [
                    /* ItemCheap(
                      label: 'Творог 5%',
                      editDialog: AddFoodDialog(
                        // TODO: add meal
                        isReadOnly: true,
                      )
                    ), */
                  ]
              ),
              SizedBox(height: 10),
              ContentBox(
                  title: 'Препараты',
                  content: [
                    /* ItemCheap(label: 'Месакол'),
                    ItemCheap(label: 'Бифиформ'), */
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
