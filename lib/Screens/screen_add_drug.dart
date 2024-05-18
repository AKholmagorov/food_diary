import 'package:flutter/material.dart';
import 'package:food_diary/Screens/add_screen.dart';
import 'package:food_diary/Presentation/Widgets/dialogs/add_drug_dialog.dart';
import 'package:food_diary/Presentation/Widgets/tiles/drug_tile.dart';
import 'package:food_diary/Presentation/Widgets/tiles/extras/item_cheap.dart';

class ScreenAddDrug extends AddScreen {
  const ScreenAddDrug({super.key, this.isEditMode = false});

  final bool isEditMode;

  @override
  State<ScreenAddDrug> createState() => _ScreenAddDrugState();
}

class _ScreenAddDrugState extends State<ScreenAddDrug> {
  List<DrugTile> _addedItems = [];
  List<ItemCheap> _recentItems = [];

  void AddToAddedList(ItemCheap item) {
    setState(() {
      _addedItems
          .add(new DrugTile(title: item.label, onDelete: AddToRecentList));
      _recentItems.remove(item);
    });
  }

  void AddToRecentList(DrugTile item) {
    setState(() {
      // _recentItems.add(new ItemCheap(label: item.title, onTap: AddToAddedList, editDialog: AddDrugDialog(title: 'Омез 20мг')));
      _addedItems.remove(item);
    });
  }

  void initState() {
    super.initState();
    _addedItems = [
      DrugTile(title: 'Полисорб', onDelete: AddToRecentList),
    ];
    _recentItems = [
      // ItemCheap(label: 'Омез 20мг', onTap: AddToAddedList, editDialog: AddDrugDialog(title: 'Омез 20мг')),
      // ItemCheap(label: 'Бифиформ', onTap: AddToAddedList, editDialog: AddDrugDialog(title: 'Омез 20мг')),
      // ItemCheap(label: 'Месакол', onTap: AddToAddedList, editDialog: AddDrugDialog(title: 'Омез 20мг')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.isEditMode ? Text('Редактировать') : Text('Добавить прием'),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AddDrugDialog(
                        title: 'Добавить препарат', isEdit: false);
                  }),
              icon: Icon(Icons.add, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  children: _addedItems.isEmpty
                      ? TextPlug()
                      : _addedItems
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
              onPressed: null,
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
            child: const Icon(
              Icons.done,
            )
          ),
        ),
        Positioned(
          bottom: 65,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            backgroundColor: Color(0xFFE63946),
            child: const Icon(Icons.delete_outline_rounded)
          ),
        ),
      ],
    );
  }
}

List<Widget> TextPlug() {
  return [
    SizedBox(height: 12),
    Center(
      child: Text(
        'Добавьте препараты на текущий прием',
        style: TextStyle(
          color: Color(0xFF818181)
        )
      ),
    ),
    SizedBox(height: 12),
  ];
}
