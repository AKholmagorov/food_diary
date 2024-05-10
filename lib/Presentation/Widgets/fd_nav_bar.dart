import 'package:flutter/material.dart';
import 'package:food_diary/Presentation/Screens/screen_ai.dart';
import 'package:food_diary/Presentation/Screens/screen_calendar.dart';
import 'package:food_diary/Presentation/Screens/screen_home.dart';

class FoodDiaryNavBar extends StatefulWidget {
  const FoodDiaryNavBar({super.key});

  @override
  State<FoodDiaryNavBar> createState() => _FoodDiaryNavBarState();
}

class _FoodDiaryNavBarState extends State<FoodDiaryNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        ScreenCalendar(),
        ScreenHome(),
        ScreenAI()
      ][currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        indicatorColor: Colors.white.withOpacity(0),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          setState(() => currentIndex = index);
        },
        destinations: [
          NavigationDestination(
            label: 'Calendar',
            icon: Icon(
              size: 48,
              Icons.calendar_month,
              color: Colors.white.withOpacity(0.5)),
            selectedIcon: Icon(
              size: 48,
              Icons.calendar_month,
              color: Colors.white),
          ),
          NavigationDestination(
            label: 'Home',
            icon: Icon(
              size: 48,
              Icons.home,
              color: Colors.white.withOpacity(0.5)),
            selectedIcon: Icon(
              size: 48,
              Icons.home,
              color: Colors.white),
          ),
          NavigationDestination(
            label: 'AI',
            icon: Icon(
              size: 48,
              Icons.biotech_rounded,
              color: Colors.white.withOpacity(0.5)),
            selectedIcon: Icon(
              size: 48,
              Icons.biotech_rounded,
              color: Colors.white),
          ),
        ],
      ),
    );
  }
}
