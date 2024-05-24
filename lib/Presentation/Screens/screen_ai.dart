import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_report_history.dart';
import 'package:food_diary/Presentation/Screens/screen_report_generation.dart';

class ScreenAI extends StatefulWidget {
  const ScreenAI({super.key});

  @override
  State<ScreenAI> createState() => _ScreenAIState();
}

class _ScreenAIState extends State<ScreenAI> {
  int _currentPage = 0;
  List<Widget> _pages = [
    ScreenReportGeneration(),
    ScreenReportHistory()
  ];  

  void changePage(int index) => setState(() => _currentPage = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageButton(
                  title: 'Генерация',
                  currentPage: _currentPage, 
                  buttonPageNumber: 0,
                  onPressed: changePage
                ),
                SizedBox(width: 10),
                PageButton(
                  title: 'История',
                  currentPage: _currentPage, 
                  buttonPageNumber: 1,
                  onPressed: changePage
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(child: _pages[_currentPage])
          ]
        ),
      )
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    super.key, 
    required this.title,
    required this.currentPage,
    required this.buttonPageNumber, 
    required this.onPressed, 
  });

  final String title;
  final int currentPage;
  final int buttonPageNumber;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: currentPage == buttonPageNumber ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          )
        ),
        onPressed: () => onPressed(buttonPageNumber),
        child: Text(
          title,
          style: TextStyle(
            color: currentPage != buttonPageNumber ? Colors.black : Colors.white,
          ),
        ),
      );
  }
}
