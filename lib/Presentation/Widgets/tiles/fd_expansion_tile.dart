import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodDiaryExpansionTile extends ConsumerStatefulWidget {
  const FoodDiaryExpansionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.content,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget content;
  final String? trailing;

  @override
  FoodDiaryExpansionTileState createState() => FoodDiaryExpansionTileState();
}

class FoodDiaryExpansionTileState extends ConsumerState<FoodDiaryExpansionTile> {  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4)
      ]),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Row(
          children: [
            Icon(widget.icon, color: Colors.black, size: 32),
            SizedBox(width: 12),
            Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
        trailing: widget.trailing != null
            ? Text(
                widget.trailing!,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color.fromARGB(255, 75, 75, 75)
                ),
              )
            : SizedBox(),
        children: [
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF818181),
              ),
            ),
          ),
          SizedBox(height: 10),
          widget.content,
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
