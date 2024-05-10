import 'package:flutter/material.dart';

class FoodDiaryColorfulSlider extends StatefulWidget {
  const FoodDiaryColorfulSlider({super.key, required this.title});

  final String title;

  @override
  State<FoodDiaryColorfulSlider> createState() => _FoodDiaryColorfulSliderState();
}

class _FoodDiaryColorfulSliderState extends State<FoodDiaryColorfulSlider> {
  late TextStyle _currentTitleStyle;
  late Color _currentColor = Color(0xFFD3D3D3);
  late double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();

    // TODO: extract data from db
    _currentSliderValue = 0;

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
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: 85,
          margin: EdgeInsets.only(left: 16),
          child: Text('${widget.title}', style: _currentTitleStyle),
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
              });
            }
          )
        ),
      ],
    );
  }
}
