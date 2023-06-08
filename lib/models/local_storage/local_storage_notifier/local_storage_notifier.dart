
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/local_storages/upload_changed_data_api.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';

class LocalStorageNotifier extends ChangeNotifier {

  // static bool isChoosenToday = true;
  // static bool isOfflineMode = false;
  static String? downloadDate;

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
    await hasTodayData();
    LocalStorageBase.actionStatus = 1;
    // isOfflineMode = true;
    await LocalStorageBase.add(boxName: boxOfflineName, key: offlineParamName, model: true);
  }

  static hasTodayData()async{
    var isTrue = await LocalStorageServices.isTodayDataDownloaded();
    if(isTrue) downloadDate = DateFormat('yyyyMMdd').format(DateTime.now());
  }

  static Future<bool> isOnline()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile
      || connectivityResult == ConnectivityResult.wifi
      || connectivityResult == ConnectivityResult.ethernet
      || connectivityResult == ConnectivityResult.vpn
      || connectivityResult == ConnectivityResult.other) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return false;
  }

  static isTodayDownload(){
    return downloadDate==DateFormat('yyyyMMdd').format(DateTime.now());
  }

  // static changeDate(DateTime date){
  //   print(date);
  //   isChoosenToday = DateFormat('yyyyMMdd').format(date)==DateFormat('yyyyMMdd').format(DateTime.now());
  //   print('c date: $isChoosenToday');
  // }

  // static Future<bool> isOffineMode()async{
  //   isOfflineMode = (await LocalStorageBase.get(boxName: boxOfflineName, key: offlineParamName))??false;
  //   print('mode: $isOfflineMode');
  //   return isOfflineMode;
  // }

  Future<void> uploadData({required Function onSuccess, required Function(String) onFailed}) async {
    if(await isOnline() && isTodayDownload()) {
      var body = await localStorageServices.uploadDB(onProgress: (progress) {});
      print('body: ${json.encode(body)}');
      await UploadChangedDataAPI().uploadDB(
          body: body,
          onProgress: (percent){
            progressController.add(percent);
          },
          onSuccess: () async {
            // await LocalStorageBase.add(boxName: boxOfflineName, key: offlineParamName, model: false);
            downloadDate = null;
            onSuccess.call();
          },
          onFailed: onFailed);
      print('Done upload');
    }
    else{
      if(!isTodayDownload()) {
        onFailed.call('データをアップロードされたました。再度アップロードデータが存在しません。');
      }
      else{
        onFailed.call('');
      }
    }
  }

}
