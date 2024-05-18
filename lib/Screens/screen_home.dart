import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/fd_colorful_slider.dart';
import 'package:food_diary/Presentation/Widgets/utils/symptom_types.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Screens/screen_add_drug.dart';
import 'package:food_diary/Screens/screen_add_meal.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_note_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_expansion_tile.dart';
import 'package:food_diary/Presentation/Widgets/tiles/fd_tile.dart';

import '../Presentation/Widgets/tiles/extras/number_box_list.dart';

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
    if (_selectedDay == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
      );
    }

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
