import 'package:flutter/material.dart';

class DrugTile extends StatefulWidget {
  const DrugTile({super.key, required this.title, required this.onDelete});

  final String title;
  final void Function(DrugTile) onDelete;

  @override
  State<DrugTile> createState() => _DrugTileState();
}

class _DrugTileState extends State<DrugTile> {
  int _drugCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F7),
        border: Border.all(color: Colors.black, width: 0.3),
        borderRadius: BorderRadius.circular(10),
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
          SizedBox(width: 16),
          Text(
            '${widget.title}',
            style: TextStyle(
              fontWeight: FontWeight.w500
            ),
          ),
          Spacer(),
          IconButton(
            splashColor: Colors.black.withOpacity(0),
            hoverColor: Colors.black.withOpacity(0),
            highlightColor: Colors.black.withOpacity(0),
            onPressed: () {
              setState(() {
                int temp = _drugCount;
                temp -= 1;

                if (temp > 0)
                  _drugCount -= 1;
                else
                  widget.onDelete(widget);
              });
            },
            icon: Icon(Icons.remove)
          ),
          //SizedBox(width: 4),
          SizedBox(child: Center(child: Text('$_drugCount')), width: 20),
          //SizedBox(width: 4),
          IconButton(
            splashColor: Colors.black.withOpacity(0),
            hoverColor: Colors.black.withOpacity(0),
            highlightColor: Colors.black.withOpacity(0),
            onPressed: () {
              setState(() => _drugCount < 99 ? _drugCount += 1 : 0);
            },
            icon: Icon(Icons.add)
          ),
        ],
      )
    );
  }
}
