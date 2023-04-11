import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:link_life_one/models/local_objects/m_gyosya.dart';
import 'package:link_life_one/models/local_objects/m_kbn.dart';
import 'package:link_life_one/models/local_objects/m_syohin.dart';
import 'package:link_life_one/models/local_objects/m_tant.dart';
import 'package:link_life_one/models/local_objects/t_koji.dart';
import 'package:link_life_one/models/local_objects/t_koji_check.dart';
import 'package:link_life_one/models/local_objects/t_koji_file_path.dart';
import 'package:link_life_one/models/local_objects/t_kojimsai.dart';
import 'package:link_life_one/models/local_objects/t_tirasi.dart';

const boxGyosyaName = 'gyosya';
const boxSyohinName = 'syohin';
const boxTantName = 'tant';
const boxKbnName = 'kbn';
const boxKojiName = 'koji';
const boxKojiCheckName = 'kojiCheck';
const boxKojiFilePathName = 'kojiFilePath';
const boxKojimsaiName = 'kojimsai';
const boxTirasiName = 'tirasi';

class LocalStorageService{

  static init(){
    _registerAdapters();
    _openBoxs();
  }

  static Future<Box> _getBox(name) async {
    return await Hive.openBox(name);
  }

  static Future add({required boxName, required key, required model}) async {
    await (await _getBox(boxName)).put(key, model);
  }

  static Future<TKoji?>? get({required boxName, required key}) async {
    return await (await _getBox(boxName)).get(key);
  }

  static Future<void> delete({required boxName, required key}) async {
    return await (await _getBox(boxName)).delete(key);
  }

  static _registerAdapters(){
    Hive.registerAdapter(MGyosyaAdapter());
    Hive.registerAdapter(MSyohinAdapter());
    Hive.registerAdapter(MTantAdapter());
    Hive.registerAdapter(MKBNAdapter());
    Hive.registerAdapter(TKojiAdapter());
    Hive.registerAdapter(TKojiCheckAdapter());
    Hive.registerAdapter(TKojiFilePathAdapter());
    Hive.registerAdapter(TKojimsaiAdapter());
    Hive.registerAdapter(TTirasiAdapter());
  }

  static _openBoxs()async{
    await Hive.openBox(boxGyosyaName);
    await Hive.openBox(boxSyohinName);
    await Hive.openBox(boxTantName);
    await Hive.openBox(boxKbnName);
    await Hive.openBox(boxKojiName);
    await Hive.openBox(boxKojiCheckName);
    await Hive.openBox(boxKojiFilePathName);
    await Hive.openBox(boxKojimsaiName);
    await Hive.openBox(boxTirasiName);
  }

}