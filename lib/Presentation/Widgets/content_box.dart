import 'package:flutter/material.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({
    super.key,
    required this.title,
    required this.content,
    this.spaceBetweenTitleAndContent = 10,
  });

  final String title;
  final List<Widget> content;
  final double spaceBetweenTitleAndContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: spaceBetweenTitleAndContent),
          Wrap(
            spacing: 10,
            runSpacing: 7,
            children: content,
          )
        ],
      )
    );
  }
}
