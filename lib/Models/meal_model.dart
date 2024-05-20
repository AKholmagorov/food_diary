import 'package:food_diary/Models/food_model.dart';

class MealModel {
  int id;
  List<FoodModel> food;

  MealModel({
    required this.id,
    required this.food,
  });
}