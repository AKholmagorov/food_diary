import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_add_drug.dart';
import 'package:food_diary/Presentation/Screens/screen_add_meal.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_note_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/fd_colorful_slider.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_expansion_tile.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';

import '../Widgets/tiles/extras/number_box_list.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  double _currentSleepValue = 0;
  double _waterCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditMode
          ? AppBar(
              title: Text('Редактировать'),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.done))
              ],
            )
          : null,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FoodDiaryExpansionTile(
                  icon: Icons.nights_stay,
                  title: 'Сон',
                  description: 'Продолжительность сна',
                  trailing: '${_currentSleepValue.toStringAsFixed(0)}' + 'ч',
                  content: Row(
                    children: [
                      SizedBox(width: 10),
                      IconButton(
                          splashColor: Colors.black.withOpacity(0),
                          hoverColor: Colors.black.withOpacity(0),
                          highlightColor: Colors.black.withOpacity(0),
                          onPressed: () {
                            setState(() => _currentSleepValue -= 1);
                          },
                          icon: Icon(Icons.remove)
                      ),
                      Expanded(
                          child: Slider(
                              min: 0,
                              max: 16,
                              value: _currentSleepValue,
                              onChanged: (double value) {
                                setState(() => _currentSleepValue = value);
                              }
                          )
                      ),
                      IconButton(
                          splashColor: Colors.black.withOpacity(0),
                          hoverColor: Colors.black.withOpacity(0),
                          highlightColor: Colors.black.withOpacity(0),
                          onPressed: () {
                            setState(() => _currentSleepValue += 1);
                          },
                          icon: Icon(Icons.add)
                      ),
                      SizedBox(width: 10)
                    ],
                  )
              ),
              SizedBox(height: 10),
              FoodDiaryExpansionTile(
                  icon: Icons.local_drink,
                  title: 'Вода',
                  description: 'Кол-во жидкости',
                  trailing: '${_waterCount.toStringAsFixed(0)} ст.',
                  content: Row(
                    children: [
                      SizedBox(width: 10),
                      IconButton(
                          splashColor: Colors.black.withOpacity(0),
                          hoverColor: Colors.black.withOpacity(0),
                          highlightColor: Colors.black.withOpacity(0),
                          onPressed: () {
                            setState(() => _waterCount -= 1);
                          },
                          icon: Icon(Icons.remove)
                      ),
                      Expanded(
                          child: Slider(
                              min: 0,
                              max: 16,
                              value: _waterCount,
                              onChanged: (double value) {
                                setState(() => _waterCount = value);
                              }
                          )
                      ),
                      IconButton(
                          splashColor: Colors.black.withOpacity(0),
                          hoverColor: Colors.black.withOpacity(0),
                          highlightColor: Colors.black.withOpacity(0),
                          onPressed: () {
                            setState(() => _waterCount += 1);
                          },
                          icon: Icon(Icons.add)
                      ),
                      SizedBox(width: 10)
                    ],
                  )
              ),
              SizedBox(height: 10),
              FoodDiaryExpansionTile(
                icon: Icons.restaurant_menu,
                title: 'Пища',
                description: 'Приемы пищи',
                content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.start,
                        children: [
                          NumberBoxList(screen: ScreenAddMeal()),
                        ]
                    )
                ),
              ),
              SizedBox(height: 10),
              FoodDiaryExpansionTile(
                icon: Icons.local_pharmacy,
                title: 'Препараты',
                description: 'Приемы препаратов',
                content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.start,
                        children: [
                          NumberBoxList(screen: ScreenAddDrug()),
                        ]
                    )
                ),
              ),
              SizedBox(height: 10),
              FoodDiaryExpansionTile(
                  icon: Icons.mood_bad,
                  title: 'Симптомы',
                  description: 'Укажите интенсивность симптомов',
                  content: Column(
                    children: [
                      FoodDiaryColorfulSlider(title: 'Метеоризм'),
                      FoodDiaryColorfulSlider(title: 'Слизь'),
                      FoodDiaryColorfulSlider(title: 'Боль'),
                      FoodDiaryColorfulSlider(title: 'Кровь'),
                      FoodDiaryColorfulSlider(title: 'Диарея'),
                    ],
                  )
              ),
              SizedBox(height: 10),
              FoodDiaryTile(
                leadingIcon: Icon(Icons.edit_calendar, color: Colors.black, size: 32),
                title: 'Примечание',
                onTap: () => showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AddNoteDialog();
                    }
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
