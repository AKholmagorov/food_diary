import 'package:flutter/material.dart';
import 'package:food_diary/FoodDiaryDB.dart';
import 'package:food_diary/Models/meal_model.dart';
import 'package:food_diary/Screens/add_screen.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_meal_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';
import 'package:sqlite3/sqlite3.dart';

class ScreenAddMeal extends AddScreen {
  const ScreenAddMeal({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  State<ScreenAddMeal> createState() => _ScreenAddMealState();
}

class _ScreenAddMealState extends State<ScreenAddMeal> {
  FoodDiaryDB db = FoodDiaryDB(db: sqlite3.open('food_diary_db'));

  List<ItemCheap> _addedItems = [];
  List<ItemCheap> _recentItems = [];

  void AddToAddedList(MealModel value) {
    setState(() {
      _addedItems.add(new ItemCheap(label: value.name, onTap: AddToRecentList, editDialog: AddMealDialog(meal: value)));
      _recentItems.remove(value);
    });
  }

  void AddToRecentList(MealModel value) {
    setState(() {
      _recentItems.add(new ItemCheap(label: value.name, onTap: AddToAddedList, editDialog: AddMealDialog(meal: value)));
      _addedItems.remove(value);
    });
  }

  void initState() {
    super.initState();
    _addedItems = [];
    // _recentItems = db.getAllMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditMode
            ? Text('Редактировать')
            : Text('Добавить прием пищи'),
        actions: [
          IconButton(
            onPressed: () =>
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AddMealDialog(
                    // TODO: add meal
                  );
                }
              ),
            icon: Icon(Icons.add, color: Colors.white)
          ),
        ],
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
              _recentItems.isEmpty
                  ? Text(
                      'Список пуст',
                      style: TextStyle(
                        color: Color(0xFF818181)
                      ),
                    )
                  : Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _recentItems
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isEditMode
          ? DoubleFBA()
          : FloatingActionButton(
          heroTag: null,
          onPressed: () {},
          child: const Icon(Icons.done)
      ),
    );
  }
}

class DoubleFBA extends StatelessWidget {
  const DoubleFBA({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: 0,
          child: FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              child: const Icon(Icons.done,)),
        ),
        Positioned(
          bottom: 65,
          child: FloatingActionButton(
              heroTag: null,
              onPressed: () {},
              backgroundColor: Color(0xFFE63946),
              child: const Icon(Icons.delete_outline_rounded)),
        ),
      ],
    );
  }
}