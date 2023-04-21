import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/models/local_storage/t_tirasi.dart';
import 'dart:convert';

import '../../../constants/constant.dart';
import '../../../models/user.dart';

class GetTirasi {
  GetTirasi() : super();

  _notSuccess({required DateTime date, required Function onFailed, required Function(dynamic) onSuccess}) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var ttirasi = await LocalStorageBase.getValues(boxName: boxTirasiName);
      var list = ttirasi.map<Map>((e) => (e as TTirasi).toJson()).toList();
      onSuccess.call(list);
    }
    else{
      onFailed.call();
    }
  }

  Future<void> getTirasi({
    required DateTime YMD,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String LOGIN_ID = userBox.values.last.TANT_CD;

    if(LocalStorageNotifier.isOfflineMode && LocalStorageNotifier.isChoosenToday){
      return _notSuccess(
          date: YMD,
          onFailed: onFailed,
          onSuccess: onSuccess
      );
    }

    try{
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestGetTirasi.php?YMD=${DateFormat(('yyyy-MM-dd')).format(YMD)}&LOGIN_ID=${LOGIN_ID}"),
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call(body);
      }
      else {
        onFailed.call();
      }
    } catch(e){
      onFailed.call();
    }


  }
}
