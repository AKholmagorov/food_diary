import 'package:flutter/material.dart';

class AIModelItem extends StatelessWidget {
    const AIModelItem({
    super.key,
    required this.name,
    required this.logo, 
    this.isActive = false, 
    required this.onTap, 
    required this.modelNumber
  });

  final int modelNumber;
  final bool isActive;
  final AssetImage logo;
  final String name;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(modelNumber),
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: isActive ? Color(0xFF30DA88) : Colors.black.withOpacity(0),
            child: CircleAvatar(
              radius: 32,
              backgroundImage: logo,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: 80,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500
              ),
            ),
          )
        ],
      ),
    );
  }
}