import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

extension WidgetExtension on Widget {
  Widget loading({bool isLoading = true}) {
    return Skeletonizer(
      enabled: isLoading,
      child: this,
    );
  }
}
