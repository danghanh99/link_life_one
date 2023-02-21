
import 'package:dio/dio.dart';

import '../../constants/constant.dart';

class RequestCorporateCompletion {
  RequestCorporateCompletion() : super();

  Future<void> requestCorporateCompletion(
      {required String JYUCYU_ID,
      required List<String> filePathList,
      required Function onSuccess,
      required Function onFailed}) async {
    try {
      List<MultipartFile> files = [];
      for (var path in filePathList) {
        MultipartFile file = await MultipartFile.fromFile(path);
        files.add(file);
      }

      var dio = Dio();
      String url = '${Constant.url}Request/Koji/requestCorporateCompletion.php';
      FormData formData = FormData.fromMap(
        {
          'JYUCYU_ID': JYUCYU_ID,
          'FILE_PATH_LIST': files,
        },
      );

      var response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        onSuccess.call();
      } else if (response.statusCode == 400) {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call('画像アップロードが失敗しました。');
    }
  }
}
