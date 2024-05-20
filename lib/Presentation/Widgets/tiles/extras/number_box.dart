import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Screens/screen_add_meal.dart';

import '../../../../Screens/screen_add_drug.dart';

class NumberBox extends ConsumerStatefulWidget {
  const NumberBox(
      {super.key,
      required this.isFilled,
      // required this.addItem,
      required this.itemNumber,
      required this.destination});

  final bool isFilled;
  // final Function addItem;
  final int itemNumber;
  final Widget destination;

  @override
  NumberBoxState createState() => NumberBoxState();
}

class NumberBoxState extends ConsumerState<NumberBox> {
  late bool _isFilled;

  @override
  void initState() {
    super.initState();
    _isFilled = widget.isFilled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!_isFilled) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => widget.destination));
          } else {
            if (widget.destination is ScreenAddMeal) {
              MealModel meal = ref.read(currentDayProvider).meals[widget.itemNumber-1];
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenAddMeal(meal: meal)));
            }
            else
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenAddDrug(isEditMode: true)));
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          color: _isFilled ? Color(0xFF89FF76) : Color(0xFFD9D9D9),
        ),
        child: _isFilled ? Text('${widget.itemNumber}') : Icon(Icons.add),
      ),
    );
  }
}