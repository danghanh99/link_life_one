import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/constant.dart';

class CreateRiyuu {
  CreateRiyuu() : super();

  Future<dynamic> createRiyuu({
    required String JYUCYU_ID,
    required String SHITAMI_MENU,
    required List<String> FILE_PATH_LIST,
    String? MTMORI_YMD,
    String? CANCEL_RIYU,
    required Function() onSuccess,
    required Function(String? errorMessage) onFailed,
  }) async {
    try {
      final box = await Hive.openBox<String>('user');
      String loginID = box.values.last;
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
    } catch (e) {
      onFailed.call('画像アップロードが失敗しました。');
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
