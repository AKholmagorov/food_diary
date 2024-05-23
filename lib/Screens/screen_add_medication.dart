import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/drug_model.dart';
import 'package:food_diary/Models/medication_model.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_medication_dialog.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';
import 'package:collection/collection.dart';

class ScreenAddMedication extends ConsumerStatefulWidget {
  const ScreenAddMedication({super.key, this.medication});

  final MedicationModel? medication;

  @override
  ScreenAddMealState createState() => ScreenAddMealState();
}

class ScreenAddMealState extends ConsumerState<ScreenAddMedication> {
  List<ItemCheap> _addedItems = [];
  List<ItemCheap> _recentItems = [];
  late List<DrugModel> _drugList;

  void AddToAddedList(int drugID, String label) {
    setState(() {
      _addedItems.add(
        ItemCheap(
          itemId: drugID,
          label: label,
          onTap: AddToRecentList,
          editDialog: AddMedicationDialog(drugID: drugID),
          editModeEnabled: false,
        )
      );
      _recentItems.removeWhere((e) => e.itemId == drugID);
    });
  }

  void AddToRecentList(int drugID, String label) {
    setState(() {
      _recentItems.add(
        ItemCheap(
          itemId: drugID,
          label: label,
          onTap: AddToAddedList,
          editDialog: AddMedicationDialog(drugID: drugID)
        )
      );
      _addedItems.removeWhere((e) => e.itemId == drugID);
    });
  }

  void initRecentList(List<DrugModel> data) {
    _recentItems.clear();

    for (var value in data) {
      if (_addedItems.firstWhereOrNull((e) => e.itemId == value.id) == null) {
        _recentItems.add(
          ItemCheap(
            itemId: value.id,
            label: value.name,
            onTap: AddToAddedList,
            editDialog: AddMedicationDialog(drugID: value.id)
          )
        );
      }
    }
  }

  void initAddedList(List<DrugModel> data) {
    for (var value in data) {
      _addedItems.add(
        ItemCheap(
          itemId: value.id,
          label: value.name,
          onTap: AddToRecentList,
          editDialog: AddMedicationDialog(drugID: value.id),
          editModeEnabled: false,
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.medication != null)
      initAddedList(widget.medication!.drugs);
  }

  @override
  Widget build(BuildContext context) {
    _drugList = ref.watch(drugStorageProvider).drugList;
    initRecentList(_drugList);

    return Scaffold(
      appBar: AppBar(
        title: widget.medication != null
          ? Text('Редактировать')
          : Text('Добавить прием'),
        actions: [
          if (widget.medication != null) ...[
            IconButton(
              onPressed: () {
                ref.read(currentDayProvider).removeMedication(widget.medication!.id);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Запись удалена')));
              },
              icon: const Icon(Icons.delete_outline_rounded)
            ),
          ],
          IconButton(
            onPressed: () =>
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AddMedicationDialog();
                }
              ),
            icon: Icon(Icons.add, color: Colors.white)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_addedItems.isEmpty) {
            List<DrugModel> addedDrugsList = [];

            for(var item in _addedItems) {
              addedDrugsList.add(await ref.read(drugStorageProvider).getDrug(item.itemId));
            }
            
            if (widget.medication != null)
              ref.read(currentDayProvider).editMedication(addedDrugsList, widget.medication!.id);
            else
              ref.read(currentDayProvider).addMedication(addedDrugsList);

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Сохранено')));
          }
        },
        child: const Icon(Icons.done)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7F7),
                  border: Border.all(color: Colors.black, width: 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4
                    )
                  ]
                ),
                child: _addedItems.isEmpty
                  ? Text(
                      'Добавьте препараты на текущий прием',
                      style: TextStyle(
                        color: Color(0xFF818181).withOpacity(0.5)
                      ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _addedItems
                      ),
                    )
              ),
              SizedBox(height: 20),
              Text(
                'Недавнее',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(height: 12),
              if (_drugList.isEmpty || _recentItems.isEmpty) ...[
                Text(
                  'Список пуст',
                  style: TextStyle(
                    color: Color(0xFF818181)
                  ),
                ),
              ] 
              else ...[
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _recentItems
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}