import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';

class AddDrugDialog extends StatelessWidget {
  const AddDrugDialog({
    super.key,
    required this.title,
    this.isEdit = true,
    this.isReadOnly = false
  });

  final String title;
  final bool isEdit;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return FoodDiaryDialog(
      title: title,
      isEdit: isEdit,
      isReadOnly: isReadOnly,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Название',
            style: TextStyle(color: Color(0xFF818181), fontSize: 14),
          ),
          SizedBox(height: 8),
          TextField(
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: 'Введите название препарата',
              hintStyle: TextStyle(
                  color: Color(0xFF818181).withOpacity(0.5), fontSize: 12),
              contentPadding: EdgeInsets.all(10)
            )
          )
        ],
      ), 
      onSave: () {  },
    );
  }
}
