import 'package:flutter/material.dart';
import 'package:flutter_task/core/routing/app_routing_manager.dart';
import 'package:flutter_task/core/routing/routing_constants.dart';
import 'package:flutter_task/core/theming/app_themes_manager.dart';

class FlutterTaskApp extends StatelessWidget {
  const FlutterTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      onGenerateRoute: AppRoutingManager().onGenerateRoute,
      initialRoute: AppRoutingConstants.splash,
    );
  }
}
