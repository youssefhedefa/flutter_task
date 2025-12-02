import 'package:flutter/material.dart';
import 'package:flutter_task/app/flutter_task_app.dart';
import 'package:flutter_task/app/init_services.dart';

void main() async {
  await IniServices().initialize();
  runApp(const FlutterTaskApp());
}
