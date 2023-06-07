import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/koji.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/models/local_storage/m_kbn.dart';
import 'package:link_life_one/models/local_storage/t_koji.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetListKojiApi {
  GetListKojiApi() : super();

  Future<List<Koji>> _notSuccess({required DateTime date, required loginId, required Function onFailed, required Function(List<Koji>) onSuccess}) async {
    if(await LocalStorageServices.isTodayDataDownloaded() && DateFormat('yyyyMMdd').format(date)==DateFormat('yyyyMMdd').format(DateTime.now())){
      var tkoji = await LocalStorageBase.getValues(boxName: boxKojiName);
      var mKbn = await LocalStorageBase.getValues(boxName: boxKbnName);
      List<Koji> list = [];
      for(TKoji t in tkoji){
        if((t.homonTantCd1==loginId || t.homonTantCd2==loginId || t.homonTantCd3==loginId)
            && t.syuyakuJyucyuId == null
            && t.delFlg == 0
            && t.kojiYMD==DateFormat('yyyy-MM-dd').format(date)){

          String? kbnName;
          String? yobikomoku1;
          String? yobikomoku2;

          for(MKBN k in mKbn){
            String? kbnCd;
            String? kbnmsaiCd;

            if(t.kojiSt == '01' || t.kojiSt == '02') {
              kbnCd = 'K7';
              kbnmsaiCd = t.tagKbn;
            } else {
              kbnCd = '02';
              kbnmsaiCd = '03';
            }

            if(k.kbnCd == kbnCd && k.kbnmsaiCd == kbnmsaiCd){
              kbnName = k.kbnmsaiName;
              yobikomoku1 = k.yobikomoku1;
              yobikomoku2 = k.yobikomoku2;
            }

          }

          list.add(t.toKojiWithKbn(
              kbnmsaiName: kbnName,
              yobikomoku1: yobikomoku1,
              yobikomoku2: yobikomoku2
          ));
        }
        else if(t.homonTantCd4==loginId
            && t.syuyakuJyucyuId == null
            && t.delFlg == 0
            && t.sitamiYMD==DateFormat('yyyy-MM-dd').format(date)){

          String? kbnName;
          String? yobikomoku1;
          String? yobikomoku2;

          for(MKBN k in mKbn){
            String? kbnCd;
            String? kbnmsaiCd;

            if(t.kojiSt == '01' || t.kojiSt == '02') {
              kbnCd = 'K7';
              kbnmsaiCd = t.tagKbn;
            } else {
              kbnCd = '02';
              kbnmsaiCd = '03';
            }

            if(k.kbnCd == kbnCd && k.kbnmsaiCd == kbnmsaiCd){
              kbnName = k.kbnmsaiName;
              yobikomoku1 = k.yobikomoku1;
              yobikomoku2 = k.yobikomoku2;
            }

          }

          list.add(t.toSitami(
            kbnmsaiName: kbnName,
            yobikomoku1: yobikomoku1,
            yobikomoku2: yobikomoku2
          ));

        }
      }
      onSuccess.call(_sort(list));
      return list;
    }
    else{
      onFailed.call();
      throw Exception('Failed to get list koji');
    }
  }

  List<Koji> _sort(list){
    List<Koji> sorted = list;
    sorted.sort((a, b) {
      if (a.homonSbt == '01') {
        // isShitami
        if (b.homonSbt == '01') {
          return (a.sitamiHomonJikan ?? a.kojiHomonJikan)!.compareTo((b.sitamiHomonJikan ?? b.kojiHomonJikan)!);
        } else {
          return (a.sitamiHomonJikan ?? a.kojiHomonJikan)!.compareTo((b.kojiHomonJikan ?? b.sitamiHomonJikan)!);
        }
      } else {
        if (b.homonSbt == '01') {
          return (a.kojiHomonJikan ?? a.sitamiHomonJikan)!.compareTo((b.sitamiHomonJikan ?? b.kojiHomonJikan)!);
        } else {
          return (a.kojiHomonJikan ?? a.sitamiHomonJikan)!.compareTo((b.kojiHomonJikan ?? b.sitamiHomonJikan)!);
        }
      }
    });
    return sorted;
  }

  Future<List<Koji>> getListKojiApi(
      {DateTime? date,
      required Function onFailed,
      required Function(List<Koji>) onSuccess}) async {
    DateTime date2 = date ?? DateTime.now();
    final box = Hive.box<String>('user');
    final id = box.values.last;

    bool isOnline = await LocalStorageNotifier.isOnline();
    print('isOnline: $isOnline');
    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      print('get offline');
      return _notSuccess(
          date: date2,
          loginId: id,
          onFailed: onFailed,
          onSuccess: onSuccess
      );
    }

    try{
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestGetConstructionList.php?YMD=${DateFormat(('yyyy-MM-dd')).format(date2)}&LOGIN_ID=${id}"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        final List<Koji> list = body
            .map(
              (e) => Koji(
              sitamiHomonJikan: e["SITAMIHOMONJIKAN"] ?? '',
              sitamiHomonJikanEnd: e['SITAMIHOMONJIKAN_END'] ?? '',
              kojiHomonJikan: e["KOJIHOMONJIKAN"] ?? '',
              kojiHomonJikanEnd: e['KOJIHOMONJIKAN_END'] ?? '',
              homonSbt: e["HOMON_SBT"],
              jyucyuId: e["JYUCYU_ID"],
              shitamiJinin: int.parse(e['SITAMI_JININ'] ?? '0'),
              shitamiJikan: int.parse(e["SITAMI_JIKAN"] ?? '0'),
              kojiJinin: int.parse(e['KOJI_JININ'] ?? '0'),
              kojiJikan: int.parse(e["KOJI_JIKAN"] ?? '0'),
              kojiItem: e["KOJI_ITEM"],
              setsakiAddress: e["SETSAKI_ADDRESS"],
              setsakiName: e["SETSAKI_NAME"],
              kojiSt: e['KOJI_ST'],
              hojinFlag: e['HOJIN_FLG'],
              kbnmsaiName: e['KBN_NAME'],
              yobikomoku1: e['YOBIKOMOKU1_KBN2'],
              yobikomoku2: e['YOBIKOMOKU2_KBN2']),
        )
            .toList();
        onSuccess.call(_sort(list));
        return list;
      }
      else {
        onFailed.call();
        throw Exception('Failed to get list koji');
      }
    } catch(e){
      onFailed.call();
      throw Exception('Failed to get list koji');
    }
  }
}
