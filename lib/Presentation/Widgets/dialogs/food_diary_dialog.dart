import 'package:flutter/material.dart';

class FoodDiaryDialog extends StatelessWidget {
  const FoodDiaryDialog({
    super.key,
    required this.title,
    required this.content,
    this.isEdit = true,
    this.isReadOnly = false,
    required this.onSave
  });

  final String title;
  final Widget content;
  final bool isEdit;
  final bool isReadOnly;
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Text(
            '$title',
            style: TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      content: SingleChildScrollView(child: content),
      actions: [
        Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4),
            ]),
          child: Row(
            children: [
              FlexButton(
                onTap: () => Navigator.pop(context),
                icon: Icons.close,
                isLeftEdge: true
              ),
              Container(width: 0.5, color: Color(0xFF818181)),
              isEdit
                ? FlexButton(
                    onTap: () => Navigator.pop(context),
                    icon: Icons.delete_outline_rounded
                  )
                : SizedBox(),
              isEdit
                  ? Container(width: 0.5, color: Color(0xFF818181))
                  : SizedBox(),
              FlexButton(
                onTap: () {
                  onSave();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Изменения сохранены'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icons.done,
                isRightEdge: true,
                isUnavailable: isReadOnly,
              ),
            ],
          )
        ),
      ],
    );
  }
}

class FlexButton extends StatelessWidget {
  const FlexButton(
      {super.key,
      required this.onTap,
      required this.icon,
      this.isLeftEdge = false,
      this.isRightEdge = false,
      this.isUnavailable = false});

  final void Function() onTap;
  final IconData icon;
  final bool isLeftEdge;
  final bool isRightEdge;
  final bool isUnavailable;

  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: isUnavailable ? null : onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              bottomRight: isRightEdge ? Radius.circular(10) : Radius.zero,
              bottomLeft: isLeftEdge ? Radius.circular(10) : Radius.zero),
          ),
          child: Icon(
            icon,
            color: isUnavailable ? Colors.grey : Colors.white
          ),
        ),
      )
    );
  }
}
