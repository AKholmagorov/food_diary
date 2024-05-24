import 'package:flutter/material.dart';
import 'package:food_diary/Models/report_model.dart';
import 'package:food_diary/food_diary_db.dart';
import 'package:food_diary/temp/interface_ai_model.dart';
import 'package:intl/intl.dart';

class ReportModelNotifier extends ChangeNotifier {
  final FoodDiaryDB db;
  List<ReportModel> reportList = [];

  ReportModelNotifier(this.db) {
    getAllReports();
  }

  void getAllReports() {
    reportList = db.getAllReports();
    notifyListeners();
  }

  ReportModel getReport(int id) {
    return reportList.firstWhere((e) => e.id == id);
  }

  void addReport(int period, IAIModel model, String recommendation_text) {
    db.db.execute('''
      INSERT INTO reports (date, model_name, period, recommendation_text)
      VALUES ('${_dateToString(DateTime.now())}', '${model.name}', $period, '$recommendation_text');
    ''');

    var res = db.db.select('''
      SELECT * FROM reports WHERE id = ${db.db.lastInsertRowId};
    ''');

    reportList.add(ReportModel.fromMap(res.first));
    notifyListeners();
  }

  void removeReport(int reportID) {
    db.db.execute('''
      DELETE FROM reports
      WHERE id = $reportID
    ''');

    reportList.remove(reportList.firstWhere((e) => e.id == reportID));
    notifyListeners();
  }

  String _dateToString(DateTime date) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}