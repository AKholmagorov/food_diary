import 'package:food_diary/Models/drug_model.dart';

class MedicationModel {
  int id;
  List<DrugModel> drugs;

  MedicationModel({
    required this.id,
    required this.drugs,
  });
}