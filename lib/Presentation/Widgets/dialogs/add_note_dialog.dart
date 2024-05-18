import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';
import 'package:food_diary/Riverpod/riverpod.dart';

class AddNoteDialog extends ConsumerStatefulWidget {
  const AddNoteDialog({super.key, this.initString, required this.selectedDayDate});

  final String? initString;
  final DateTime selectedDayDate;

  @override
  AddNoteDialogState createState() => AddNoteDialogState();
}

class AddNoteDialogState extends ConsumerState<AddNoteDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initString != null)
      _controller.text = widget.initString!;
  }

  @override
  Widget build(BuildContext context) {
    return FoodDiaryDialog(
      title: 'Примечание',
      isEdit: false,
      content: TextField(
        controller: _controller,
        maxLines: 10,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Опишите особенности текущего дня',
          hintStyle: TextStyle(
            fontSize: 13
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none
        ),
      ), 
      onSave: () {
        ref.read(currentDayProvider).updateNoteText(_controller.text);
      },
    );
  }
}
