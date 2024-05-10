import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FoodDiaryDialog(
      title: 'Примечание',
      isEdit: false,
      content: TextField(
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
    );
  }
}
