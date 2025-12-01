import 'package:hive_flutter/hive_flutter.dart';

/// Hive initialization service
/// Handles Hive setup for the application
class HiveService {
  /// Initialize Hive storage
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  /// Close all Hive boxes
  static Future<void> closeAll() async {
    await Hive.close();
  }
}

