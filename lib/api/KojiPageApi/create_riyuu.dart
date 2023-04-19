import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_life_one/local_storage_services/file_controller.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';

import '../../constants/constant.dart';

class CreateRiyuu {
  CreateRiyuu() : super();

  Future<dynamic> _notSuccess({
    required jyucyuId,
    required shitamiMenu,
    required loginId,
    required List<String> filePaths,
    String? mtMoriYmd,
    String? cancelRiyu,
    required Function() onSuccess,
    required Function(String? errorMessage) onFailed
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){


      List<String> paths = [];
      for(var p in filePaths){
        paths.add(await FileController().copyFile(file: File(p), onFailed: onFailed));
      }

      if(shitamiMenu==1){
        await LocalStorageServices().photoSubmissionRegistrationFromSendPhoto(
            loginId: loginId,
            filePaths: paths,
            jyucyuId: jyucyuId
        );
      }
      else if(shitamiMenu==2){
        await LocalStorageServices().photoSubmissionRegistrationFromReportDelayed(
            loginId: loginId,
            filePaths: paths,
            jyucyuId: jyucyuId,
            mtMoriYmd: mtMoriYmd,
            cancelRiyu: cancelRiyu
        );
      }
      else if(shitamiMenu==3){
        await LocalStorageServices().photoSubmissionRegistrationFromCancel(
            loginId: loginId,
            filePaths: paths,
            jyucyuId: jyucyuId,
            cancelRiyu: cancelRiyu
        );
      }
      else if(shitamiMenu==4){
        await LocalStorageServices().photoSubmissionRegistrationFromReportNoQuoation(
            loginId: loginId,
            filePaths: paths,
            jyucyuId: jyucyuId
        );
      }
      onSuccess.call();
    }
    else{
      onFailed.call('画像アップロードが失敗しました。');
    }
  }

  Future<dynamic> createRiyuu({
    required String JYUCYU_ID,
    required String SHITAMI_MENU,
    required List<String> FILE_PATH_LIST,
    String? MTMORI_YMD,
    String? CANCEL_RIYU,
    required Function() onSuccess,
    required Function(String? errorMessage) onFailed,
  }) async {

    final box = await Hive.openBox<String>('user');
    String loginID = box.values.last;

    try {

      var dio = Dio();
      String url = _getUrl(SHITAMI_MENU);
      FormData formData = FormData.fromMap(
        await _getData(
          JYUCYU_ID: JYUCYU_ID,
          loginId: loginID,
          SHITAMI_MENU: SHITAMI_MENU,
          FILE_PATH_LIST: FILE_PATH_LIST,
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
      else{
        await _notSuccess(
            jyucyuId: JYUCYU_ID,
            shitamiMenu: SHITAMI_MENU,
            loginId: loginID,
            filePaths: FILE_PATH_LIST,
            onSuccess: onSuccess,
            onFailed: onFailed
        );
      }
    } catch (e) {
      await _notSuccess(
          jyucyuId: JYUCYU_ID,
          shitamiMenu: SHITAMI_MENU,
          loginId: loginID,
          filePaths: FILE_PATH_LIST,
          onSuccess: onSuccess,
          onFailed: onFailed
      );
    }
  }

  String _getUrl(String SHITAMI_MENU) {
    String domain = "${Constant.url}Request/Koji/";
    switch (SHITAMI_MENU) {
      case '1':
        return '${domain}requestPhotoSubmissionRegistrationFromSendPhoto.php';
      case '2':
        return '${domain}requestPhotoSubmissionRegistrationFromReportDelayed.php';
      case '3':
        return "${domain}requestPhotoSubmissionRegistrationFromCancel.php";
      case '4':
        return '${domain}requestPhotoSubmissionRegistrationFromReportNoQuoation.php';
      default:
        return '';
    }
  }

  Future<Map<String, dynamic>> _getData(
      {required String JYUCYU_ID,
      required String loginId,
      required String SHITAMI_MENU,
      required List<String> FILE_PATH_LIST,
      String? MTMORI_YMD,
      String? CANCEL_RIYU}) async {
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
    switch (SHITAMI_MENU) {
      case '1':
        return {
          'LOGIN_ID': loginId,
          'FILE_IMAGE_LIST[]': files,
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': '1',
        };
      case '2':
        return {
          'LOGIN_ID': loginId,
          'FILE_IMAGE_LIST[]': files,
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
          'MTMORI_YMD': MTMORI_YMD?.split(" ").first,
          'CANCEL_RIYU': CANCEL_RIYU
        };
      case '3':
        return {
          'LOGIN_ID': loginId,
          'FILE_IMAGE_LIST[]': files,
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
          'CANCEL_RIYU': CANCEL_RIYU
        };
      case '4':
        return {
          'LOGIN_ID': loginId,
          'FILE_IMAGE_LIST[]': files,
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
        };
      default:
        return {
          'LOGIN_ID': loginId,
          'FILE_IMAGE_LIST[]': files,
          'JYUCYU_ID': JYUCYU_ID,
          'SHITAMI_MENU': SHITAMI_MENU,
        };
    }
  }
}
