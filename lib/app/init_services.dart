import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IniServices {
  static final IniServices _instance = IniServices._internal();

  factory IniServices() {
    return _instance;
  }

  IniServices._internal();

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    makeStatusBarTransparent();
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
