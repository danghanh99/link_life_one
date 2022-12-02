import 'dart:convert';

import 'package:dio/dio.dart';

class CreateRiyuu {
  CreateRiyuu() : super();

  Future<dynamic> createRiyuu({
    required String JYUCYU_ID,
    required String SHITAMI_MENU,
    required String FILE_PATH,
    String? MTMORI_YMD,
    String? CANCEL_RIYU,
    required Function() onSuccess,
    required Function(String? errorMessage) onFailed,
  }) async {
    try {
      var dio = Dio();
      String url = _getUrl(SHITAMI_MENU);
      FormData formData = FormData.fromMap(
        await _getData(
          JYUCYU_ID: JYUCYU_ID,
          SHITAMI_MENU: SHITAMI_MENU,
          FILE_PATH: FILE_PATH,
          MTMORI_YMD: MTMORI_YMD,
          CANCEL_RIYU: CANCEL_RIYU,
        ),
      );

      var response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        onSuccess.call();
      } else if (response.statusCode == 400) {
        final errorMessage = jsonDecode(response.data)['0'];
        onFailed.call(errorMessage);
      }
    } catch (e) {
      onFailed.call("Update image failed");
    }
  }

  String _getUrl(String SHITAMI_MENU) {
    String domain = "https://koji-app.starboardasiavn.com/";
    switch (SHITAMI_MENU) {
      case '1':
        return '${domain}requestPhotoSubmissionRegistrationFromSendPhoto.php';
      case '2':
        return '${domain}requestPhotoSubmissionRegistrationFromReportDelayed.php';
      case '3':
        return "https://koji-app.starboardasiavn.com/requestPhotoSubmissionRegistrationFromCancel.php";
      case '4':
        return '${domain}requestPhotoSubmissionRegistrationFromReportNoQuoation.php';
      default:
        return '';
    }
  }

  Future<Map<String, dynamic>> _getData(
      {required String JYUCYU_ID,
      required String SHITAMI_MENU,
      required String FILE_PATH,
      String? MTMORI_YMD,
      String? CANCEL_RIYU}) async {
    switch (SHITAMI_MENU) {
      case '1':
        return {
          'FILE_IMAGE': await MultipartFile.fromFile(FILE_PATH),
          'JYUCYU_ID': '0301447771',
          'SHITAMI_MENU': '1',
        };
      case '2':
        return {
          'FILE_IMAGE': await MultipartFile.fromFile(FILE_PATH),
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
          'MTMORI_YMD': MTMORI_YMD?.split(" ").first,
          'CANCEL_RIYU': CANCEL_RIYU
        };
      case '3':
        return {
          'FILE_IMAGE': await MultipartFile.fromFile(FILE_PATH),
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
          'CANCEL_RIYU': CANCEL_RIYU
        };
      case '4':
        return {
          'FILE_IMAGE': await MultipartFile.fromFile(FILE_PATH),
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
        };
      default:
        return {
          'FILE_IMAGE': await MultipartFile.fromFile(FILE_PATH),
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
        };
    }
  }
}
