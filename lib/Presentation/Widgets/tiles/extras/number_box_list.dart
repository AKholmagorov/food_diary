import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/number_box.dart';

class NumberBoxList extends StatefulWidget {
  const NumberBoxList({super.key, this.children, required this.screen});

  final List<NumberBox>? children;
  final Widget screen;

  @override
  State<NumberBoxList> createState() => _NumberBoxListState();
}

class _NumberBoxListState extends State<NumberBoxList> {
  late List<NumberBox> _mealNumberBoxList;

  @override
  void initState() {
    super.initState();
    if (widget.children == null) {
      _mealNumberBoxList = [NumberBox(isFilled: false, itemNumber: 1, destination: widget.screen)];
    } else {
      _mealNumberBoxList = widget.children!;
    }
  }

/*   void AddItem() {
    setState(() {
      if (_mealNumberBoxList.length < 8) {
        _mealNumberBoxList.add(MealNumberBox(isFilled: false, addItem: AddItem, itemNumber: _mealNumberBoxList.length + 1, destination: widget.screen));
      }
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: _mealNumberBoxList,
    );
  }
}

