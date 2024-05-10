import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_note_dialog.dart';
import 'package:food_diary/Presentation/Widgets/meal_number_box_list.dart';

class FoodDiaryExpansionPanel extends StatefulWidget {
  const FoodDiaryExpansionPanel({super.key});

  @override
  State<FoodDiaryExpansionPanel> createState() => _FoodDiaryExpansionPanelState();
}

class _FoodDiaryExpansionPanelState extends State<FoodDiaryExpansionPanel> {
  double _currentSliderValue = 0;
  double _waterCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          textColor: Colors.black,
          backgroundColor: Color(0xFFF7F7F7F7),
          collapsedBackgroundColor: Color(0xFFF7F7F7F7),
          leading: Icon(Icons.nights_stay, color: Colors.black),
          trailing: Text('$_currentSliderValue' + 'ч'),
          title: Text('Сон'),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text('Продолжительность сна'),
            ),
            Row(
              children: [
                SizedBox(width: 10),
                IconButton(
                    splashColor: Colors.black.withOpacity(0),
                    hoverColor: Colors.black.withOpacity(0),
                    highlightColor: Colors.black.withOpacity(0),
                    onPressed: () {
                      setState(() => _currentSliderValue -= 0.5);
                    },
                    icon: Icon(Icons.remove)
                ),
                Expanded(
                    child: Slider(
                        min: 0,
                        max: 16,
                        value: _currentSliderValue,
                        divisions: 32,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black.withOpacity(0.5),
                        onChanged: (double value) {
                          setState(() => _currentSliderValue = value);
                        }
                    )
                ),
                IconButton(
                    splashColor: Colors.black.withOpacity(0),
                    hoverColor: Colors.black.withOpacity(0),
                    highlightColor: Colors.black.withOpacity(0),
                    onPressed: () {
                      setState(() => _currentSliderValue += 0.5);
                    },
                    icon: Icon(Icons.add)
                ),
                SizedBox(width: 10)
              ],
            )
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        SizedBox(height: 10),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          textColor: Colors.black,
          backgroundColor: Color(0xFFF7F7F7F7),
          collapsedBackgroundColor: Color(0xFFF7F7F7F7),
          leading: Icon(Icons.water_drop, color: Colors.black),
          trailing: Text(_waterCount.toStringAsFixed(0) + ' ст.'),
          title: Text('Вода'),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text('Кол-во стаканов'),
            ),
            Row(
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
                        divisions: 16,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black.withOpacity(0.5),
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
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        SizedBox(height: 10),
        ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          textColor: Colors.black,
          backgroundColor: Color(0xFFF7F7F7F7),
          collapsedBackgroundColor: Color(0xFFF7F7F7F7),
          leading: Icon(Icons.apple, color: Colors.black),
          trailing: Text('0 приемов'),
          title: Text('Пища'),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text('Кол-во приемов пищи'),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: [
                  MealNumberBoxList(),
                ]
              )
            ),
            SizedBox(height: 10)
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        SizedBox(height: 10),
        ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          textColor: Colors.black,
          backgroundColor: Color(0xFFF7F7F7F7),
          collapsedBackgroundColor: Color(0xFFF7F7F7F7),
          leading: Icon(Icons.medication, color: Colors.black),
          title: Text('Препараты'),
          trailing: SizedBox(),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text('Приемы'),
            ),
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.start,
                    children: [
                      MealNumberBoxList(),
                    ]
                )
            ),
            SizedBox(height: 10)
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        SizedBox(height: 10),
        ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          textColor: Colors.black,
          backgroundColor: Color(0xFFF7F7F7F7),
          collapsedBackgroundColor: Color(0xFFF7F7F7F7),
          leading: Icon(Icons.mood_bad_outlined, color: Colors.black),
          trailing: SizedBox(),
          title: Text('Симптомы'),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text('Укажите интенсивность симптомов'),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text('Метеоризм'),
                ),
                Expanded(
                    child: Slider(
                        min: 0,
                        max: 5,
                        value: _currentSliderValue,
                        divisions: 5,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black.withOpacity(0.5),
                        onChanged: (double value) {
                          setState(() => _currentSliderValue = value);
                        }
                    )
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text('Боль'),
                ),
                Expanded(
                  child: Slider(
                    min: 0,
                    max: 5,
                    value: _currentSliderValue,
                    divisions: 5,
                    activeColor: Colors.black,
                    inactiveColor: Colors.black.withOpacity(0.5),
                    onChanged: (double value) {
                      setState(() => _currentSliderValue = value);
                    }
                  )
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text('Слизь'),
                ),
                Expanded(
                    child: Slider(
                        min: 0,
                        max: 5,
                        value: _currentSliderValue,
                        divisions: 5,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black.withOpacity(0.5),
                        onChanged: (double value) {
                          setState(() => _currentSliderValue = value);
                        }
                    )
                ),
              ],
            ),
          ],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        SizedBox(height: 10),
        ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          textColor: Colors.black,
          collapsedBackgroundColor: Color(0xFFF7F7F7F7),
          leading: Icon(Icons.edit_calendar, color: Colors.black),
          title: GestureDetector(
            onTap: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AddNoteDialog();
              }
            ),
            child: Text('Примечание')
          ),
          trailing: SizedBox(),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
      ],
    );
  }
}
