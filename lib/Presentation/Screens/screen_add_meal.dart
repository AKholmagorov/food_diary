import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/food_model.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_meal_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';
import 'package:collection/collection.dart';

class ScreenAddMeal extends ConsumerStatefulWidget {
  const ScreenAddMeal({super.key, this.meal});

  final MealModel? meal;

  @override
  ScreenAddMealState createState() => ScreenAddMealState();
}

class ScreenAddMealState extends ConsumerState<ScreenAddMeal> {
  List<ItemCheap> _addedItems = [];
  List<ItemCheap> _recentItems = [];
  late List<FoodModel> _foodList;

  void AddToAddedList(int foodID, String label) {
    setState(() {
      _addedItems.add(
        ItemCheap(
          itemId: foodID,
          label: label,
          onTap: AddToRecentList,
          editDialog: AddFoodDialog(foodID: foodID),
          editModeEnabled: false,
        )
      );
      _recentItems.removeWhere((e) => e.itemId == foodID);
    });
  }

  void AddToRecentList(int foodID, String label) {
    setState(() {
      _recentItems.add(
        ItemCheap(
          itemId: foodID,
          label: label,
          onTap: AddToAddedList,
          editDialog: AddFoodDialog(foodID: foodID)
        )
      );
      _addedItems.removeWhere((e) => e.itemId == foodID);
    });
  }

  void initRecentList(List<FoodModel> data) {
    _recentItems.clear();

    for (var value in data) {
      if (_addedItems.firstWhereOrNull((e) => e.itemId == value.id) == null) {
        _recentItems.add(
          ItemCheap(
            itemId: value.id,
            label: value.name,
            onTap: AddToAddedList,
            editDialog: AddFoodDialog(foodID: value.id)
          )
        );
      }
    }
  }

  void initAddedList(List<FoodModel> data) {
    for (var value in data) {
      _addedItems.add(
        ItemCheap(
          itemId: value.id,
          label: value.name,
          onTap: AddToRecentList,
          editDialog: AddFoodDialog(foodID: value.id),
          editModeEnabled: false,
        )
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.meal != null)
      initAddedList(widget.meal!.food);
  }

  @override
  Widget build(BuildContext context) {
    _foodList = ref.watch(foodStorageProvider).foodList;
    initRecentList(_foodList);

    return Scaffold(
      appBar: AppBar(
        title: widget.meal != null
          ? Text('Редактировать')
          : Text('Добавить прием пищи'),
        actions: [
          if (widget.meal != null) ...[
            IconButton(
              onPressed: () {
                ref.read(currentDayProvider).removeMeal(widget.meal!.id);
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
                  return AddFoodDialog();
                }
              ),
            icon: Icon(Icons.add, color: Colors.white)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_addedItems.isEmpty) {
            List<FoodModel> addedFoodList = [];

            for(var item in _addedItems) {
              addedFoodList.add(await ref.read(foodStorageProvider).getFood(item.itemId));
            }
            
            if (widget.meal != null)
              ref.read(currentDayProvider).editMeal(addedFoodList, widget.meal!.id);
            else
              ref.read(currentDayProvider).addMeal(addedFoodList);

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
                      'Добавьте продукты на текущий прием',
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
              if (_foodList.isEmpty || _recentItems.isEmpty) ...[
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