import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/core/networking/storage/data/hive_service.dart';
import 'package:flutter_task/core/utilities/service_locator.dart';
import 'package:get_it/get_it.dart';

class IniServices {
  static final IniServices _instance = IniServices._internal();

  final GetIt getIt = GetIt.instance;

  factory IniServices() {
    return _instance;
  }

  IniServices._internal();

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    makeStatusBarTransparent();
    await HiveService.init();
    initServiceLocator();
  }

  void makeStatusBarTransparent() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
