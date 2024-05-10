import 'package:flutter/material.dart';

class FoodDiaryExpansionTile extends StatelessWidget {
  const FoodDiaryExpansionTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
      required this.content,
      this.trailing});

  final IconData icon;
  final String title;
  final String description;
  final Widget content;
  final String? trailing;

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
            Icon(icon, color: Colors.black, size: 32),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
        trailing: trailing != null
            ? Text(
                trailing!,
                style: TextStyle(fontWeight: FontWeight.w700),
              )
            : SizedBox(),
        children: [
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF818181),
              ),
            ),
          ),
          SizedBox(height: 10),
          content,
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
