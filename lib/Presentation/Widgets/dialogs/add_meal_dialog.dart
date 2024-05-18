import 'package:flutter/material.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';

class AddMealDialog extends StatefulWidget {
  AddMealDialog({
    super.key,
    this.meal,
    this.isReadOnly = false
  });

  final MealModel? meal;
  final bool isReadOnly;

  @override
  State<AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<AddMealDialog> {
  late TextEditingController _nameController;
  late TextEditingController _compositionController;
  
  @override
  void initState() {
    super.initState();

    if (widget.meal != null) {
      _nameController.text = widget.meal!.name;
      _compositionController.text = widget.meal!.composition;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return FoodDiaryDialog(
      title: widget.meal != null ? widget.meal!.name : 'Добавить продукт',
      isEdit: widget.meal != null,
      isReadOnly: widget.isReadOnly,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Название',
            style: TextStyle(color: Color(0xFF818181), fontSize: 14),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _nameController,
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
              hintText: 'Введите название продукта',
              hintStyle: TextStyle(
                color: Color(0xFF818181).withOpacity(0.5),
                fontSize: 12
              ),
            contentPadding: EdgeInsets.all(10))
          ),
          SizedBox(height: 20),
          Text(
            ' Состав',
            style: TextStyle(fontSize: 14, color: Color(0xFF818181)),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _compositionController,
            maxLines: 4,
            readOnly: widget.isReadOnly,
            decoration: InputDecoration(
              hintText: 'Состав продукта (необязательно)',
              hintStyle: TextStyle(
                color: Color(0xFF818181).withOpacity(0.5),
                fontSize: 12
              ),
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.all(10)
            )
          ),
        ],
      ),
    );
  }
}
