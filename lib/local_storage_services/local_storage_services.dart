import 'package:link_life_one/api/local_storages/download_offline_api.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
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

class LocalStorageServices{

  Future<void> downloadDB() async {
    await DownloadOfflineAPI().getDB(
        onSuccess: (Map<String, dynamic> response)async{

          //Gyosya Storage
          await LocalStorageBase.clear(boxName: boxGyosyaName);
          for(var r in response['M_GYOSYA']){
            MGyosya mGyosya = MGyosya.fromJson(r);
            LocalStorageBase.add(
                boxName: boxGyosyaName,
                key: mGyosya.kojiGyosyaCd,
                model: mGyosya
            );
          }

          //Syohin Storage
          await LocalStorageBase.clear(boxName: boxSyohinName);
          for(var r in response['M_SYOHIN']){
            MSyohin mSyohin = MSyohin.fromJson(r);
            LocalStorageBase.add(
                boxName: boxSyohinName,
                key: mSyohin.jisyaCd,
                model: mSyohin
            );
          }

          //Tant Storage
          await LocalStorageBase.clear(boxName: boxTantName);
          for(var r in response['M_TANT']){
            MTant mTant = MTant.fromJson(r);
            LocalStorageBase.add(
                boxName: boxTantName,
                key: mTant.tantCd,
                model: mTant
            );
          }

          //Kbn Storage
          await LocalStorageBase.clear(boxName: boxKbnName);
          for(var r in response['M_KBN']){
            MKBN mKbn = MKBN.fromJson(r);
            LocalStorageBase.add(
                boxName: boxKbnName,
                key: mKbn.kbnCd,
                model: mKbn
            );
          }

          //Koji Storage
          await LocalStorageBase.clear(boxName: boxKojiName);
          for(var r in response['T_KOJI']){
            TKoji tKoji = TKoji.fromRequest(r);
            LocalStorageBase.add(
                boxName: boxKojiName,
                key: tKoji.jyucyuId,
                model: tKoji
            );
          }

          //Kojimsai Storage
          await LocalStorageBase.clear(boxName: boxKojimsaiName);
          for(var r in response['T_KOJIMSAI']){
            TKojimsai tKojimsai = TKojimsai.fromJson(r);
            LocalStorageBase.add(
                boxName: boxKojimsaiName,
                key: '${tKojimsai.jyucyuId}_${tKojimsai.jyucyumsaiId}',
                model: tKojimsai
            );
          }

          //KojiCheck Storage
          await LocalStorageBase.clear(boxName: boxKojiCheckName);
          for(var r in response['T_KOJI_CHECK']){
            TKojiCheck tKojiCheck = TKojiCheck.fromJson(r);
            LocalStorageBase.add(
                boxName: boxKojiCheckName,
                key: tKojiCheck.jyucyuId,
                model: tKojiCheck
            );
          }

          //KojiFilePath Storage
          await LocalStorageBase.clear(boxName: boxKojiFilePathName);
          for(var r in response['T_KOJI_FILEPATH']){
            TKojiFilePath tKojiFilePath = TKojiFilePath.fromJson(r);
            LocalStorageBase.add(
                boxName: boxKojiFilePathName,
                key: tKojiFilePath.filePathId,
                model: tKojiFilePath
            );
          }

          //Tirasi Storage
          await LocalStorageBase.clear(boxName: boxTirasiName);
          for(var r in response['T_TIRASI']){
            TTirasi tTirasi = TTirasi.fromJson(r);
            LocalStorageBase.add(
                boxName: boxTirasiName,
                key: '${tTirasi.tantCd}_${tTirasi.YMD}',
                model: tTirasi
            );
          }

        },
        onFailed: (){

        }
    );
  }

  Future<int> checkCount({required YMD, required setsakiAddress, required jyucyuId}) async {
    int count = 0;
    var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
    for(TKoji t in tkoji){
      if(t.kojiYMD==YMD && t.setsakiAddress==setsakiAddress && t.jyucyuId!=jyucyuId && t.delFlg==0) count++;
    }
    return count;
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
        for(TKojiFilePath tFP in tkojiFilePath){
          if(tFP.id==t.jyucyuId && tFP.fileKbnCd=="04" && tFP.delFlg=="0"){
            resultList.add(
                PdfFile(
                    sitamiiraisyoFilePath: tFP.filePath,
                    jyucyuId: t.jyucyuId,
                    homonSbt: t.homonSbt,
                    kojiSt: t.kojiSt
                )
            );
          }
        }
      }
      else if((t.jyucyuId==jyucyuId || t.syuyakuJyucyuId==jyucyuId) && t.homonSbt=="02" && t.delFlg==0){
        for(TKojiFilePath tFP in tkojiFilePath){
          if(tFP.id==t.jyucyuId && tFP.fileKbnCd=="03" && tFP.delFlg=="0"){
            resultList.add(
                PdfFile(
                  kojiiraisyoFilePath: tFP.filePath,
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

}