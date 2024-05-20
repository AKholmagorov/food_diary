import 'package:flutter/material.dart';

class ItemCheap extends StatelessWidget {
  const ItemCheap({
    super.key, 
    required this.itemId,
    required this.label, 
    this.onTap, 
    this.editDialog, 
  });

  final int itemId;
  final String label;
  final void Function(int, String)? onTap;
  final Widget? editDialog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(itemId, label);
        }
      },
      onLongPress: () {
        if (editDialog != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return editDialog!;
            },
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 4
            )
          ]
        ),
        child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white
            ),
            overflow: TextOverflow.ellipsis
        ),
      ),
    );
  }
}
