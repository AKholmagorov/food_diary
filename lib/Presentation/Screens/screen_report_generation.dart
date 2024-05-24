import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Presentation/Widgets/ai_model_item.dart';
import 'package:food_diary/Riverpod/riverpod.dart';
import 'package:food_diary/temp/gigachat_model.dart';
import 'package:food_diary/temp/gigachat_model_types.dart';
import 'package:food_diary/temp/interface_ai_model.dart';

class ScreenReportGeneration extends ConsumerStatefulWidget {
  const ScreenReportGeneration({super.key});

  @override
  ScreenReportGenerationState createState() => ScreenReportGenerationState();
}

class ScreenReportGenerationState extends ConsumerState<ScreenReportGeneration> {
  List<IAIModel> _models = [
    GigaChatModel(GigaChatModelType.Lite),
    GigaChatModel(GigaChatModelType.LitePlus),
    GigaChatModel(GigaChatModelType.Pro),
  ];
  List<int> _periods = [7, 14, 30];

  int _selectedPeriodIndex = 0;
  int _selectedModelIndex = 0;
  void onTapModel(int index) => setState(() => _selectedModelIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 5, 
                    color: Colors.white
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Формируем отчет...', 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  )
                ],
              )
            )
          );
          String recommendation = await _models[_selectedModelIndex].getRecommendation(_periods[_selectedPeriodIndex]);
          ref.read(reportProvider).addReport(
            _periods[_selectedPeriodIndex], 
            _models[_selectedModelIndex], 
            recommendation
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Отчет создан')));
        },
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
            children: List.generate(
              _models.length,
              (index) {
                return AIModelItem(
                  isActive: _selectedModelIndex == index,
                  name: _models[index].name, 
                  logo: _models[index].image, 
                  onTap: onTapModel, 
                  modelNumber: index
                );
              }
            )
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
            segments: List.generate(
              _periods.length, 
              (index) {
                return ButtonSegment(
                  value: index,
                  label: Text('${_periods[index]} дней'),
                );
              }
            ),
            selected: {_selectedPeriodIndex},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() => _selectedPeriodIndex = newSelection.first);
            },
          ),
        ],
      ),
    );
  }
}