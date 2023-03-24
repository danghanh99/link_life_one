import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/constant.dart';
import '../../models/koji_houkoku_model.dart';
import '../base/rest_api.dart';

class RequestCorporateCompletion {
  RequestCorporateCompletion() : super();

  Future<void> requestCorporateCompletion(
      {required String JYUCYU_ID,
      required List<KojiHoukokuModel> kojiHoukokuList,
      required List<String> filePathList,
      required Function onSuccess,
      required Function onFailed}) async {
    try {
      String url = '${Constant.url}Request/Koji/requestCorporateCompletion.php';

      final box = await Hive.openBox<String>('user');
      String loginID = box.values.last;

      List<Map<String, dynamic>> listKojiHoukoku = [];
      for (var element in kojiHoukokuList) {
        if (element.isEmpty) {
          continue;
        }
        Map<String, dynamic> jsonElement = element.toJson();
        if (!isNetworkPath(jsonElement['BEF_SEKO_PHOTO_FILEPATH']) && jsonElement['BEF_SEKO_PHOTO_FILEPATH'] != '') {
          File imageFile = File(jsonElement['BEF_SEKO_PHOTO_FILEPATH']);
          List<int> imageBytes = imageFile.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          jsonElement['BEF_SEKO_PHOTO_FILEPATH'] = base64Image;
        }
        if (!isNetworkPath(jsonElement['AFT_SEKO_PHOTO_FILEPATH']) && jsonElement['AFT_SEKO_PHOTO_FILEPATH'] != '') {
          File imageFile = File(jsonElement['AFT_SEKO_PHOTO_FILEPATH']);
          List<int> imageBytes = imageFile.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          jsonElement['AFT_SEKO_PHOTO_FILEPATH'] = base64Image;
        }
        listKojiHoukoku.add(jsonElement);
      }

      Map<String, dynamic> parameters = {
        'JYUCYU_ID': JYUCYU_ID,
        'LOGIN_ID': loginID,
        'FILE_IMAGE': filePathList.map((e) {
          File imageFile = File(e);
          List<int> imageBytes = imageFile.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          return {'IMG_BASE64': base64Image};
        }).toList(),
        'KOJIMSAI_IMG': listKojiHoukoku
      };
      final Response response = await RestAPI.shared.postData(url, parameters);

      if (response.statusCode == 200) {
        onSuccess.call();
      } else if (response.statusCode == 400) {
        onFailed.call();
      }
    } catch (e) {
      onFailed();
    }
  }

  bool isNetworkPath(String path) {
    final uri = Uri.parse(path);
    return uri.scheme.startsWith('http') || uri.scheme.startsWith('ftp');
  }
}
