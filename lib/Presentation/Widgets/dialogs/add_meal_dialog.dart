import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/food_model.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';
import 'package:food_diary/Riverpod/riverpod.dart';

class AddFoodDialog extends ConsumerStatefulWidget {
  AddFoodDialog({
    super.key,
    this.foodID,
    this.isReadOnly = false
  });

  final int? foodID;
  final bool isReadOnly;

  @override
  AddFoodDialogState createState() => AddFoodDialogState();
}

class AddFoodDialogState extends ConsumerState<AddFoodDialog> {
  final _formKey = GlobalKey<FormState>();

  FoodModel? foodModel;
  late TextEditingController _nameController;
  late TextEditingController _compositionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _compositionController = TextEditingController();
    initControllers();
  }

  Future<void> initControllers() async {
    if (widget.foodID != null) {
      foodModel = await ref.read(foodStorageProvider).getFood(widget.foodID!);
      setState(() {
        _nameController.text = foodModel!.name;
        if (foodModel!.composition != null)
          _compositionController.text = foodModel!.composition!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FoodDiaryDialog(
      title: widget.foodID != null ? (foodModel?.name ?? '') : 'Добавить продукт',
      isEdit: widget.foodID != null,
      isReadOnly: widget.isReadOnly,
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название',
              style: TextStyle(color: Color(0xFF818181), fontSize: 14),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              readOnly: widget.isReadOnly,
              decoration: InputDecoration(
                hintText: 'Введите название продукта',
                hintStyle: TextStyle(
                  color: Color(0xFF818181).withOpacity(0.5),
                  fontSize: 12
                ),
              contentPadding: EdgeInsets.all(10)),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Укажите название продукта';
                
                return null;
              },
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
      ),
      onSave: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Продукт создан')));
          Navigator.pop(context);
        }
      },
    );
  }
}
