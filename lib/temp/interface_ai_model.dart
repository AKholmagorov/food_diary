import 'package:flutter/material.dart';

abstract class IAIModel {
  abstract String name;
  abstract AssetImage image;

  Future<String> getRecommendation(int period);
}