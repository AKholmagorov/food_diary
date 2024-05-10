import 'package:flutter/material.dart';

class FoodDiaryDialog extends StatelessWidget {
  const FoodDiaryDialog({super.key, required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('$title', style: TextStyle(color: Colors.white)),
        ),
      ),
      content: SingleChildScrollView(child: content),
      actions: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4
              ),
            ]
          ),
          child: Row(
            children: [
              FlexButton(
                onTap: () => Navigator.pop(context),
                icon: Icons.close,
                isLeftEdge: true
              ),
              FlexButton(
                onTap: () => Navigator.pop(context),
                icon: Icons.delete_outline_rounded
              ),
              FlexButton(
                onTap: () => Navigator.pop(context),
                icon: Icons.done,
                isRightEdge: true
              ),
            ],
          )
        ),
      ],
    );
  }
}

class FlexButton extends StatelessWidget {
  const FlexButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.isLeftEdge = false,
    this.isRightEdge = false});

  final void Function() onTap;
  final IconData icon;
  final bool isLeftEdge;
  final bool isRightEdge;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomRight: isRightEdge ? Radius.circular(10) : Radius.zero,
              bottomLeft: isLeftEdge ? Radius.circular(10) : Radius.zero
            ),
          ),
          child: Icon(icon, color: Colors.white),
        ),
      )
    );
  }
}
