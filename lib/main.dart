import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_diary/Presentation/Widgets/fd_nav_bar.dart';
import 'package:food_diary/Presentation/Widgets/utils/theme_constants.dart';
import 'package:food_diary/temp/gigachat_model.dart';

void main() async {
  runApp(ProviderScope(child: AppEntryPoint()));
  
  final apiService = ApiService();

  try {
    final response = await apiService.sendPrompt('Привет! Как дела?');
    print('Response: ${response}');
  } catch (e) {
    print('Error: $e');
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: foodDiaryDarkTheme,
      themeMode: ThemeMode.dark,
      // home: PromtGenerator()
      home: FoodDiaryNavBar(),
    );
  }
}