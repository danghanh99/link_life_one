import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:dio/dio.dart';

import '../../../constants/constant.dart';

class PostTirasiUpdateApi {
  PostTirasiUpdateApi() : super();

  Future<void> postTirasiUpdateApi({
    required String YMD,
    required String LOGIN_ID,
    required String KOJI_TIRASISU,
    required Function onFailed,
    required Function onSuccess,
  }) async {
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
