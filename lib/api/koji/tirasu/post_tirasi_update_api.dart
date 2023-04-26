import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:dio/dio.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';

import '../../../constants/constant.dart';

class PostTirasiUpdateApi {
  PostTirasiUpdateApi() : super();

  Future<void> _notSuccess({
    required ymd,
    required loginId,
    required kojiTirasisu,
    required Function onFailed,
    required Function onSuccess,
  })async{
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().postTirasiUpdate(
          ymd: ymd,
          loginId: loginId,
          kojiTirasisu: kojiTirasisu
      );
      onSuccess.call();
      return res;
    }
    else{
      onFailed.call();
    }
  }

  Future<void> postTirasiUpdateApi({
    required String YMD,
    required String LOGIN_ID,
    required String KOJI_TIRASISU,
    required Function onFailed,
    required Function onSuccess,
  }) async {

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      return _notSuccess(
          ymd: YMD,
          loginId: LOGIN_ID,
          kojiTirasisu: KOJI_TIRASISU,
          onFailed: onFailed,
          onSuccess: onSuccess
      );
    }

    try {
      var dio = Dio();
      String url = "${Constant.url}Request/Koji/requestPostTirasiUpdate.php";
      FormData formData = FormData.fromMap(
        {
          'YMD': YMD,
          'KOJI_TIRASISU': KOJI_TIRASISU,
          'LOGIN_ID': LOGIN_ID,
        },
      );

      final response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        onSuccess.call();
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }
}
