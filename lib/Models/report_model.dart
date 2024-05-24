import 'package:flutter/material.dart';

class ReportModel {
  final int id;
  final DateTime date;
  final int period;
  final String recommendationText;
  final String modelName;
  final Image modelImage;

  ReportModel({
    required this.id,
    required this.date,
    required this.period,
    required this.recommendationText,
    required this.modelName,
    required this.modelImage
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    Image defineModelImage(String modelName) {
      return Image(image: AssetImage('assets/GigaChat Pro.jpg'));
      // return Image(image: AssetImage('assets/$modelName.jpg'));
    }
    
    return ReportModel(
      id: map['id'] as int,
      date: DateTime.parse(map['date'] as String),
      period: map['period'] as int,
      modelName: map['model_name'] as String,
      recommendationText: map['recommendation_text'] as String,
      modelImage: defineModelImage(map['model_name'])
    );
  }
}