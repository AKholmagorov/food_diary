import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Presentation/Widgets/fd_nav_bar.dart';
import 'package:food_diary/Presentation/Widgets/utils/theme_constants.dart';

void main() async {
  runApp(ProviderScope(child: AppEntryPoint()));
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: foodDiaryDarkTheme,
      themeMode: ThemeMode.dark,
      home: FoodDiaryNavBar(),
    );
  }
}