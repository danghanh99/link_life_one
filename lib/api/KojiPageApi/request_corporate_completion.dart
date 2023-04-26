import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:link_life_one/local_storage_services/file_controller.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';

import '../../constants/constant.dart';
import '../../models/koji_houkoku_model.dart';
import '../base/rest_api.dart';

class RequestCorporateCompletion {
  RequestCorporateCompletion() : super();

  Future<void> _submitNotSuccess({
    required String jyucyuId,
    required List<KojiHoukokuModel> kojiHoukokuList,
    required List<String> filePathList,
    required loginId,
    required Function onSuccess,
    required Function onFailed
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){

      List<String> paths = [];
      for(var p in filePathList){
        paths.add(await FileController().copyFile(file: File(p), isNew: true, onFailed: onFailed));
      }

      var res = await LocalStorageServices().localCorporateCompletion(
          jyucyuId: jyucyuId,
          loginId: loginId,
          kojiHoukokuList: kojiHoukokuList,
          filePathList: paths
      );
      onSuccess.call();

    }
    else{
      onFailed.call();
    }
  }

  Future<void> requestCorporateCompletion(
      {required String JYUCYU_ID,
      required List<KojiHoukokuModel> kojiHoukokuList,
      required List<String> filePathList,
      required Function onSuccess,
      required Function onFailed}) async {

    final box = await Hive.openBox<String>('user');
    String loginID = box.values.last;

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      await _submitNotSuccess(
          jyucyuId: JYUCYU_ID,
          kojiHoukokuList: kojiHoukokuList,
          filePathList: filePathList,
          loginId: loginID,
          onSuccess: onSuccess,
          onFailed: onFailed
      );
      return;
    }

    try {
      String url = '${Constant.url}Request/Koji/requestCorporateCompletion.php';

      List<Map<String, dynamic>> listKojiHoukoku = [];
      for (var element in kojiHoukokuList) {
        if (element.isEmpty) {
          continue;
        }
        Map<String, dynamic> jsonElement = element.toJson();
        String befPath = jsonElement['BEF_SEKO_PHOTO_FILEPATH'];
        if (!isNetworkPath(befPath) && befPath != '') {
          jsonElement['BEF_SEKO_PHOTO_FILEPATH'] = base64String(befPath);
        }
        String aftPath = jsonElement['AFT_SEKO_PHOTO_FILEPATH'];
        if (!isNetworkPath(aftPath) && aftPath != '') {
          jsonElement['AFT_SEKO_PHOTO_FILEPATH'] = base64String(aftPath);
        }
        List<String> otherImages = jsonElement['OTHER_PHOTO_FOLDERPATH'];
        for (var i = 0; i < otherImages.length; i++) {
          String item = otherImages.elementAt(i);
          if (!isNetworkPath(item) && item.isNotEmpty) {
            otherImages[i] = base64String(item);
          }
        }
        jsonElement['OTHER_PHOTO_FOLDERPATH'] = otherImages;
        listKojiHoukoku.add(jsonElement);
      }

      Map<String, dynamic> parameters = {
        'JYUCYU_ID': JYUCYU_ID,
        'LOGIN_ID': loginID,
        'FILE_IMAGE': filePathList.map((e) {
          File imageFile = File(e);
          List<int> imageBytes = imageFile.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          return base64Image;
        }).toList(),
        'KOJI_HOUKOKU': listKojiHoukoku
      };

      final Response response = await RestAPI.shared.postData(url, parameters);

      if (response.statusCode == 200) {
        onSuccess.call();
      } else if (response.statusCode == 400) {
        onFailed.call();
      } else{
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }

  String base64String(String filePath) {
    File imageFile = File(filePath);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  bool isNetworkPath(String path) {
    final uri = Uri.parse(path);
    return uri.scheme.startsWith('http') || uri.scheme.startsWith('ftp');
  }
}
