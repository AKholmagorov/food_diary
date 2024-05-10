import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/utils/ai_model_type.dart';

class AIModelItem extends StatefulWidget {
  const AIModelItem({super.key, required this.isActive, required this.aiModelType});

  final bool isActive;
  final AIModelType aiModelType;

  @override
  State<AIModelItem> createState() => _AIModelItemState();
}

class _AIModelItemState extends State<AIModelItem> {
  @override
  Widget build(BuildContext context) {
    Map<AIModelType, AssetImage> aiLogo = {
      AIModelType.GigaChatPro: AssetImage('assets/gigachat.jpg'),
    };

    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: widget.isActive ? Color(0xFF30DA88) : null,
          child: CircleAvatar(
            radius: 32,
            backgroundImage: aiLogo[widget.aiModelType],
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 72,
          child: Text(
            'GigaChat Pro',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w700
            ),
          ),
        )
      ],
    );
  }
}

class AIModel {
  
}
