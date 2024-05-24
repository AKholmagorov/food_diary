import 'package:flutter/material.dart';
import 'package:food_diary/food_diary_db.dart';
import 'package:food_diary/Models/drug_model.dart';

class DrugStorageNotifier extends ChangeNotifier {
  final FoodDiaryDB db;
  late List<DrugModel> drugList;

  DrugStorageNotifier(this.db) {
    getAllDrugs();
  }

  void getAllDrugs() {
    drugList = db.getAllDrugs();
    notifyListeners();
  }

  DrugModel getDrug(int id) {
    return drugList.firstWhere((e) => e.id == id);
  }

  void addDrug(String drugName) {
    db.db.execute('''
      INSERT INTO drugs (name)
      VALUES ('$drugName');
    ''');

    var res = db.db.select('''
      SELECT * FROM drugs WHERE id = ${db.db.lastInsertRowId};
    ''');

    drugList.add(DrugModel.fromMap(res.first));
    notifyListeners();
  }

  void editDrug(int drugID, String newDrugName) {
    db.db.execute('''
      UPDATE drugs
      SET name = '${newDrugName}'
      WHERE id = $drugID;
    ''');

    var res = db.db.select('''
      SELECT * FROM drugs WHERE id = $drugID;
    ''');

    drugList.remove(drugList.firstWhere((e) => e.id == drugID));
    drugList.add(DrugModel.fromMap(res.first));
    getAllDrugs();
    
    notifyListeners();
  }

  void removeDrug(int drugID) {
    db.db.execute('''
      DELETE FROM drugs
      WHERE id = $drugID;
    ''');

    drugList.remove(drugList.firstWhere((e) => e.id == drugID));
    getAllDrugs();
    
    notifyListeners();
  }
}