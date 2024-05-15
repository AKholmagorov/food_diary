import 'package:food_diary/Data/Models/day_model.dart';

abstract class DayRepository {
  Future<DayModel> getDay(DateTime date);
  Future<void> addDay(DayModel dayModel);
  Future<void> editDay(DateTime date);
}