import 'package:flutter/material.dart';

extension NumExtension on num {
  double get toDoubleValue => toDouble();
  int get toIntValue => toInt();

  Widget get horizontalSpace => SizedBox(width: toDoubleValue);
  Widget get verticalSpace => SizedBox(height: toDoubleValue);
}
