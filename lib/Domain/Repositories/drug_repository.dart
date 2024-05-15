import 'package:food_diary/Domain/Entities/drug_entity.dart';

abstract class DrugRepository {
  Future<Drug> addDrug(Drug meal);
  Future<void> removeDrug(Drug meal);
  Future<void> editDrug(Drug meal);
}