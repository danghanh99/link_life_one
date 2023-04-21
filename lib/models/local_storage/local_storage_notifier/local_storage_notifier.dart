
import 'dart:async';

import 'package:flutter/material.dart';
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
    return isOfflineMode;
  }

  Future<void> uploadData() async {
    print(await localStorageServices.uploadDB(onProgress: (progress){}));
    isOfflineMode = false;
    await LocalStorageBase.add(boxName: boxOfflineName, key: offlineParamName, model: false);
  }

}
