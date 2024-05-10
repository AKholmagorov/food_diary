import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/item_cheap.dart';

class AddMeal extends StatefulWidget {
  const AddMeal({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  State<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  List<ItemCheap> _addedItems = [];
  List<ItemCheap> _recentItems = [];

  void AddToAddedList(ItemCheap item) {
    setState(() {
      _addedItems.add(new ItemCheap(label: item.label, onTap: AddToRecentList));
      _recentItems.remove(item);
    });
  }
  void AddToRecentList(ItemCheap item) {
    setState(() {
      _recentItems.add(new ItemCheap(label: item.label, onTap: AddToAddedList));
      _addedItems.remove(item);
    });
  }

  void initState() {
    super.initState();
    _addedItems = [
      ItemCheap(label: 'Бананы', onTap: AddToRecentList),
      ItemCheap(label: 'Зефир из печеных яблок', onTap: AddToRecentList),
      ItemCheap(label: 'Пюре из картофеля', onTap: AddToRecentList),
    ];
    _recentItems = [
      ItemCheap(label: 'Творог 5%', onTap: AddToAddedList),
      ItemCheap(label: 'Чернослив', onTap: AddToAddedList),
      ItemCheap(label: 'Хлебцы', onTap: AddToAddedList),
      ItemCheap(label: 'Творог 10%', onTap: AddToAddedList),
      ItemCheap(label: 'Овсяное печенье', onTap: AddToAddedList),
      ItemCheap(label: 'Галеты', onTap: AddToAddedList),
      ItemCheap(label: 'Творог 5%', onTap: AddToAddedList),
      ItemCheap(label: 'Чернослив', onTap: AddToAddedList),
      ItemCheap(label: 'Хлебцы', onTap: AddToAddedList),
      ItemCheap(label: 'Творог 10%', onTap: AddToAddedList),
      ItemCheap(label: 'Овсяное печенье', onTap: AddToAddedList),
      ItemCheap(label: 'Галеты', onTap: AddToAddedList),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: widget.isEditMode ? Text('Редактировать') : Text('Добавить прием пищи'),
        actions: [
          IconButton(
            onPressed: null,
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
              ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: 160
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _addedItems
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Недавнее'),
              SizedBox(height: 16),
              Wrap(
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
            onPressed: (){},
            backgroundColor: Colors.black,
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
              onPressed: (){},
              backgroundColor: Colors.black,
              child: const Icon(Icons.done,)),
        ),
        Positioned(
          bottom: 65,
          child: FloatingActionButton(
              heroTag: null,
              onPressed: (){},
              backgroundColor: Color(0xFFE63946),
              child: const Icon(Icons.delete_outline_rounded)),
        ),
      ],
    );
  }
}

