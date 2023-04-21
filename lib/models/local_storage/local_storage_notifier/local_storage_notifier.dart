
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:link_life_one/api/local_storages/upload_changed_data_api.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';

class LocalStorageNotifier extends ChangeNotifier {

  static bool isOfflineMode = false;

  LocalStorageServices localStorageServices = LocalStorageServices();

  StreamController progressController = StreamController.broadcast();

  Future<void> downloadData() async {
    LocalStorageBase.actionStatus = 0;
    await localStorageServices.downloadDB(
      onProgress: (percent){
        progressController.add(percent);
      }
    );
    await localStorageServices.checkTodayDownloaded();
    LocalStorageBase.actionStatus = 1;
    isOfflineMode = true;
    await LocalStorageBase.add(boxName: boxOfflineName, key: offlineParamName, model: true);
  }

  static Future<bool> hasTodayData()async{
    return await LocalStorageServices.isTodayDataDownloaded();
  }

  static Future<bool> isOffineMode()async{
    isOfflineMode = (await LocalStorageBase.get(boxName: boxOfflineName, key: offlineParamName))??false;
    print('mode: $isOfflineMode');
    return isOfflineMode;
  }

  Future<void> uploadData() async {
    var body = await localStorageServices.uploadDB(onProgress: (progress){});
    print('body: $body}');
    await UploadChangedDataAPI().uploadDB(
        body: body,
        onSuccess: (){},
        onFailed: (){}
    );
    isOfflineMode = false;
    await LocalStorageBase.add(boxName: boxOfflineName, key: offlineParamName, model: false);
    print('Done upload');
  }

}
