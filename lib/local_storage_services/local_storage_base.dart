import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/models/local_storage/m_gyosya.dart';
import 'package:link_life_one/models/local_storage/m_kbn.dart';
import 'package:link_life_one/models/local_storage/m_syohin.dart';
import 'package:link_life_one/models/local_storage/m_tant.dart';
import 'package:link_life_one/models/local_storage/t_koji.dart';
import 'package:link_life_one/models/local_storage/t_koji_check.dart';
import 'package:link_life_one/models/local_storage/t_koji_file_path.dart';
import 'package:link_life_one/models/local_storage/t_kojimsai.dart';
import 'package:link_life_one/models/local_storage/t_tirasi.dart';

const boxGyosyaName = 'gyosya';
const boxSyohinName = 'syohin';
const boxTantName = 'tant';
const boxKbnName = 'kbn';
const boxKojiName = 'koji';
const boxKojiCheckName = 'kojiCheck';
const boxKojiFilePathName = 'kojiFilePath';
const boxKojimsaiName = 'kojimsai';
const boxTirasiName = 'tirasi';

const boxDateName = 'date';
const dateParamName = 'd';

const boxOfflineName = 'isOffline';
const offlineParamName = 'offline';

class LocalStorageBase{
  
  static int actionStatus = 1;

  static init(){
    _registerAdapters();
    _openBoxs();
  }

  static Future<Box> _getBox(name) async {
    return await Hive.openBox(name);
  }
  
  static dynamic _addStatus({required boxName, required model}){
    if(boxName == boxGyosyaName) (model as MGyosya).status=actionStatus;
    if(boxName == boxSyohinName) (model as MSyohin).status=actionStatus;
    if(boxName == boxTantName) (model as MTant).status=actionStatus;
    if(boxName == boxKbnName) (model as MKBN).status=actionStatus;
    if(boxName == boxKojiName) (model as TKoji).status=actionStatus;
    if(boxName == boxKojiCheckName) (model as TKojiCheck).status=actionStatus;
    if(boxName == boxKojiFilePathName) (model as TKojiFilePath).status=actionStatus;
    if(boxName == boxKojimsaiName) (model as TKojimsai).status=actionStatus;
    if(boxName == boxTirasiName) (model as TTirasi).status=actionStatus;
    return model;
  }

  static Future add({required boxName, required key, required model}) async {
    await (await _getBox(boxName)).put(key, _addStatus(boxName: boxName, model: model));
  }

  static Future<dynamic>? get({required boxName, required key}) async {
    return await (await _getBox(boxName)).get(key);
  }

  static Future<Iterable> getValues({required boxName}) async {
    return (await _getBox(boxName)).values;
  }

  static Future<void> delete({required boxName, required key}) async {
    return await (await _getBox(boxName)).delete(key);
  }

  static clear({required boxName}) async {
    return await (await _getBox(boxName)).clear();
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
    await Hive.openBox(boxDateName);
    await Hive.openBox(boxGyosyaName);
    await Hive.openBox(boxSyohinName);
    await Hive.openBox(boxTantName);
    await Hive.openBox(boxKbnName);
    await Hive.openBox(boxKojiName);
    await Hive.openBox(boxKojiCheckName);
    await Hive.openBox(boxKojiFilePathName);
    await Hive.openBox(boxKojimsaiName);
    await Hive.openBox(boxTirasiName);
    await Hive.openBox(boxDateName);
  }

}