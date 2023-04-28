import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/local_storages/download_offline_api.dart';
import 'package:link_life_one/constants/constant.dart';
import 'package:link_life_one/local_storage_services/file_controller.dart';
import 'package:link_life_one/local_storage_services/id_name_controller.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
import 'package:link_life_one/models/consent.dart';
import 'package:link_life_one/models/koji_houkoku_model.dart';
import 'package:link_life_one/models/local_storage/m_gyosya.dart';
import 'package:link_life_one/models/local_storage/m_kbn.dart';
import 'package:link_life_one/models/local_storage/m_syohin.dart';
import 'package:link_life_one/models/local_storage/m_tant.dart';
import 'package:link_life_one/models/local_storage/t_koji.dart';
import 'package:link_life_one/models/local_storage/t_koji_check.dart';
import 'package:link_life_one/models/local_storage/t_koji_file_path.dart';
import 'package:link_life_one/models/local_storage/t_kojimsai.dart';
import 'package:link_life_one/models/local_storage/t_tirasi.dart';
import 'package:link_life_one/models/pdf_file.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageServices{

  Future<void> downloadDB({required Function(double) onProgress}) async {

    int progressTasks = 1;
    int progress = 0;

    await DownloadOfflineAPI().getDB(
        onSuccess: (Map<String, dynamic> response)async{

          final dir = Directory('${(await getApplicationDocumentsDirectory()).path}${Platform.pathSeparator}Document');
          if(await dir.exists()) {
            dir.deleteSync(recursive: true);
          }

          List mGyosya = response['M_GYOSYA'];
          List mSyohin = response['M_SYOHIN'];
          List mTant = response['M_TANT'];
          List mKbn = response['M_KBN'];
          List tKoji = response['T_KOJI'];
          List tKojimasai = response['T_KOJIMSAI'];
          List tKojiCheck = response['T_KOJI_CHECK'];
          List tKojiFilePath = response['T_KOJI_FILEPATH'];
          List tTirasi = response['T_TIRASI'];

          progressTasks += mGyosya.length+mSyohin.length+mTant.length+mKbn.length+tKoji.length+tKojimasai.length+tKojiCheck.length+tKojiFilePath.length+tTirasi.length;

          progress = 1;
          onProgress(progress/progressTasks);
          print('start get gyosya');
          //Gyosya Storage
          await LocalStorageBase.clear(boxName: boxGyosyaName);
          for(var r in response['M_GYOSYA']){
            MGyosya mGyosya = MGyosya.fromJson(r);
            await LocalStorageBase.add(
                boxName: boxGyosyaName,
                key: mGyosya.kojiGyosyaCd,
                model: mGyosya
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get syohin');
          //Syohin Storage
          await LocalStorageBase.clear(boxName: boxSyohinName);
          for(var r in response['M_SYOHIN']){
            MSyohin mSyohin = MSyohin.fromJson(r);
            await LocalStorageBase.add(
                boxName: boxSyohinName,
                key: mSyohin.jisyaCd,
                model: mSyohin
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get tant');
          //Tant Storage
          await LocalStorageBase.clear(boxName: boxTantName);
          for(var r in response['M_TANT']){
            MTant mTant = MTant.fromJson(r);
            await LocalStorageBase.add(
                boxName: boxTantName,
                key: mTant.tantCd,
                model: mTant
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get kbn');
          //Kbn Storage
          await LocalStorageBase.clear(boxName: boxKbnName);
          for(var r in response['M_KBN']){
            MKBN mKbn = MKBN.fromJson(r);
            await LocalStorageBase.add(
                boxName: boxKbnName,
                key: '${mKbn.kbnCd}_${mKbn.kbnmsaiCd}',
                model: mKbn
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get koji');
          //Koji Storage
          await LocalStorageBase.clear(boxName: boxKojiName);
          // List tKojiList = response['T_KOJI'];
          // Future.wait(
          //   tKojiList.map<Future>((r)async{
          //     TKoji tKoji = TKoji.fromRequest(r);
          //     tKoji.storage(
          //       localKojiiraisyoFilePath: await _storageLocalDirectory(r, 'KOJIIRAISYO_FILEPATH'),
          //       localSitamiiraisyoFilePath: await _storageLocalDirectory(r, 'SITAMIIRAISYO_FILEPATH')
          //     );
          //     await LocalStorageBase.add(
          //         boxName: boxKojiName,
          //         key: tKoji.jyucyuId,
          //         model: tKoji
          //     );
          //     progress += 1;
          //     onProgress(progress/progressTasks);
          //   }).toList()
          // );
          for(var r in response['T_KOJI']){
            TKoji tKoji = TKoji.fromRequest(r);
            tKoji.storage(
              localKojiiraisyoFilePath: await _storageLocalDirectory(r, 'KOJIIRAISYO_FILEPATH'),
              localSitamiiraisyoFilePath: await _storageLocalDirectory(r, 'SITAMIIRAISYO_FILEPATH')
            );
            tKoji.origin(
              kojiiraisyoFilePath: r['KOJIIRAISYO_FILEPATH'],
              sitamiiraisyoFilePath: r['SITAMIIRAISYO_FILEPATH']
            );
            await LocalStorageBase.add(
                boxName: boxKojiName,
                key: tKoji.jyucyuId,
                model: tKoji
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get kojimsai');
          //Kojimsai Storage
          await LocalStorageBase.clear(boxName: boxKojimsaiName);
          for(var r in response['T_KOJIMSAI']){
            TKojimsai tKojimsai = TKojimsai.fromRequest(r);
            print('jyucyuId: ${tKojimsai.jyucyuId}');
            // print('storage: ${await _storageLocalDirectory(r, 'BEF_SEKO_PHOTO_FILEPATH')}');
            // print('storage: ${await _storageLocalDirectory(r, 'AFT_SEKO_PHOTO_FILEPATH')}');
            // print('storage: ${await _storageLocalDirectoryList(r['OTHER_PHOTO_FOLDERPATH'])}');
            tKojimsai.storage(
              localBefSekoPhotoFilePath: await _storageLocalDirectory(r, 'BEF_SEKO_PHOTO_FILEPATH'),
              localAftSekoPhotoFilePath: await _storageLocalDirectory(r, 'AFT_SEKO_PHOTO_FILEPATH'),
              localOtherSekoPhotoFilePath: await _storageLocalDirectoryList(r['OTHER_PHOTO_FOLDERPATH'])
            );
            tKojimsai.origin(
              befSekoPhotoFilePath: r['BEF_SEKO_PHOTO_FILEPATH'],
              aftSekoPhotoFilePath: r['AFT_SEKO_PHOTO_FILEPATH'],
              otherSekoPhotoFilePath: r['OTHER_PHOTO_FOLDERPATH']
            );
            // tKojimsai.storage(
            //   localBefSekoPhotoFilePath: null,
            //   localAftSekoPhotoFilePath: null,
            //   localOtherSekoPhotoFilePath: null
            // );
            await LocalStorageBase.add(
                boxName: boxKojimsaiName,
                key: '${tKojimsai.jyucyuId}_${tKojimsai.jyucyumsaiId}',
                model: tKojimsai
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get kojicheck');
          //KojiCheck Storage
          await LocalStorageBase.clear(boxName: boxKojiCheckName);
          for(var r in response['T_KOJI_CHECK']){
            TKojiCheck tKojiCheck = TKojiCheck.fromJson(r);
            await LocalStorageBase.add(
                boxName: boxKojiCheckName,
                key: tKojiCheck.jyucyuId,
                model: tKojiCheck
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get kojifilepath');
          //KojiFilePath Storage
          await LocalStorageBase.clear(boxName: boxKojiFilePathName);
          // List tKojiFilePathList = response['T_KOJI_FILEPATH'];
          // Future.wait(
          //     tKojiFilePathList.map<Future>((r)async{
          //       TKojiFilePath tKojiFilePath = TKojiFilePath.fromJson(r);
          //       tKojiFilePath.storage(await _storageLocalDirectory(r, 'FILEPATH'));
          //       await LocalStorageBase.add(
          //           boxName: boxKojiFilePathName,
          //           key: tKojiFilePath.filePathId,
          //           model: tKojiFilePath
          //       );
          //       progress += 1;
          //       onProgress(progress/progressTasks);
          //     }).toList()
          // );
          for(var r in response['T_KOJI_FILEPATH']){
            TKojiFilePath tKojiFilePath = TKojiFilePath.fromJson(r);
            tKojiFilePath.storage(await _storageLocalDirectory(r, 'FILEPATH'));
            tKojiFilePath.origin(r['FILEPATH']);
            await LocalStorageBase.add(
                boxName: boxKojiFilePathName,
                key: tKojiFilePath.filePathId,
                model: tKojiFilePath
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }
          print('start get tirasi');
          //Tirasi Storage
          await LocalStorageBase.clear(boxName: boxTirasiName);
          for(var r in response['T_TIRASI']){
            TTirasi tTirasi = TTirasi.fromJson(r);
            await LocalStorageBase.add(
                boxName: boxTirasiName,
                key: '${tTirasi.tantCd}_${tTirasi.YMD}',
                model: tTirasi
            );
            progress += 1;
            onProgress(progress/progressTasks);
          }

        },
        onFailed: (){}
    );
  }

  Future<Map<String, dynamic>> uploadDB({required Function(double) onProgress}) async {
    // var mGyosya = await LocalStorageBase.getValues(boxName: boxGyosyaName);
    // var mKbn = await LocalStorageBase.getValues(boxName: boxKbnName);
    // var mSyohin = await LocalStorageBase.getValues(boxName: boxSyohinName);
    // var mTant = await LocalStorageBase.getValues(boxName: boxTantName);
    var tKoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    var tKojiCheck = await LocalStorageBase.getValues(boxName: boxKojiCheckName);
    var tKojiFilePath = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);
    var tKojimsai = await LocalStorageBase.getValues(boxName: boxKojimsaiName);
    var tTirasi = await LocalStorageBase.getValues(boxName: boxTirasiName);

    Map<String, dynamic> body = {};

    List kojiChangeData = [];
    for(TKoji k in tKoji) {
      if(k.status==1){
        var chaneRecord = k.toBodyJson();

        if('${chaneRecord['JYUCYU_ID']}'.contains('temp_')){
          chaneRecord['JYUCYU_ID'] = '';
        }

        if(IdNameController().detectStateSuffix(chaneRecord['KOJIIRAISYO_FILEPATH'])>0){
          chaneRecord['KOJIIRAISYO_FILEPATH'] = await _base64String(chaneRecord['KOJIIRAISYO_FILEPATH']);
        }
        else{
          chaneRecord['KOJIIRAISYO_FILEPATH'] = k.originalKojiiraisyoFilePath;//original value
        }

        if(IdNameController().detectStateSuffix(chaneRecord['SITAMIIRAISYO_FILEPATH'])>0){
          chaneRecord['SITAMIIRAISYO_FILEPATH'] = await _base64String(chaneRecord['SITAMIIRAISYO_FILEPATH']);
        }
        else{
          chaneRecord['SITAMIIRAISYO_FILEPATH'] = k.originalSitamiiraisyoFilePath;//original value
        }

        kojiChangeData.add(chaneRecord);
      }
    }
    List kojiCheckChangeData = [];
    for(TKojiCheck kc in tKojiCheck) {
      if(kc.status==1){
        var chaneRecord = kc.toBodyJson();
        if('${chaneRecord['JYUCYU_ID']}'.contains('temp_')){
          chaneRecord['JYUCYU_ID'] = '';
        }
        kojiCheckChangeData.add(chaneRecord);
      }
    }
    List kojiFilePathChangeData = [];
    for(TKojiFilePath kf in tKojiFilePath) {
      if(kf.status==1){
        var chaneRecord = kf.toBodyJson();

        if('${chaneRecord['FILEPATH_ID']}'.contains('temp_')){
          chaneRecord['FILEPATH_ID'] = '';
        }

        if(IdNameController().detectStateSuffix(chaneRecord['FILEPATH'])>0){
          chaneRecord['FILEPATH'] = await _base64String(chaneRecord['FILEPATH']);
        }
        else{
          chaneRecord['FILEPATH'] = kf.originalPath;//original value
        }

        kojiFilePathChangeData.add(chaneRecord);
      }
    }

    List kojimsaiChangeData = [];
    for(TKojimsai km in tKojimsai) {
      if(km.status==1){
        var chaneRecord = km.toBodyJson();
        if('${chaneRecord['JYUCYUMSAI_ID']}'.contains('temp_')){
          chaneRecord['JYUCYUMSAI_ID'] = '';
        }

        if(IdNameController().detectStateSuffix(chaneRecord['BEF_SEKO_PHOTO_FILEPATH'])>0){
          chaneRecord['BEF_SEKO_PHOTO_FILEPATH'] = await _base64String(chaneRecord['BEF_SEKO_PHOTO_FILEPATH']);
        }
        else{
          chaneRecord['BEF_SEKO_PHOTO_FILEPATH'] = km.originalBefSekoPhotoFilePath;//original value
        }

        if(IdNameController().detectStateSuffix(chaneRecord['AFT_SEKO_PHOTO_FILEPATH'])>0){
          chaneRecord['AFT_SEKO_PHOTO_FILEPATH'] = await _base64String(chaneRecord['AFT_SEKO_PHOTO_FILEPATH']);
        }
        else{
          chaneRecord['AFT_SEKO_PHOTO_FILEPATH'] = km.originalAftSekoPhotoFilePath;//original value
        }

        List<String> otherPhotos = [];
        dynamic others = chaneRecord['OTHER_PHOTO_FOLDERPATH'];
        if(others!=null){
          if (others.runtimeType == String) {
            otherPhotos = [others];
          }
          if (others.runtimeType == List<String>) {
            otherPhotos = others;
          }
          String otherPaths = '';
          for(String p in otherPhotos){
            if(IdNameController().detectStateSuffix(p)>0){
              otherPaths = '${otherPaths.isEmpty?'':'$otherPaths;'}${await _base64String(p)}';
            }
            else{
              otherPaths = '${otherPaths.isEmpty?'':'$otherPaths;'}${km.originalOtherSekoPhotoFilePath![otherPhotos.indexOf(p)]}';//original Value
            }
          }
          chaneRecord['OTHER_PHOTO_FOLDERPATH'] = [otherPaths];
        }

        kojimsaiChangeData.add(chaneRecord);
      }
    }

    List tirasiChangeData = [];
    for(TTirasi tr in tTirasi) {
      if(tr.status==1){
        var chaneRecord = tr.toBodyJson();
        tirasiChangeData.add(chaneRecord);
      }
    }

    body.addAll({
      'T_KOJI': kojiChangeData,
      'T_KOJIMSAI': kojimsaiChangeData,
      'T_KOJI_FILEPATH': kojiFilePathChangeData,
      'T_KOJI_CHECK': kojiCheckChangeData,
      'T_TIRASI': tirasiChangeData
    });

    return body;

  }

  Future<int> checkCount({required YMD, required setsakiAddress, required jyucyuId}) async {
    int count = 0;
    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji t in tkoji){
      if(t.kojiYMD==DateFormat('yyyy-MM-dd').format(YMD) && t.setsakiAddress==setsakiAddress && t.jyucyuId!=jyucyuId && t.delFlg==0) count++;
    }
    return count;
  }

  static Future<bool> isTodayDataDownloaded()async{
    var today = DateFormat('yyyyMMdd').format(DateTime.now());
    String? date = await LocalStorageBase.get(boxName: boxDateName, key: dateParamName);
    return date!=null && date.isNotEmpty && date==today;
  }

  Future<void> checkTodayDownloaded()async{
    var today = DateFormat('yyyyMMdd').format(DateTime.now());
    await LocalStorageBase.add(boxName: boxDateName, key: dateParamName, model: today);
  }

  Future<List<PdfFile>> getFiles({
      required jyucyuId,
      required homonSbt
  })async{

    List<PdfFile> resultList = [];

    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    var tkojiFilePath = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);
    for(TKoji t in tkoji){
      if((t.jyucyuId==jyucyuId || t.syuyakuJyucyuId==jyucyuId) && t.homonSbt=="01" && t.delFlg==0){
        resultList.add(
            PdfFile(
                kojiiraisyoFilePath: t.localSitamiiraisyoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${t.localSitamiiraisyoFilePath}':null,
                jyucyuId: t.jyucyuId,
                homonSbt: t.homonSbt,
                kojiSt: t.kojiSt
            )
        );
        for(TKojiFilePath tFP in tkojiFilePath){
          if(tFP.id==t.jyucyuId && tFP.fileKbnCd=="04" && tFP.delFlg=="0"){
            resultList.add(
                PdfFile(
                    sitamiiraisyoFilePath: tFP.localPath!=null?'${(await FileController().prepareSaveDir()).path}${tFP.localPath}':null,
                    jyucyuId: t.jyucyuId,
                    homonSbt: t.homonSbt,
                    kojiSt: t.kojiSt
                )
            );
          }
        }
      }
      else if((t.jyucyuId==jyucyuId || t.syuyakuJyucyuId==jyucyuId) && t.homonSbt=="02" && t.delFlg==0){
        resultList.add(
            PdfFile(
                kojiiraisyoFilePath: t.localKojiiraisyoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${t.localKojiiraisyoFilePath}':null,
                jyucyuId: t.jyucyuId,
                homonSbt: t.homonSbt,
                kojiSt: t.kojiSt
            )
        );
        for(TKojiFilePath tFP in tkojiFilePath){
          if(tFP.id==t.jyucyuId && tFP.fileKbnCd=="03" && tFP.delFlg=="0"){
            resultList.add(
                PdfFile(
                  kojiiraisyoFilePath: tFP.localPath!=null?'${(await FileController().prepareSaveDir()).path}${tFP.localPath}':null,
                  jyucyuId: t.jyucyuId,
                  homonSbt: t.homonSbt,
                  kojiSt: t.kojiSt
                )
            );
          }
        }
      }
    }

    return resultList;
  }

  Future<List<dynamic>> getPhotoConfirm({
    required jyucyuId
  })async{

    List<dynamic> resultList = [];

    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    var tkojiFilePath = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);
    for(TKoji t in tkoji) {
      if ((t.jyucyuId == jyucyuId || t.syuyakuJyucyuId == jyucyuId) && t.delFlg == 0) {
        for (TKojiFilePath tFP in tkojiFilePath) {
          if (tFP.id == t.jyucyuId && tFP.fileKbnCd == "05" && tFP.delFlg == "0") {
            resultList.add(
              {'FILEPATH': tFP.localPath!=null?'${(await FileController().prepareSaveDir()).path}${tFP.localPath}':null}
            );
          }
        }
      }
    }

    return resultList;
  }

  Future<dynamic> getConstructionReport({
    required jyucyuId,
    syuyakuJyucyuId,
    required kojiSt,
    required singleSummarize
  })async{

    Map<String, dynamic> resultList = {};

    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    var tkojimsai = await LocalStorageBase.getValues(boxName: boxKojimsaiName);
    var mKbn = await LocalStorageBase.getValues(boxName: boxKbnName);
    List<dynamic> pullDown = [];
    for(MKBN kbn in mKbn) {
      if (kbn.kbnCd=="07") {
        pullDown.add({
          "KBN_CD": kbn.kbnCd,
          "KBN_NAME": kbn.kbnName,
          "KBNMSAI_CD": kbn.kbnmsaiCd,
          "KBNMSAI_NAME": kbn.kbnmsaiName,
          "KBN_BIKO": kbn.kbnBiko
        });
      }
    }

    if (kojiSt == "01" || kojiSt == "02") {
      if (singleSummarize == "01") {
        List data = [];
        for(TKoji t in tkoji) {
          if (t.jyucyuId == jyucyuId && (t.kojiSt=="01" || t.kojiSt=="02") && t.delFlg == 0) {
            for (TKojimsai tKm in tkojimsai) {
              if (tKm.jyucyuId == jyucyuId && tKm.kojijituikaFlg == "0" && tKm.delFlg == "0") {
                data.add({
                  "JYUCYUMSAI_ID": tKm.jyucyumsaiId,
                  "JYUCYUMSAI_ID_KIKAN": tKm.jyucyumsaiIdKikan,
                  "HINBAN": tKm.hinban,
                  "MAKER_CD": tKm.makerCd,
                  "CTGORY_CD": tKm.ctgotyCd,
                  "SURYO": tKm.suryo,
                  "KINGAK": tKm.kingak,
                  "KISETU_HINBAN": tKm.kisetuHinban,
                  "KISETU_MAKER": tKm.kisetuMaker,
                  "KENSETU_KEITAI": tKm.kensetuKeitai,
                  "BEF_SEKO_PHOTO_FILEPATH": tKm.localBefSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localBefSekoPhotoFilePath}':null,
                  "AFT_SEKO_PHOTO_FILEPATH": tKm.localAftSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localAftSekoPhotoFilePath}':null,
                  "OTHER_PHOTO_FOLDERPATH": tKm.localOtherSekoPhotoFilePath,
                  "TUIKA_JISYA_CD": tKm.tuikaJisyaCd,
                  "TUIKA_SYOHIN_NAME": tKm.tuikaSyohinName,
                  "KOJIJITUIKA_FLG": tKm.kojijituikaFlg,
                  "KOJI_ST": t.kojiSt,
                  "HOJIN_FLG": '${t.hojinFlg}',
                  "TENPO_CD": t.tenpoCd
                });
              }
            }
          }
        }
        resultList.addAll({
          'DATA': data,
          'PULLDOWN': pullDown
        });
      } else {
        List data = [];
        for(TKoji t in tkoji) {
          if ((t.syuyakuJyucyuId == jyucyuId || t.jyucyuId == jyucyuId) && (t.kojiSt=="01" || t.kojiSt=="02") && t.delFlg == 0) {
            for (TKojimsai tKm in tkojimsai) {
              if (tKm.jyucyuId == jyucyuId && tKm.kojijituikaFlg == "0" && tKm.delFlg == "0") {
                data.add({
                  "JYUCYUMSAI_ID": tKm.jyucyumsaiId,
                  "JYUCYUMSAI_ID_KIKAN": tKm.jyucyumsaiIdKikan,
                  "HINBAN": tKm.hinban,
                  "MAKER_CD": tKm.makerCd,
                  "CTGORY_CD": tKm.ctgotyCd,
                  "SURYO": tKm.suryo,
                  "KINGAK": tKm.kingak,
                  "KISETU_HINBAN": tKm.kisetuHinban,
                  "KISETU_MAKER": tKm.kisetuMaker,
                  "KENSETU_KEITAI": tKm.kensetuKeitai,
                  "BEF_SEKO_PHOTO_FILEPATH": tKm.localBefSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localBefSekoPhotoFilePath}':null,
                  "AFT_SEKO_PHOTO_FILEPATH": tKm.localAftSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localAftSekoPhotoFilePath}':null,
                  "OTHER_PHOTO_FOLDERPATH": tKm.localOtherSekoPhotoFilePath,
                  "TUIKA_JISYA_CD": tKm.tuikaJisyaCd,
                  "TUIKA_SYOHIN_NAME": tKm.tuikaSyohinName,
                  "KOJIJITUIKA_FLG": tKm.kojijituikaFlg,
                  "KOJI_ST": t.kojiSt,
                  "HOJIN_FLG": '${t.hojinFlg}',
                  "TENPO_CD": t.tenpoCd
                });
              }
            }
          }
        }
        resultList.addAll({
          'DATA': data,
          'PULLDOWN': pullDown
        });
      }
    } else {
      if (singleSummarize == "01") {
        List data = [];
        for(TKoji t in tkoji) {
          if (t.jyucyuId == jyucyuId && t.kojiSt=="03" && t.delFlg == 0) {
            for (TKojimsai tKm in tkojimsai) {
              if (tKm.jyucyuId == jyucyuId && tKm.kojijituikaFlg == "0" && tKm.delFlg == "0") {
                data.add({
                  "JYUCYUMSAI_ID": tKm.jyucyumsaiId,
                  "JYUCYUMSAI_ID_KIKAN": tKm.jyucyumsaiIdKikan,
                  "HINBAN": tKm.hinban,
                  "MAKER_CD": tKm.makerCd,
                  "CTGORY_CD": tKm.ctgotyCd,
                  "SURYO": tKm.suryo,
                  "KINGAK": tKm.kingak,
                  "KISETU_HINBAN": tKm.kisetuHinban,
                  "KISETU_MAKER": tKm.kisetuMaker,
                  "KENSETU_KEITAI": tKm.kensetuKeitai,
                  "BEF_SEKO_PHOTO_FILEPATH": tKm.localBefSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localBefSekoPhotoFilePath}':null,
                  "AFT_SEKO_PHOTO_FILEPATH": tKm.localAftSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localAftSekoPhotoFilePath}':null,
                  "OTHER_PHOTO_FOLDERPATH": tKm.localOtherSekoPhotoFilePath,
                  "TUIKA_JISYA_CD": tKm.tuikaJisyaCd,
                  "TUIKA_SYOHIN_NAME": tKm.tuikaSyohinName,
                  "KOJIJITUIKA_FLG": tKm.kojijituikaFlg,
                  "KOJI_ST": t.kojiSt,
                  "HOJIN_FLG": '${t.hojinFlg}',
                  "TENPO_CD": t.tenpoCd
                });
              }
            }
          }
        }
        resultList.addAll({
          'DATA': data,
          'PULLDOWN': pullDown
        });
      } else {
        List data = [];
        for(TKoji t in tkoji) {
          if ((t.syuyakuJyucyuId == jyucyuId || t.jyucyuId == jyucyuId) && t.kojiSt=="03" && t.delFlg == 0) {
            for (TKojimsai tKm in tkojimsai) {
              if (tKm.jyucyuId == jyucyuId && tKm.kojijituikaFlg == "0" && tKm.delFlg == "0") {
                data.add({
                  "JYUCYUMSAI_ID": tKm.jyucyumsaiId,
                  "JYUCYUMSAI_ID_KIKAN": tKm.jyucyumsaiIdKikan,
                  "HINBAN": tKm.hinban,
                  "MAKER_CD": tKm.makerCd,
                  "CTGORY_CD": tKm.ctgotyCd,
                  "SURYO": tKm.suryo,
                  "KINGAK": tKm.kingak,
                  "KISETU_HINBAN": tKm.kisetuHinban,
                  "KISETU_MAKER": tKm.kisetuMaker,
                  "KENSETU_KEITAI": tKm.kensetuKeitai,
                  "BEF_SEKO_PHOTO_FILEPATH": tKm.localBefSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localBefSekoPhotoFilePath}':null,
                  "AFT_SEKO_PHOTO_FILEPATH": tKm.localAftSekoPhotoFilePath!=null?'${(await FileController().prepareSaveDir()).path}${tKm.localAftSekoPhotoFilePath}':null,
                  "OTHER_PHOTO_FOLDERPATH": tKm.localOtherSekoPhotoFilePath,
                  "TUIKA_JISYA_CD": tKm.tuikaJisyaCd,
                  "TUIKA_SYOHIN_NAME": tKm.tuikaSyohinName,
                  "KOJIJITUIKA_FLG": tKm.kojijituikaFlg,
                  "KOJI_ST": t.kojiSt,
                  "HOJIN_FLG": '${t.hojinFlg}',
                  "TENPO_CD": t.tenpoCd
                });
              }
            }
          }
        }
        resultList.addAll({
          'DATA': data,
          'PULLDOWN': pullDown
        });
      }
    }

    return resultList;
  }

  Future<dynamic> getWrittenConsent({
    required jyucyuId,
    required kojiSt
  })async{

    Map<String, dynamic> resultList = {};

    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    var mGyosya = await LocalStorageBase.getValues(boxName: boxGyosyaName);
    var tkojimsai = await LocalStorageBase.getValues(boxName: boxKojimsaiName);
    var msyohin = await LocalStorageBase.getValues(boxName: boxSyohinName);
    var tKojiFilePath = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);

    List<dynamic> kojiData = [];
    for(TKoji k in tkoji){
      for(MGyosya g in mGyosya){
        if(k.kojigyosyaCd==g.kojiGyosyaCd){
          if(k.jyucyuId==jyucyuId && k.hojinFlg==0 && k.delFlg==0){
            kojiData.add({
              "SETSAKI_NAME": k.setsakiName,
              "KOJI_YMD": k.kojiYMD,
              "HOMON_TANT_NAME1": k.homonTantName1,
              "HOMON_TANT_NAME2": k.homonTantName2,
              "HOMON_TANT_NAME3": k.homonTantName3,
              "HOMON_TANT_NAME4": k.homonTantName4,
              "CO_NAME": k.coName,
              "CO_POSTNO": k.coPostno,
              "CO_ADDRESS": k.coAddress,
              "CO_CD": k.coCd,
              "KOJIGYOSYA_CD": k.kojigyosyaCd,
              "KOJI_ST": k.kojiSt,
              "HOJIN_FLG": k.hojinFlg,
              "KOJIGYOSYA_NAME": g.kojiGyosyaName
            });
          }
        }
      }
    }

    List<dynamic> tableData = [];
    for(TKoji k in tkoji){
      for(TKojimsai km in tkojimsai){
        if(k.jyucyuId==km.jyucyuId){
          if(k.jyucyuId==jyucyuId && k.hojinFlg==0 && k.delFlg==0 && km.kojijituikaFlg=="1"){
            tableData.add({
              "STATUS": k.jyucyuId,
              "TUIKA_SYOHIN_NAME": km.tuikaSyohinName,
              "TUIKA_JISYA_CD": km.tuikaJisyaCd,
              "SURYO": km.suryo,
              "HANBAI_TANKA": km.hanbaiTanka,
              "KINGAK": km.kingak
            });
          }
        }
      }
    }

    List<dynamic> kojiKakaku = [];
    for(MSyohin s in msyohin){
      kojiKakaku.add(s.toJson());
    }

    bool signCheck = false;
    for(TKojiFilePath kf in tKojiFilePath){
      if(kf.id == jyucyuId && (kf.fileKbnCd == "08" || kf.fileKbnCd=="8")){
        signCheck = true;
      }
    }

    resultList.addAll({
      'KOJI_DATA': kojiData,
      'TABLE_DATA': tableData,
      'KOJI_KAKAKU': kojiKakaku,
      'CHECK_SIGN': signCheck
    });

    return resultList;
  }

  Future<dynamic> getPhotoSubmission({
    required jyucyuId,
    required kojiSt
  })async{

    if(kojiSt=="01" || kojiSt=="1" || kojiSt=="02" || kojiSt=="2"){
      throw Exception("工事報告が未報告の場合は、写真提出が不可となります。");
    }

    List resultList = [];

    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    var tkojiFilePath = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);

    for(TKoji t in tkoji) {
      if (t.jyucyuId == jyucyuId && t.kojiSt=="03" && t.delFlg == 0) {
        for (TKojiFilePath tFP in tkojiFilePath) {
          if (tFP.id == t.jyucyuId && tFP.fileKbnCd == "10" && tFP.delFlg == "0") {
            resultList.add(
                {'FILEPATH': tFP.localPath!=null?'${(await FileController().prepareSaveDir()).path}${tFP.localPath}':null}
            );
          }
        }
      }
    }

    return resultList;
  }

  Future<dynamic> getReason({
    required jyucyuId
  })async{

    List resultList = [];

    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);

    for(TKoji t in tkoji) {
      if (t.jyucyuId == jyucyuId && t.delFlg == 0) {
        resultList.add({
          "CANCEL_RIYU": t.cancelRiyu,
          "MTMORI_YMD": t.mtmoriYMD
        });
      }
    }

    return resultList;
  }

  Future<dynamic> getCorporateCompletion({
    required jyucyuId,
    required tenpoCd
  })async{

    Map<String, dynamic> resultList = {};

    var mKbn = await LocalStorageBase.getValues(boxName: boxKbnName);
    var tKojiFilePath = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);

    List kbnList = [];
    for(MKBN kbn in mKbn) {
      if (kbn.kbnCd=="12" && kbn.kbnBiko==tenpoCd && kbn.delFlg=="0") {
        kbnList.add({
          "YOBIKOMOKU1": kbn.yobikomoku1,
          "YOBIKOMOKU2": kbn.yobikomoku2,
          "YOBIKOMOKU3": kbn.yobikomoku3,
          "YOBIKOMOKU4": kbn.yobikomoku4,
          "YOBIKOMOKU5": kbn.yobikomoku5
        });
      }
    }

    List fileList = [];
    for(TKojiFilePath tFP in tKojiFilePath) {
      if (tFP.id==jyucyuId && tFP.fileKbnCd=="09" && tFP.delFlg=="0") {
        fileList.add({
          "FILEPATH": tFP.localPath!=null?'${(await FileController().prepareSaveDir()).path}${tFP.localPath}':null,
          "FILEPATH_ID": tFP.filePathId,
          "FILE_KBN_CD": tFP.fileKbnCd
        });
      }
    }

    resultList.addAll({
      'KBN': kbnList,
      'FILE': fileList
    });

    return resultList;
  }

  Future<void> postTirasiUpdate({
    required ymd,
    required loginId,
    required kojiTirasisu
  })async{

    var now = DateTime.now();

    var tTirasiList = await LocalStorageBase.getValues(boxName: boxTirasiName);
    for(TTirasi t in tTirasiList){
      if(t.tantCd == loginId && t.YMD == ymd){
        t.kojiTirasisu = int.parse('$kojiTirasisu');
        t.renkeiYMD = DateFormat('yyyy-MM-dd', 'ja').format(now).toString();
        t.delFlg = 0;
        t.addPGID = 'KOJ1120F';
        t.addTantCd = loginId;
        t.addYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        t.updPGID = 'KOJ1120F';
        t.updTantCd = loginId;
        t.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxTirasiName,
            key: '${t.tantCd}_${t.YMD}',
            model: t
        );
        return ;
      }
    }

    TTirasi tTirasi = TTirasi(
      tantCd: loginId,
      YMD: ymd,
      kojiTirasisu: int.parse('$kojiTirasisu'),
      renkeiYMD: DateFormat('yyyy-MM-dd', 'ja').format(now).toString(),
      delFlg: 0,
      addPGID: 'KOJ1120F',
      addTantCd: loginId,
      addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
      updPGID: 'KOJ1120F',
      updTantCd: loginId,
      updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
    );
    await LocalStorageBase.add(
        boxName: boxTirasiName,
        key: '${tTirasi.tantCd}_${tTirasi.YMD}',
        model: tTirasi
    );

  }

  Future<void> postUpdateSummarize({
    required ymd,
    required loginId,
    required setsakiAddress,
    required jyucyuId
  })async{

    var now = DateTime.now();

    var tKojiList = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji t in tKojiList){
      if(
        t.setsakiAddress == setsakiAddress
        && (t.kojiYMD==ymd || t.sitamiYMD==ymd)
        && t.jyucyuId != jyucyuId
        && t.delFlg == 0
      ){
        t.syuyakuJyucyuId = jyucyuId;
        t.updPGID = 'KOJ1120F';
        t.updTantCd = loginId;
        t.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: t.jyucyuId,
            model: t
        );
      }
    }

  }

  Future<void> postPhotoSubmissionRegistration({
    required jyucyuId,
    required loginId,
    required homonSbt,
    required List<String> filePathList
  })async{

    var now = DateTime.now();

    for(var p in filePathList){
      String newId = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newId,
          id: jyucyuId,
          filePath: p,
          fileKbnCd: "10",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(p);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );
    }

    var tKojiList = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji t in tKojiList){
      if(t.jyucyuId == jyucyuId){
        t.kojiKekka = homonSbt=='01' || homonSbt=='1' ? '04' : '03';
        t.kojiSt = '03';
        t.kojiRenkeiYMD = DateFormat('yyyy-MM-dd', 'ja').format(now).toString();
        t.updPGID = 'KOJ1120F';
        t.updTantCd = loginId;
        t.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: t.jyucyuId,
            model: t
        );
      }
    }

  }

  Future<void> postUploadRegisterSignImage({
    required jyucyuId,
    required file,
    required loginId
  })async{

    var now = DateTime.now();

    bool isExist = false;
    String? existFilePathId;
    var tKojiFilePathList = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);
    for(TKojiFilePath tfp in tKojiFilePathList) {
      if(tfp.id==jyucyuId) {
        isExist = true;
        existFilePathId = tfp.filePathId;
      }
    }

    if(!isExist){
      String newFilePath = await FileController().copyFile(file: file, isNew: true, onFailed: (){});
      String newId = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newId,
          id: jyucyuId,
          filePath: newFilePath,
          fileKbnCd: "08",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(newFilePath);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );

    }
    else{
      String updateFilePath = await FileController().copyFile(file: file, isNew: false, onFailed: (){});
      for(TKojiFilePath tfp in tKojiFilePathList) {
        if(tfp.filePathId==existFilePathId){
          tfp.filePath = updateFilePath;
          tfp.fileKbnCd = "08";
          tfp.delFlg = "0";
          tfp.addPGID = "KOJ1120F";
          tfp.addTantCd = loginId;
          tfp.addYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
          tfp.updPGID = "KOJ1120F";
          tfp.updTantCd = loginId;
          tfp.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
          tfp.storage(updateFilePath);
          await LocalStorageBase.add(
              boxName: boxKojiFilePathName,
              key: tfp.filePathId,
              model: tfp
          );
        }
      }

    }

  }

  Future<void> photoSubmissionRegistrationFromSendPhoto({
    required loginId,
    required filePaths,
    required jyucyuId
  })async{

    var now = DateTime.now();

    var tKojis = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji k in tKojis) {
      if(k.jyucyuId==jyucyuId){
        k.kojiRenkeiYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        k.kojiKekka = "02";
        k.kojiSt = "03";
        k.sitamiReport = 1;
        k.updPGID = "KOJ1120F";
        k.updTantCd = loginId;
        k.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: k.jyucyuId,
            model: k
        );
      }
    }
    print('filePaths: $filePaths');
    for(var p in filePaths){
      print('fp: $p');
      String newId = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newId,
          id: jyucyuId,
          filePath: p,
          fileKbnCd: "06",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(p);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );
    }

  }

  Future<void> photoSubmissionRegistrationFromReportDelayed({
    required loginId,
    required filePaths,
    required jyucyuId,
    required mtMoriYmd,
    required cancelRiyu
  })async{

    var now = DateTime.now();

    var tKojis = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji k in tKojis) {
      if(k.jyucyuId==jyucyuId){
        k.kojiRenkeiYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        k.kojiKekka = "02";
        k.kojiSt = "03";
        k.sitamiReport = 2;
        k.mtmoriYMD = mtMoriYmd;
        k.cancelRiyu = cancelRiyu;
        k.updPGID = "KOJ1120F";
        k.updTantCd = loginId;
        k.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: k.jyucyuId,
            model: k
        );
      }
    }

    for(var p in filePaths){
      String newID = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newID,
          id: jyucyuId,
          filePath: p,
          fileKbnCd: "06",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(p);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );
    }

  }

  Future<void> photoSubmissionRegistrationFromCancel({
    required loginId,
    required filePaths,
    required jyucyuId,
    required cancelRiyu
  })async{

    var now = DateTime.now();

    var tKojis = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji k in tKojis) {
      if(k.jyucyuId==jyucyuId){
        k.kojiRenkeiYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        k.kojiKekka = "04";
        k.kojiSt = "03";
        k.sitamiReport = 3;
        k.cancelRiyu = cancelRiyu;
        k.updPGID = "KOJ1120F";
        k.updTantCd = loginId;
        k.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: k.jyucyuId,
            model: k
        );
      }
    }

    for(var p in filePaths){
      String newId = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newId,
          id: jyucyuId,
          filePath: p,
          fileKbnCd: "06",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(p);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );
    }

  }

  Future<void> photoSubmissionRegistrationFromReportNoQuoation({
    required loginId,
    required filePaths,
    required jyucyuId
  })async{

    var now = DateTime.now();

    var tKojis = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji k in tKojis) {
      if(k.jyucyuId==jyucyuId){
        k.kojiRenkeiYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        k.kojiKekka = "02";
        k.kojiSt = "03";
        k.sitamiReport = 4;
        k.updPGID = "KOJ1120F";
        k.updTantCd = loginId;
        k.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: k.jyucyuId,
            model: k
        );
      }
    }

    for(var p in filePaths){
      String newId = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newId,
          id: jyucyuId,
          filePath: p,
          fileKbnCd: "06",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(p);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );
    }

  }

  Future<void> localSubmitLastPage({
    required loginId,
    required singleSummarize,
    required jyucyuId,
    required checkFlg1,
    required checkFlg2,
    required checkFlg3,
    required checkFlg4,
    required checkFlg5,
    required checkFlg6,
    required checkFlg7,
    required biko,
    required List<KojiHoukokuModel> kojiHoukoku,
    required List<TableDetailModel> tableList
  })async{

    bool isExist = false;
    var tKojiFilePathList = await LocalStorageBase.getValues(boxName: boxKojiFilePathName);
    for(TKojiFilePath tfp in tKojiFilePathList) {
      if(tfp.id==jyucyuId) {
        isExist = true;
      }
    }

    if(!isExist) return;

    var now = DateTime.now();

    //UPDATE T_KOJI
    var tKojis = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji k in tKojis) {
      if(
        k.jyucyuId==jyucyuId && (singleSummarize=="01" || singleSummarize=="1")
        || k.syuyakuJyucyuId==jyucyuId && (singleSummarize=="02" || singleSummarize=="2")
      ){
        k.kojiRenkeiYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        k.kojiKekka = "01";
        k.kojiSt = "03";
        k.biko = biko;
        k.updPGID = "KOJ1120F";
        k.updTantCd = loginId;
        k.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: k.jyucyuId,
            model: k
        );
      }
    }

    //INSERT T_KOJIMSAI
    var tKojimsais = await LocalStorageBase.getValues(boxName: boxKojimsaiName);

    for(var t in tableList){
      String newId = IdNameController().getId();
      TKojimsai tKojimsai = TKojimsai(
          jyucyuId: jyucyuId,
          jyucyumsaiId: newId,
          suryo: t.suryo,
          hanbaiTanka: t.hanbaitanka,
          kingak: t.kingak,
          tuikaJisyaCd: 'KOJ-${t.tuikajisyaCode}',
          tuikaSyohinName: t.tuikasyohinName,
          kojijituikaFlg: "1",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
      );
      await LocalStorageBase.add(
          boxName: boxKojimsaiName,
          key: '${tKojimsai.jyucyuId}_${tKojimsai.jyucyumsaiId}',
          model: tKojimsai
      );
    }

    //UPDATE T_KOJIMSAI
    for(var kh in kojiHoukoku){

      if(kh.isEmpty) continue;

      late TKojimsai tKojimsai;
      for(TKojimsai km in tKojimsais){
        if(km.jyucyumsaiId==kh.jyucyuMsaiId && km.jyucyuId==jyucyuId){
          tKojimsai = km;
          break;
        }
      }
      List<String> otherPhotosPathOrBase64 = [];
      for(var op in kh.otherPhotoFolderPath??[]){
        if(_isNetworkPath(op)){
          otherPhotosPathOrBase64.add(op);
        }
        else{
          if(op!=null && op.isNotEmpty) {
            String? copyPath;
            copyPath = await FileController().copyFile(
                file: File(op),
                isNew: true,
                onFailed: () {}
            );
            otherPhotosPathOrBase64.add(copyPath.isEmpty?op:copyPath);
          }
        }
      }
      tKojimsai.jyucyumsaiIdKikan = kh.jyucyuMsaiIdKikan;
      tKojimsai.hinban = kh.hinban;
      tKojimsai.makerCd = kh.makerCd;
      tKojimsai.ctgotyCd = kh.ctgoryCd;
      tKojimsai.suryo = kh.suryo;
      tKojimsai.kingak = kh.kingak;
      tKojimsai.kisetuHinban = kh.kisetuHinban;
      tKojimsai.kisetuMaker = kh.kisetuMaker;
      tKojimsai.kensetuKeitai = kh.kensetuKeitai;
      if(kh.isChangeBefore){
        tKojimsai.befSekoPhotoFilePath = _isNetworkPath(kh.befSekiPhotoFilePath)?kh.befSekiPhotoFilePath:await FileController().copyFile(file: File(kh.befSekiPhotoFilePath!), isNew: true, onFailed: (){});
      }
      if(kh.isChangeAfter){
        tKojimsai.aftSekoPhotoFilePath = _isNetworkPath(kh.aftSekoPhotoFilePath)?kh.aftSekoPhotoFilePath:await FileController().copyFile(file: File(kh.aftSekoPhotoFilePath!), isNew: true, onFailed: (){});
      }
      tKojimsai.otherPhotoFolderPath = otherPhotosPathOrBase64;
      tKojimsai.tuikaJisyaCd = 'KOJ-${kh.tuikaJisyaCd}';
      tKojimsai.tuikaSyohinName = kh.tuikaSyohinName;
      tKojimsai.updPGID = "KOJ1120F";
      tKojimsai.updTantCd = loginId;
      tKojimsai.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
      tKojimsai.storage(
        localBefSekoPhotoFilePath: kh.isChangeBefore?tKojimsai.befSekoPhotoFilePath:null,
        localAftSekoPhotoFilePath: kh.isChangeAfter?tKojimsai.aftSekoPhotoFilePath:null,
        localOtherSekoPhotoFilePath: kh.isAddOthers?tKojimsai.otherPhotoFolderPath:null
      );
      await LocalStorageBase.add(
          boxName: boxKojimsaiName,
          key: '${tKojimsai.jyucyuId}_${tKojimsai.jyucyumsaiId}',
          model: tKojimsai
      );
    }

    //INSERT T_KOJI_CHECK
    bool isCheckExist = false;
    var tKojiChecks = await LocalStorageBase.getValues(boxName: boxKojiCheckName);
    for(TKojiCheck kc in tKojiChecks) {
      if(kc.jyucyuId==jyucyuId){
        isCheckExist = true;
        kc.checkFlg1 = checkFlg1;
        kc.checkFlg2 = checkFlg2;
        kc.checkFlg3 = checkFlg3;
        kc.checkFlg4 = checkFlg4;
        kc.checkFlg5 = checkFlg5;
        kc.checkFlg6 = checkFlg6;
        kc.checkFlg7 = checkFlg7;
        kc.delFlg = "0";
        kc.addPGID = "KOJ1120F";
        kc.addTantCd = loginId;
        kc.addYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        kc.updPGID = "KOJ1120F";
        kc.updTantCd = loginId;
        kc.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiCheckName,
            key: kc.jyucyuId,
            model: kc
        );
      }
    }

    if(!isCheckExist){

      TKojiCheck tKojiCheck = TKojiCheck(
          jyucyuId: jyucyuId,
          checkFlg1: checkFlg1,
          checkFlg2: checkFlg2,
          checkFlg3: checkFlg3,
          checkFlg4: checkFlg4,
          checkFlg5: checkFlg5,
          checkFlg6: checkFlg6,
          checkFlg7: checkFlg7,
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      await LocalStorageBase.add(
          boxName: boxKojiCheckName,
          key: tKojiCheck.jyucyuId,
          model: tKojiCheck
      );

    }

  }

  Future<void> localCorporateCompletion({
    required jyucyuId,
    required loginId,
    required List<KojiHoukokuModel> kojiHoukokuList,
    required List<String> filePathList //localStoragePathList
  })async{

    var now = DateTime.now();

    //INSERT T_KOJI_FILEPATH
    for(var fp in filePathList){
      String newId = IdNameController().getId();
      TKojiFilePath tKojiFilePath = TKojiFilePath(
          filePathId: newId,
          id: jyucyuId,
          filePath: fp,
          fileKbnCd: "09",
          delFlg: "0",
          addPGID: "KOJ1120F",
          addTantCd: loginId,
          addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
          updPGID: "KOJ1120F",
          updTantCd: loginId,
          updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
      );
      tKojiFilePath.storage(fp);
      await LocalStorageBase.add(
          boxName: boxKojiFilePathName,
          key: tKojiFilePath.filePathId,
          model: tKojiFilePath
      );
    }

    //UPDATE T_KOJI
    var tKojis = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji k in tKojis){
      if(k.jyucyuId==jyucyuId){
        k.kojiRenkeiYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        k.kojiKekka = "03";
        k.kojiSt = "03";
        k.updPGID = "KOJ1120F";
        k.updTantCd = loginId;
        k.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
        await LocalStorageBase.add(
            boxName: boxKojiName,
            key: k.jyucyuId,
            model: k
        );
        break;
      }
    }

    //INSERT KOJI HOUKOKU
    var tKojimsais = await LocalStorageBase.getValues(boxName: boxKojimsaiName);

    for(var k in kojiHoukokuList){
      bool isTKojimsaiExist = false;
      for(TKojimsai km in tKojimsais){
        if(km.jyucyumsaiId==k.jyucyuMsaiId && km.jyucyuId==jyucyuId){
          List<String> otherPhotosPathOrBase64 = [];
          for(var op in k.otherPhotoFolderPath??[]){
            if(_isNetworkPath(op)){
              otherPhotosPathOrBase64.add(op);
            }
            else{
              if(op!=null && op.isNotEmpty) {
                String? copyPath;
                copyPath = await FileController().copyFile(
                    file: File(op),
                    isNew: true,
                    onFailed: () {}
                );
                otherPhotosPathOrBase64.add(copyPath.isEmpty?op:copyPath);
              }
            }
          }
          isTKojimsaiExist = true;
          km.kensetuKeitai = k.kensetuKeitai;
          if(k.isChangeBefore){
            km.befSekoPhotoFilePath = _isNetworkPath(k.befSekiPhotoFilePath)?k.befSekiPhotoFilePath:await FileController().copyFile(file: File(k.befSekiPhotoFilePath!), isNew: true, onFailed: (){});
          }
          if(k.isChangeAfter){
            km.aftSekoPhotoFilePath = _isNetworkPath(k.aftSekoPhotoFilePath)?k.aftSekoPhotoFilePath:await FileController().copyFile(file: File(k.aftSekoPhotoFilePath!), isNew: true, onFailed: (){});
          }
          // km.befSekoPhotoFilePath = _isNetworkPath(k.befSekiPhotoFilePath)?k.befSekiPhotoFilePath:k.isChangeBefore?await FileController().copyFile(file: File(k.befSekiPhotoFilePath!), isNew: true, onFailed: (){}):k.befSekiPhotoFilePath;//////////////////////////////////////////////////
          // km.aftSekoPhotoFilePath = _isNetworkPath(k.aftSekoPhotoFilePath)?k.aftSekoPhotoFilePath:k.isChangeAfter?await FileController().copyFile(file: File(k.aftSekoPhotoFilePath!), isNew: true, onFailed: (){}):k.aftSekoPhotoFilePath;
          km.otherPhotoFolderPath = otherPhotosPathOrBase64;
          km.updPGID = "KOJ1120F";
          km.updTantCd = loginId;
          km.updYMD = DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString();
          km.storage(
              localBefSekoPhotoFilePath: k.isChangeBefore?km.befSekoPhotoFilePath:null,
              localAftSekoPhotoFilePath: k.isChangeAfter?km.aftSekoPhotoFilePath:null,
              localOtherSekoPhotoFilePath: k.isAddOthers?km.otherPhotoFolderPath:null
          );
          await LocalStorageBase.add(
              boxName: boxKojimsaiName,
              key: '${km.jyucyuId}_${km.jyucyumsaiId}',
              model: km
          );
          break;
        }
      }
      if(!isTKojimsaiExist){
        List<String> otherPhotosPathOrBase64 = [];
        for(var op in k.otherPhotoFolderPath??[]){
          if(_isNetworkPath(op)){
            otherPhotosPathOrBase64.add(op);
          }
          else{
            if(op!=null && op.isNotEmpty){
              String? copyPath;
              copyPath = await FileController().copyFile(
                  file: File(op),
                  isNew: true,
                  onFailed: () {}
              );
              otherPhotosPathOrBase64.add(copyPath.isEmpty?op:copyPath);
            }
          }
        }
        String newId = IdNameController().getId();
        var tKojimsai = TKojimsai(
            jyucyuId: jyucyuId,
            jyucyumsaiId: newId,
            jyucyumsaiIdKikan: k.jyucyuMsaiIdKikan,
            hinban: k.hinban,
            makerCd: k.makerCd,
            ctgotyCd: k.ctgoryCd,
            suryo: k.suryo,
            kingak: k.kingak,
            kisetuHinban: k.kisetuHinban,
            kisetuMaker: k.kisetuMaker,
            kensetuKeitai: k.kensetuKeitai,
            // befSekoPhotoFilePath: _isNetworkPath(k.befSekiPhotoFilePath)?k.befSekiPhotoFilePath:k.isChangeBefore?await FileController().copyFile(file: File(k.befSekiPhotoFilePath!), isNew: true, onFailed: (){}):k.befSekiPhotoFilePath,
            // aftSekoPhotoFilePath: _isNetworkPath(k.aftSekoPhotoFilePath)?k.aftSekoPhotoFilePath:k.isChangeAfter?await FileController().copyFile(file: File(k.aftSekoPhotoFilePath!), isNew: true, onFailed: (){}):k.aftSekoPhotoFilePath,
            otherPhotoFolderPath: otherPhotosPathOrBase64,
            tuikaJisyaCd: 'KOJ-${k.tuikaJisyaCd}',
            tuikaSyohinName: k.tuikaSyohinName,
            kojijituikaFlg: "1",
            delFlg: "0",
            addPGID: "KOJ1120F",
            addTantCd: loginId,
            addYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString(),
            updPGID: "KOJ1120F",
            updTantCd: loginId,
            updYMD: DateFormat('yyyy-MM-dd HH:mm:ss', 'ja').format(now).toString()
        );
        if(k.isChangeBefore){
          tKojimsai.befSekoPhotoFilePath = _isNetworkPath(k.befSekiPhotoFilePath)?k.befSekiPhotoFilePath:await FileController().copyFile(file: File(k.befSekiPhotoFilePath!), isNew: true, onFailed: (){});
        }
        if(k.isChangeAfter){
          tKojimsai.aftSekoPhotoFilePath = _isNetworkPath(k.aftSekoPhotoFilePath)?k.aftSekoPhotoFilePath:await FileController().copyFile(file: File(k.aftSekoPhotoFilePath!), isNew: true, onFailed: (){});
        }
        tKojimsai.storage(
            localBefSekoPhotoFilePath: k.isChangeBefore?tKojimsai.befSekoPhotoFilePath:null,
            localAftSekoPhotoFilePath: k.isChangeAfter?tKojimsai.aftSekoPhotoFilePath:null,
            localOtherSekoPhotoFilePath: k.isAddOthers?tKojimsai.otherPhotoFolderPath:null
        );
        await LocalStorageBase.add(
            boxName: boxKojimsaiName,
            key: '${tKojimsai.jyucyuId}_${tKojimsai.jyucyumsaiId}',
            model: tKojimsai
        );
      }
    }

  }

  Future<Response> localLogin({required id, required pass})async{
    var mTants = await LocalStorageBase.getValues(boxName: boxTantName);
    for(MTant t in mTants){
      if(t.tantCd==id){
        if(t.password==pass){
          return Response(
              jsonEncode(t.toJson()),
              200,
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }
          );
        }
        else{
          return Response(
            jsonEncode({
              "msg": [
                "パスワードが正しくありません"
              ]
            }),
            1000,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }
          );
        }
      }
    }
    return Response(
        jsonEncode({
          "msg": [
            "担当者コードが存在しません。正しいコードを入力してください。"
          ]
        }),
        1001,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }
    );
  }

  Future<String?> _storageLocalDirectory(r, filedName) async {
    return await r[filedName]!=null  && '${r[filedName]}'.isNotEmpty
      ? await FileController().downloadFile(
        url: '${Constant.url}${r[filedName]}',
        fileName: '${r[filedName]}'.contains('/') || '${r[filedName]}'.contains('\\')
            ? '${r[filedName]}'.substring(('${r[filedName]}'.lastIndexOf('/')>=0 ? '${r[filedName]}'.lastIndexOf('/') : '${r[filedName]}'.lastIndexOf('\\'))+1)
            : '${r[filedName]}',
        onFailed: (){}
      )
      : null;
  }

  Future<List<String>?> _storageLocalDirectoryList(dynamic urls) async {
    if(urls==null || urls.isEmpty) return null;
    List urlList = '$urls'.split(';');
    List<String> storagePaths = [];
    for(var u in urlList){
      if(u!=null && u.isNotEmpty){
        String? localPath = await FileController().downloadFile(
            url: '${Constant.url}$u',
            fileName: '$u'.contains('/') || '$u'.contains('\\')
                ? '$u'.substring(('$u'.lastIndexOf('/')>=0 ? '$u'.lastIndexOf('/') : '$u'.lastIndexOf('\\'))+1)
                : '$u',
            onFailed: (){}
        );
        if(localPath!=null && localPath.isNotEmpty){
          storagePaths.add(localPath);
        }
      }
    }
    return storagePaths;
  }

  Future<String> _base64String(String path)async{
    String filePath = '${(await FileController().prepareSaveDir()).path}$path';
    File imageFile = File(filePath);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  bool _isNetworkPath(String? path) {
    if(path==null || path.isEmpty) return true;
    final uri = Uri.parse(path);
    return uri.scheme.startsWith('http') || uri.scheme.startsWith('ftp');
  }

}