
import 'package:flutter/material.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';

class LocalStorageNotifier extends ChangeNotifier {

  LocalStorageServices _localStorageServices = LocalStorageServices();

  Future<void> downloadData() async {
    await _localStorageServices.downloadDB();
  }



  Future<void> uploadData() async {
    print('uploading');
    await Future.delayed(Duration(seconds: 5));
    print('uploaded');
  }

}
