import 'package:flutter/material.dart';

class FoodDiaryTile extends StatelessWidget {
  const FoodDiaryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap
  });

  final IconData icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7F7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 0.3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 4
            )
          ]
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 32),
            SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            )
          ],
        ),
      )
    );
  }
}
