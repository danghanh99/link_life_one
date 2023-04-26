import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:link_life_one/local_storage_services/file_controller.dart';
import 'package:link_life_one/local_storage_services/id_name_controller.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';

import '../../../constants/constant.dart';

class UploadPhotoApi {
  UploadPhotoApi() : super();

  Future<void> _notSuccess({
    required jyucyuId,
    required loginId,
    required homonSbt,
    required List<String> filePathList,
    required Function onFailed,
    required Function onSuccess,
  }) async {

    List<String> paths = [];
    //STORAGE FILES
    paths = await Future.wait(filePathList.map((fp)async{
      return await FileController().copyFile(
          file: File(fp),
          isNew: true,
          onFailed: (){
            onFailed.call();
          }
      );
    }).toList());

    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().postPhotoSubmissionRegistration(
          jyucyuId: jyucyuId,
          loginId: loginId,
          homonSbt: homonSbt,
          filePathList: paths
      );
      onSuccess.call();
      return res;
    }
    else{
      onFailed.call();
    }
  }

  Future<void> uploadPhotoApi({
    required String JYUCYU_ID,
    required String LOGIN_ID,
    required String HOMON_SBT,
    required List<String> FILE_PATH_LIST,
    required Function onFailed,
    required Function onSuccess,
  }) async {

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      return _notSuccess(
          jyucyuId: JYUCYU_ID,
          loginId: LOGIN_ID,
          homonSbt: HOMON_SBT,
          filePathList: FILE_PATH_LIST,
          onFailed: onFailed,
          onSuccess: onSuccess
      );
    }

    try {
      var dio = Dio();
      List<MultipartFile> files = [];
      for (var path in FILE_PATH_LIST) {
        ImageProperties properties =
            await FlutterNativeImage.getImageProperties(path);
        int propWidth = properties.width ?? 1;
        int propHeight = properties.height ?? 1;
        File compressedFile = await FlutterNativeImage.compressImage(
          path,
          quality: 80,
          targetWidth: Constant.compressTargetWidth,
          targetHeight:
              (propHeight * Constant.compressTargetWidth / propWidth).round(),
        );
        MultipartFile file = await MultipartFile.fromFile(compressedFile.path);
        files.add(file);
      }
      String url =
          "${Constant.url}Request/Koji/requestPostPhotoSubmissionRegistration.php";
      FormData formData = FormData.fromMap(
        {
          'FILE_NAME_LIST[]': files,
          'JYUCYU_ID': JYUCYU_ID,
          'HOMON_SBT': HOMON_SBT,
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
