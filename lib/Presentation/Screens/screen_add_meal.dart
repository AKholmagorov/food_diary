import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/add_screen.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_meal_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';

class ScreenAddMeal extends AddScreen {
  const ScreenAddMeal({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  State<ScreenAddMeal> createState() => _ScreenAddMealState();
}

class _ScreenAddMealState extends State<ScreenAddMeal> {
  List<ItemCheap> _addedItems = [];
  List<ItemCheap> _recentItems = [];

  void AddToAddedList(ItemCheap item) {
    setState(() {
      _addedItems.add(new ItemCheap(label: item.label, onTap: AddToRecentList, editDialog: AddMealDialog(title: 'Творог 5%')));
      _recentItems.remove(item);
    });
  }

  void AddToRecentList(ItemCheap item) {
    setState(() {
      _recentItems.add(new ItemCheap(label: item.label, onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')));
      _addedItems.remove(item);
    });
  }

  void initState() {
    super.initState();
    _addedItems = [
      ItemCheap(label: 'Бананы', onTap: AddToRecentList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Зефир из печеных яблок', onTap: AddToRecentList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Пюре из картофеля', onTap: AddToRecentList, editDialog: AddMealDialog(title: 'Творог 5%')),
    ];
    _recentItems = [
      ItemCheap(label: 'Творог 5%', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Чернослив', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Хлебцы', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Творог 10%', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Овсяное печенье', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Галеты', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Творог 5%', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Чернослив', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Хлебцы', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Творог 10%', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Овсяное печенье', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
      ItemCheap(label: 'Галеты', onTap: AddToAddedList, editDialog: AddMealDialog(title: 'Творог 5%')),
    ];
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
                    title: 'Добавить продукт', isEdit: false);
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