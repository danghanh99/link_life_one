import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:dio/dio.dart';

class UploadPhotoApi {
  UploadPhotoApi() : super();

  Future<void> uploadPhotoApi({
    required String JYUCYU_ID,
    required String LOGIN_ID,
    required String FILE_PATH,
    required Function onFailed,
    required Function onSuccess,
  }) async {
    try {
      var dio = Dio();
      String url =
          "https://koji-app.starboardasiavn.com/Request/Koji/requestPostPhotoSubmissionRegistration.php";
      FormData formData = FormData.fromMap(
        {
          'FILE_NAME': await MultipartFile.fromFile(FILE_PATH),
          'JYUCYU_ID': JYUCYU_ID,
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
