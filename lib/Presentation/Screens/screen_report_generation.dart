import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Widgets/ai_model_item.dart';

class ScreenReportGeneration extends StatefulWidget {
  const ScreenReportGeneration({super.key});

  @override
  State<ScreenReportGeneration> createState() => _ScreenReportGenerationState();
}

class _ScreenReportGenerationState extends State<ScreenReportGeneration> {
  int _selectedModel = 0;
  int _selectedPeriod = 0;
  void changeModel(int index) => setState(() => _selectedModel = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.auto_fix_normal_outlined),
      ),
      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите модель',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AIModelItem(
                isActive: _selectedModel == 0,
                name: 'GigaChat Pro', 
                logo: AssetImage('assets/gigachat.jpg'), 
                onTap: changeModel, 
                modelNumber: 0,
              ),
              SizedBox(width: 12),
              AIModelItem(
                isActive: _selectedModel == 1,
                name: 'ChatGPT 3.5', 
                logo: AssetImage('assets/gpt-3.5.jpg'), 
                onTap: changeModel,
                modelNumber: 1,
              ),
              SizedBox(width: 12),
              AIModelItem(
                isActive: _selectedModel == 2,
                name: 'ChatGPT 4', 
                logo: AssetImage('assets/gpt-4.jpg'), 
                onTap: changeModel,
                modelNumber: 2,
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'Укажите период',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 12),
          SegmentedButton<int>(
            style: SegmentedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 18
              ),
              selectedBackgroundColor: Colors.black,
              selectedForegroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: 0,
                label: Text('7 дней')
              ),
              ButtonSegment(
                value: 1,
                label: Text('14 дней')
              ),
              ButtonSegment(
                value: 2,
                label: Text('21 день')
              ),
            ],
            selected: {_selectedPeriod},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() => _selectedPeriod = newSelection.first);
            },
          ),
        ],
      ),
    );
  }
}