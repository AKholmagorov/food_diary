import 'package:flutter/material.dart';

class FoodDiaryTile extends StatelessWidget {
  const FoodDiaryTile(
      {super.key,
      this.leadingIcon,
      required this.title,
      this.subtitle,
      this.onTap,
      this.trailingIcon,
      this.isExpanded = true});

  final String title;
  final String? subtitle;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final void Function()? onTap;
  final bool isExpanded;

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
                blurRadius: 4)
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leadingIcon != null ? leadingIcon! : SizedBox(),
            leadingIcon != null ? SizedBox(width: 12) : SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                subtitle != null ? SizedBox(height: 2) : SizedBox(),
                subtitle != null
                  ? Text(subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF818181),
                        fontWeight: FontWeight.w500))
                  : SizedBox(),
              ],
            ),
            isExpanded ? Spacer() : SizedBox(),
            trailingIcon != null ? SizedBox(width: 12) : SizedBox(),
            trailingIcon != null ? trailingIcon! : SizedBox(),
          ],
        ),
      ),
    );
  }
}
