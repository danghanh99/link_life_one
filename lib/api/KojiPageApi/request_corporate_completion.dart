import 'package:dio/dio.dart';

import '../../constants/constant.dart';

class RequestCorporateCompletion {
  RequestCorporateCompletion() : super();

  Future<void> requestCorporateCompletion(
      {required String JYUCYU_ID,
      String? befImagePath,
      String? aftImagePath,
      required List<String> filePathList,
      required Function onSuccess,
      required Function onFailed}) async {
    try {
      List<MultipartFile> files = [];
      for (var path in filePathList) {
        MultipartFile file = await MultipartFile.fromFile(path);
        files.add(file);
      }
      MultipartFile? befFile;
      MultipartFile? aftFile;
      if (befImagePath != null) {
        befFile = await MultipartFile.fromFile(befImagePath);
      }
      if (aftImagePath != null) {
        aftFile = await MultipartFile.fromFile(aftImagePath);
      }

      var dio = Dio();
      String url = '${Constant.url}Request/Koji/requestCorporateCompletion.php';
      FormData formData = FormData.fromMap(
        {
          'JYUCYU_ID': JYUCYU_ID,
          'BEF_SEKO_PHOTO_FILEPATH': befFile,
          'AFT_SEKO_PHOTO_FILEPATH': aftFile,
          'OTHER_PHOTO_FOLDERPATH': null,
          'FILE_IMAGE': files,
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
      onFailed();
    }
  }
}
