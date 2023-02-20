import 'package:dio/dio.dart';

import '../../../constants/constant.dart';

class UploadPhotoApi {
  UploadPhotoApi() : super();

  Future<void> uploadPhotoApi({
    required String JYUCYU_ID,
    required String LOGIN_ID,
    required List<String> FILE_PATH_LIST,
    required Function onFailed,
    required Function onSuccess,
  }) async {
    try {
      var dio = Dio();
      List<MultipartFile> files = [];
      for (var path in FILE_PATH_LIST) {
        MultipartFile file = await MultipartFile.fromFile(path);
        files.add(file);
      }
      String url =
          "${Constant.url}Request/Koji/requestPostPhotoSubmissionRegistration.php";
      FormData formData = FormData.fromMap(
        {
          'FILE_NAME_LIST': files,
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
