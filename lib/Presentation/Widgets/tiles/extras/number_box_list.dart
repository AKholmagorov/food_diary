import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/number_box.dart';
import 'package:food_diary/Riverpod/riverpod.dart';

class NumberBoxList extends ConsumerStatefulWidget {
  const NumberBoxList({super.key, this.children, required this.screen});

  final List<NumberBox>? children;
  final Widget screen;

  @override
  NumberBoxListState createState() => NumberBoxListState();
}

class NumberBoxListState extends ConsumerState<NumberBoxList> {
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

  @override
  Widget build(BuildContext context) {
    print('rebuild_number_box_list');
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: _mealNumberBoxList,
    );
  }
}

