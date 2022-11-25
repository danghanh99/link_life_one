import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveService {
  Future<void> initialize();
}

class HiveServiceImpl implements HiveService {
  static Future<HiveService> getInstance() async {
    final hiveService = HiveServiceImpl();
    await hiveService.initialize();
    return hiveService;
  }

  @override
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
  }
}
