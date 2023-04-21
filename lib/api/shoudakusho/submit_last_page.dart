import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:link_life_one/local_storage_services/file_controller.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';

import '../../constants/constant.dart';
import '../../models/consent.dart';
import '../../models/koji_houkoku_model.dart';
import '../base/rest_api.dart';

class SubmitLastPage {
  static final SubmitLastPage _instance = SubmitLastPage._internal();
  static SubmitLastPage get shared => _instance;
  SubmitLastPage._internal();

  Future<void> _submitNotSuccess({
    required String singleSummarize,
    required String jyucyuId,
    required String checkFlg1,
    required String checkFlg2,
    required String checkFlg3,
    required String checkFlg4,
    required String checkFlg5,
    required String checkFlg6,
    required String checkFlg7,
    required String biko,
    required List<KojiHoukokuModel> kojiHoukoku,
    required List<TableDetailModel> tableList,
    required loginId,
    required Function onSuccess,
    required Function() onFailed
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){

      var res = await LocalStorageServices().localSubmitLastPage(
          loginId: loginId,
          singleSummarize: singleSummarize,
          jyucyuId: jyucyuId,
          checkFlg1: checkFlg1,
          checkFlg2: checkFlg2,
          checkFlg3: checkFlg3,
          checkFlg4: checkFlg4,
          checkFlg5: checkFlg5,
          checkFlg6: checkFlg6,
          checkFlg7: checkFlg7,
          biko: biko,
          kojiHoukoku: kojiHoukoku,
          tableList: tableList
      );
      onSuccess.call();

    }
    else{
      onFailed.call();
    }
  }

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
      required String biko,
      required List<KojiHoukokuModel> kojiHoukoku,
      required List<Map<String, dynamic>> list,
      required Function onSuccess,
      required Function(String) onFailed}) async {

    List<TableDetailModel> tableList = [];

    if (list.isNotEmpty) {
      for (var element in list) {
        tableList.add(TableDetailModel.fromJson(element));
      }
    }

    String url = "${Constant.url}Request/Koji/requestConsent.php";
    final box = await Hive.openBox<String>('user');
    String loginID = box.values.last;

    if(LocalStorageNotifier.isOfflineMode && LocalStorageNotifier.isChoosenToday){
      await _submitNotSuccess(
          singleSummarize: SINGLE_SUMMARIZE,
          jyucyuId: JYUCYU_ID,
          checkFlg1: CHECK_FLG1,
          checkFlg2: CHECK_FLG2,
          checkFlg3: CHECK_FLG3,
          checkFlg4: CHECK_FLG4,
          checkFlg5: CHECK_FLG5,
          checkFlg6: CHECK_FLG6,
          checkFlg7: CHECK_FLG7,
          biko: biko,
          kojiHoukoku: kojiHoukoku,
          tableList: tableList,
          loginId: loginID,
          onSuccess: onSuccess,
          onFailed: (){
            onFailed('');
          }
      );
      return;
    }

    try {

      ConsentModel consentModel = ConsentModel(
          singleSummarize: SINGLE_SUMMARIZE,
          loginId: loginID,
          jyucyuId: JYUCYU_ID,
          biko: biko,
          kensetukeitai: '',
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
          tableDetails: tableList,
          kojiHoukoku: kojiHoukoku);
      final Response response =
          await RestAPI.shared.postData(url, consentModel.toJson());

      if (response.statusCode == 200) {
        dynamic data = response.data;
        if (data is Map && data['msg'] != null) {
          String msg = data['msg'].first;
          onFailed(msg);
        } else {
          onSuccess();
        }
      }
    } catch (e) {
      onFailed.call('$e');
    }
  }

  void openBox(Function(Box<String>) onsuccess) async {
    final box = await Hive.openBox<String>('user');

    if (box.isOpen) {
      onsuccess.call(box);
    }
  }

  Future<dynamic> _notSuccess({
    required String jyucyuId,
    required File file,
    required loginId,
    required Function() onSuccess,
    required Function() onFailed
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().postUploadRegisterSignImage(
          jyucyuId: jyucyuId,
          file: file,
          loginId: loginId
      );
      onSuccess.call();
      return res;
    }
    else{
      onFailed.call();
    }
  }

  Future<void> uploadSignImage(
      {required String jyucyuId,
      required File file,
      required Function() onSuccess,
      required Function() onFailed}) async {

    final box = await Hive.openBox<String>('user');
    String loginID = box.values.last;

    if(LocalStorageNotifier.isOfflineMode && LocalStorageNotifier.isChoosenToday){
      return _notSuccess(
          jyucyuId: jyucyuId,
          file: file,
          loginId: loginID,
          onSuccess: onSuccess,
          onFailed: onFailed
      );
    }

    try{

      String urlEndpoint = Constant.requestPostUploadRegisterSignImage;
      MultipartFile multipartFile = MultipartFile.fromFileSync(file.path);

      Map<String, dynamic> body = {
        'JYUCYU_ID': jyucyuId,
        'FILE_NAME': multipartFile,
        'LOGIN_ID': loginID
      };

      final Response response =
      await RestAPI.shared.postDataWithFormData(urlEndpoint, body);

      if (response.statusCode == 200) {
        onSuccess();
      } else {
        onFailed.call();
      }

    }
    catch(e){
      onFailed.call();
    }

  }
}
