import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/fd_colorful_slider.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/number_box.dart';
import 'package:food_diary/Presentation/Widgets/utils/get_month_name.dart';
import 'package:food_diary/Presentation/Widgets/utils/symptom_types.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Presentation/Screens/screen_add_medication.dart';
import 'package:food_diary/Presentation/Screens/screen_add_meal.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_note_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_expansion_tile.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';

import '../Widgets/tiles/extras/number_box_list.dart';

class ScreenHome extends ConsumerStatefulWidget {
  const ScreenHome({
    super.key,
    this.isEditMode = false,
    this.selectedDayDate,
  });

  final DateTime? selectedDayDate;
  final bool isEditMode;

  @override
  ScreenHomeState createState() => ScreenHomeState();
}

class ScreenHomeState extends ConsumerState<ScreenHome> {
  @override
  void initState() {
    super.initState();
    ref.read(currentDayProvider).loadDay(widget.selectedDayDate ?? DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    const double _maxSleepHours = 16;
    final double _maxWaterCount = 16;

    DayModel? _selectedDay = ref.watch(currentDayProvider).currentDay;
    int mealCount = ref.watch(currentDayProvider).meals.length;
    int medicationCount = ref.watch(currentDayProvider).medications.length;
    if (_selectedDay == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
      );
    }

    String replaceLastLetter(int month) {
      String monthName = getMonthName(month);
      if (month == 3 || month == 8)
        return monthName + 'а';
      else
        return monthName.substring(0, monthName.length - 1) + 'я';
    }

    return Scaffold(
      appBar: widget.isEditMode
        ? AppBar(
            title: Text(
              '${_selectedDay.date.day} ${replaceLastLetter(_selectedDay.date.month)} (архив)'
            ),
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
                trailing: '${_selectedDay.sleepHours}' + ' ч',
                content: Row(
                  children: [
                    SizedBox(width: 10),
                    IconButton(
                      splashColor: Colors.black.withOpacity(0),
                      hoverColor: Colors.black.withOpacity(0),
                      highlightColor: Colors.black.withOpacity(0),
                      onPressed: () {
                        double value = _selectedDay.sleepHours - 0.5;
                        if (value <= _maxSleepHours && value >= 0)
                          ref.read(currentDayProvider).updateSleepTime(value);
                      },
                      icon: Icon(Icons.remove)
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: _maxSleepHours,
                        value: _selectedDay.sleepHours,
                        onChanged: (value) {
                          setState(() {
                            _selectedDay.sleepHours = (value * 2).round() / 2;
                          });
                        },
                        onChangeEnd: (value) {
                          ref.read(currentDayProvider).updateSleepTime((value * 2).round() / 2);
                        },
                      )
                    ),
                    IconButton(
                      splashColor: Colors.black.withOpacity(0),
                      hoverColor: Colors.black.withOpacity(0),
                      highlightColor: Colors.black.withOpacity(0),
                      onPressed: () {
                        double value = _selectedDay.sleepHours + 0.5;
                        if (value <= _maxSleepHours && value >= 0)
                          ref.read(currentDayProvider).updateSleepTime(value);
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
                trailing: '${_selectedDay.waterCount} ст.',
                content: Row(
                  children: [
                    SizedBox(width: 10),
                    IconButton(
                      splashColor: Colors.black.withOpacity(0),
                      hoverColor: Colors.black.withOpacity(0),
                      highlightColor: Colors.black.withOpacity(0),
                      onPressed: () {
                        int value = _selectedDay.waterCount - 1;
                        if (value <= _maxWaterCount && value >= 0)
                          ref.read(currentDayProvider).updateWaterCount(value);
                      },
                      icon: Icon(Icons.remove)
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: _maxWaterCount,
                        value: _selectedDay.waterCount.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDay.waterCount = value.ceilToDouble().toInt();
                          });
                        },
                        onChangeEnd: (value) {
                          ref.read(currentDayProvider).updateWaterCount(value.ceilToDouble().toInt());
                        },
                      )
                    ),
                    IconButton(
                      splashColor: Colors.black.withOpacity(0),
                      hoverColor: Colors.black.withOpacity(0),
                      highlightColor: Colors.black.withOpacity(0),
                      onPressed: () {
                        int value = _selectedDay.waterCount + 1;
                        if (value <= _maxWaterCount && value >= 0)
                          ref.read(currentDayProvider).updateWaterCount(value);
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
                      NumberBoxList(
                        screen: ScreenAddMeal(),
                        children: List.generate(
                          mealCount+1,
                          (index) {
                            return NumberBox(
                              isFilled: index == mealCount ? false : true, 
                              itemNumber: index+1, 
                              destination: ScreenAddMeal()
                            );
                          }
                        ),
                      ),
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
                      NumberBoxList(
                        screen: ScreenAddMeal(),
                        children: List.generate(
                          medicationCount+1,
                          (index) {
                            return NumberBox(
                              isFilled: index == medicationCount ? false : true, 
                              itemNumber: index+1, 
                              destination: ScreenAddMedication()
                            );
                          }
                        ),
                      ),
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
                    FoodDiaryColorfulSlider(symptomType: SymptomTypes.flatulence),
                    FoodDiaryColorfulSlider(symptomType: SymptomTypes.pain),
                    FoodDiaryColorfulSlider(symptomType: SymptomTypes.slime),
                    FoodDiaryColorfulSlider(symptomType: SymptomTypes.blood),
                    FoodDiaryColorfulSlider(symptomType: SymptomTypes.diarrhea),
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
                    return AddNoteDialog(
                      initString: _selectedDay.noteText,
                      selectedDayDate: _selectedDay.date,
                    );
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
