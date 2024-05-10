import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_add_meal.dart';
import 'package:food_diary/Presentation/Screens/add_screen.dart';

import '../Screens/screen_add_drug.dart';

class MealNumberBox extends StatefulWidget {
  const MealNumberBox(
      {super.key,
      required this.isFilled,
      required this.addItem,
      required this.itemNumber,
      required this.destination});

  final bool isFilled;
  final Function addItem;
  final int itemNumber;
  final AddScreen destination;

  @override
  State<MealNumberBox> createState() => _MealNumberBoxState();
}

class _MealNumberBoxState extends State<MealNumberBox> {
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
            _isFilled = true;
            Navigator.push(context, MaterialPageRoute(builder: (context) => widget.destination));
            widget.addItem();
          } else {
            // TODO: refactor
            if (widget.destination is ScreenAddMeal)
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenAddMeal(isEditMode: true)));
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