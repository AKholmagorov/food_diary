import 'package:food_diary/Domain/Entities/meal_entity.dart';

abstract class MealRepository {
  Future<Meal> addMeal(Meal meal);
  Future<void> removeMeal(Meal meal);
  Future<void> editMeal(Meal meal);
}