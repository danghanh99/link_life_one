import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';

import '../../constants/constant.dart';
import '../../models/consent.dart';
import '../base/rest_api.dart';

class SubmitLastPage {
  static final SubmitLastPage _instance = SubmitLastPage._internal();
  static SubmitLastPage get shared => _instance;
  SubmitLastPage._internal();

  Future<void> submitLastPage(
      {required String SINGLE_SUMMARIZE,
      required String JYUCYU_ID,
      required String CHECK_FLG1,
      required String CHECK_FLG2,
      required String CHECK_FLG3,
      required String CHECK_FLG4,
      required String CHECK_FLG5,
      required String CHECK_FLG6,
      required String CHECK_FLG7,
      required List<Map<String, dynamic>> list,
      required Function onSuccess,
      required onFailed}) async {
    try {
      List<TableDetailModel> tableList = [];

      if (list.isNotEmpty) {
        for (var element in list) {
          tableList.add(TableDetailModel.fromJson(element));
        }
      }

      String url = "${Constant.url}Request/Koji/requestConsent.php";
      ConsentModel consentModel = ConsentModel(
          singleSummarize: SINGLE_SUMMARIZE,
          jyucyuId: JYUCYU_ID,
          biko: '',
          kensetukeitai: '',
          befSekoPhotoFilePath: '',
          aftSekoPhotoFilePath: '',
          otherSekoPhotoFilePath: '',
          checkFlagList: [
            CheckFlagList(
              checkFlag1: CHECK_FLG1,
              checkFlag2: CHECK_FLG2,
              checkFlag3: CHECK_FLG3,
              checkFlag4: CHECK_FLG4,
              checkFlag5: CHECK_FLG5,
              checkFlag6: CHECK_FLG6,
              checkFlag7: CHECK_FLG7,
            )
          ],
          tableDetails: tableList);
      final Response response =
          await RestAPI.shared.postData(url, consentModel.toJson());

      if (response.statusCode == 200) {
        onSuccess.call();
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }

  void openBox(Function(Box<String>) onsuccess) async {
    final box = await Hive.openBox<String>('user');

    if (box.isOpen) {
      onsuccess.call(box);
    }
  }

  Future<void> uploadSignImage(
      {required String jyucyuId,
      required File file,
      required Function() onSuccess,
      required Function() onFailed}) async {
    String urlEndpoint = Constant.requestPostUploadRegisterSignImage;
    MultipartFile multipartFile = MultipartFile.fromFileSync(file.path);

    Map<String, dynamic> body = {
      'JYUCYU_ID': jyucyuId,
      'FILE_NAME': multipartFile,
    };

    final Response response =
        await RestAPI.shared.postDataWithFormData(urlEndpoint, body);

    if (response.statusCode == 200) {
      onSuccess();
    } else {
      onFailed();
    }
    return;
  }
}
