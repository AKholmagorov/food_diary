import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({super.key, this.initString});

  final String? initString;

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
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
    );
  }
}
