import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() {
    return _instance;
  }

  HiveManager._internal();

  Future<void> init() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  Future<Box> openBox(String name) async {
    return Hive.openBox(name);
  }

  Future<void> insert(String boxName, dynamic key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  Future<void> update(String boxName, dynamic key, dynamic value) async {
    final box = await openBox(boxName);
    await box.put(key, value);
  }

  Future<void> delete(String boxName, dynamic key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }
}
