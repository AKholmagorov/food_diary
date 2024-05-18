import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Models/day_model.dart';
import 'package:food_diary/Presentation/Widgets/utils/symptom_types.dart';
import 'package:food_diary/Riverpod/riverpod.dart';

class FoodDiaryColorfulSlider extends ConsumerStatefulWidget {
  const FoodDiaryColorfulSlider({super.key, required this.symptomType});

  final SymptomTypes symptomType;

  @override
  FoodDiaryColorfulSliderState createState() => FoodDiaryColorfulSliderState();
}

class FoodDiaryColorfulSliderState extends ConsumerState<FoodDiaryColorfulSlider> {
  DayModel? _currentDay;
  bool isInited = false;
  late String _symptomeTitle;
  late TextStyle _currentTitleStyle;
  late Color _currentColor = Color(0xFFD3D3D3);
  late double _currentSliderValue = 0;

  void initSliderValues() {
    if (isInited)
      return;

    switch(widget.symptomType) {
      case SymptomTypes.blood:
        _symptomeTitle = 'Кровь';
        _currentSliderValue = _currentDay!.blood.toDouble();
      case SymptomTypes.slime:
        _symptomeTitle = 'Слизь';
        _currentSliderValue = _currentDay!.slime.toDouble();
      case SymptomTypes.flatulence:
        _symptomeTitle = 'Метеоризм';
        _currentSliderValue = _currentDay!.flatulence.toDouble();
      case SymptomTypes.pain:
        _symptomeTitle = 'Боль'; 
        _currentSliderValue = _currentDay!.pain.toDouble();
      case SymptomTypes.diarrhea:
        _symptomeTitle = 'Диарея';
        _currentSliderValue = _currentDay!.diarrhea.toDouble();
    }

    updateSliderTheme();
    isInited = true;
  }

  void updateSliderTheme() {
    if (_currentSliderValue > 0) {
      _currentTitleStyle = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500
      );
    }
    else
      _currentTitleStyle = TextStyle(color: Color(0xFF818181));

    if (_currentSliderValue == 0)
      _currentColor = Color(0xFFD3D3D3);
    else if(_currentSliderValue <= 3)
      _currentColor = Color(0xFFF9C74F);
    else
      _currentColor = Color(0xFFE63946);
  }

  @override
  Widget build(BuildContext context) {
    _currentDay = ref.watch(currentDayProvider.notifier).currentDay!;
    if (_currentDay == null)
      return Center(child: CircularProgressIndicator(color: Colors.black));

    initSliderValues();

    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: 90,
          margin: EdgeInsets.only(left: 16),
          child: Text('$_symptomeTitle', style: _currentTitleStyle),
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: 5,
            thumbColor: _currentColor,
            activeColor: _currentColor,
            value: _currentSliderValue,
            divisions: 5,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
                updateSliderTheme();
              });
            },
            onChangeEnd: (double value) {
              ref.read(currentDayProvider).updateSymptomValue(widget.symptomType, value.toInt());
            },
          )
        ),
      ],
    );
  }
}
