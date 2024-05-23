import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/drug_model.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/food_diary_dialog.dart';
import 'package:food_diary/Riverpod/riverpod.dart';

class AddMedicationDialog extends ConsumerStatefulWidget {
  AddMedicationDialog({
    super.key,
    this.drugID,
    this.isReadOnly = false,
  });

  final int? drugID;
  final bool isReadOnly;

  @override
  AddFoodDialogState createState() => AddFoodDialogState();
}

class AddFoodDialogState extends ConsumerState<AddMedicationDialog> {
  final _formKey = GlobalKey<FormState>();

  DrugModel? drugModel;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    initControllers();
  }

  Future<void> initControllers() async {
    if (widget.drugID != null) {
      drugModel = await ref.read(drugStorageProvider).getDrug(widget.drugID!);
      setState(() => _nameController.text = drugModel!.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FoodDiaryDialog(
      title: widget.drugID != null ? (drugModel?.name ?? '') : 'Добавить препарат',
      isEdit: widget.drugID != null,
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
                hintText: 'Введите название препарата',
                hintStyle: TextStyle(
                  color: Color(0xFF818181).withOpacity(0.5),
                  fontSize: 12
                ),
              contentPadding: EdgeInsets.all(10)),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Укажите название препарата';
                
                return null;
              },
            ),
          ],
        ),
      ),
      onSave: () {
        if (_formKey.currentState!.validate()) {
          if (drugModel == null) {
            ref.read(drugStorageProvider).addDrug(_nameController.text);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Препарат создан')));
            Navigator.pop(context);
          }
          else {
            ref.read(drugStorageProvider).editDrug(drugModel!.id, _nameController.text);
            ref.read(currentDayProvider).loadMedications(); // update drug names in medications
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Изменения сохранены')));
            Navigator.pop(context);
          }
        }
      },
      onDelete: () {
        ref.read(drugStorageProvider).removeDrug(drugModel!.id);
        ref.read(currentDayProvider).loadMedications(); // update drug names in medications
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Препарат удален')));
        Navigator.pop(context);
      },
    );
  }
}
