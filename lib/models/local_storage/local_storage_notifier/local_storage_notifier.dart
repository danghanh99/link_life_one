
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';

class LocalStorageNotifier extends ChangeNotifier {

  LocalStorageServices localStorageServices = LocalStorageServices();

  StreamController progressController = StreamController.broadcast();

  Future<void> downloadData() async {
    await localStorageServices.downloadDB(
      onProgress: (percent){
        progressController.add(percent);
      }
    );
    await localStorageServices.checkTodayDownloaded();
  }

  Future<bool> hasTodayData()async{
    return await LocalStorageServices.isTodayDataDownloaded();
  }

  Future<void> uploadData() async {
    print('uploading');
    await Future.delayed(Duration(seconds: 5));
    print('uploaded');
  }

}
