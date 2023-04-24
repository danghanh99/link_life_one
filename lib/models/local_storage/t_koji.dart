import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:link_life_one/models/koji.dart';
part 't_koji.g.dart';

@HiveType(typeId: 9)
@JsonSerializable()
class TKoji extends HiveObject{

  TKoji({
    required this.jyucyuId,
    required this.sitamiYMD,
    required this.kojiYMD,
    required this.homonTantCd1,
    required this.homonTantName1,
    required this.homonTantCd2,
    required this.homonTantName2,
    required this.homonTantCd3,
    required this.homonTantName3,
    required this.homonTantCd4,
    required this.homonTantName4,
    required this.setsakiName,
    required this.setsakiAddress,
    required this.kojiJinin,
    required this.sitamiJinin,
    required this.homonSbt,
    required this.kojiSt,
    required this.kojiItem,
    required this.sitamiKansanPoint,
    required this.kojiKansanPoint,
    required this.sitamiJikan,
    required this.kojiJikan,
    required this.kojiKekka,
    required this.tenpoCd,
    required this.hojinFlg,
    required this.mallCd,
    required this.kojigyosyaCd,
    required this.tagKbn,
    required this.sitamiHomonJikan,
    required this.sitamiHomonJikanEnd,
    required this.kojiHomonJikan,
    required this.kojiHomonJikanEnd,
    required this.kojiiraisyoFilePath,
    required this.sitamiiraisyoFilePath,
    required this.cancelRiyu,
    required this.sitamiapoKbn,
    required this.kojiapoKbn,
    required this.mtmoriYMD,
    required this.memo,
    required this.comment,
    required this.readFlg,
    required this.atobarai,
    required this.biko,
    required this.syuyakuJyucyuId,
    required this.reportFlg,
    required this.sitamiReport,
    required this.allDayFlg,
    required this.coCd,
    required this.coName,
    required this.coPostno,
    required this.coAddress,
    required this.sitItakuhi,
    required this.kojiItakuhi,
    required this.skjRenkeiYMD,
    required this.kojiRenkeiYMD,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addTantNm,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updTantNm,
    required this.updYMD,
    this.status = 0
  });

  @HiveField(0)
  @JsonKey(name: 'JYUCYU_ID', required: true)
  String jyucyuId;
  @HiveField(1)
  @JsonKey(name: 'SITAMI_YMD', required: false)
  String? sitamiYMD;
  @HiveField(2)
  @JsonKey(name: 'KOJI_YMD', required: false)
  String? kojiYMD;
  @HiveField(3)
  @JsonKey(name: 'HOMON_TANT_CD1', required: false)
  String? homonTantCd1;
  @HiveField(4)
  @JsonKey(name: 'HOMON_TANT_NAME1', required: false)
  String? homonTantName1;
  @HiveField(5)
  @JsonKey(name: 'HOMON_TANT_CD2', required: false)
  String? homonTantCd2;
  @HiveField(6)
  @JsonKey(name: 'HOMON_TANT_NAME2', required: false)
  String? homonTantName2;
  @HiveField(7)
  @JsonKey(name: 'HOMON_TANT_CD3', required: false)
  String? homonTantCd3;
  @HiveField(8)
  @JsonKey(name: 'HOMON_TANT_NAME3', required: false)
  String? homonTantName3;
  @HiveField(9)
  @JsonKey(name: 'HOMON_TANT_CD4', required: false)
  String? homonTantCd4;
  @HiveField(10)
  @JsonKey(name: 'HOMON_TANT_NAME4', required: false)
  String? homonTantName4;
  @HiveField(11)
  @JsonKey(name: 'SETSAKI_NAME', required: false)
  String? setsakiName;
  @HiveField(12)
  @JsonKey(name: 'SETSAKI_ADDRESS', required: false)
  String? setsakiAddress;
  @HiveField(13)
  @JsonKey(name: 'KOJI_JININ', required: false)
  int? kojiJinin;
  @HiveField(14)
  @JsonKey(name: 'SITAMI_JININ', required: false)
  int? sitamiJinin;
  @HiveField(15)
  @JsonKey(name: 'HOMON_SBT', required: false)
  String? homonSbt;
  @HiveField(16)
  @JsonKey(name: 'KOJI_ST', required: false)
  String? kojiSt;
  @HiveField(17)
  @JsonKey(name: 'KOJI_ITEM', required: false)
  String? kojiItem;
  @HiveField(18)
  @JsonKey(name: 'SITAMI_KANSAN_POINT', required: false)
  double? sitamiKansanPoint;
  @HiveField(19)
  @JsonKey(name: 'KOJI_KANSAN_POINT', required: false)
  double? kojiKansanPoint;
  @HiveField(20)
  @JsonKey(name: 'SITAMI_JIKAN', required: false)
  int? sitamiJikan;
  @HiveField(21)
  @JsonKey(name: 'KOJI_JIKAN', required: false)
  int? kojiJikan;
  @HiveField(22)
  @JsonKey(name: 'KOJI_KEKKA', required: false)
  String? kojiKekka;
  @HiveField(23)
  @JsonKey(name: 'TENPO_CD', required: false)
  String? tenpoCd;
  @HiveField(24)
  @JsonKey(name: 'HOJIN_FLG', required: false)
  int? hojinFlg;
  @HiveField(25)
  @JsonKey(name: 'MALL_CD', required: false)
  String? mallCd;
  @HiveField(26)
  @JsonKey(name: 'KOJIGYOSYA_CD', required: false)
  String? kojigyosyaCd;
  @HiveField(27)
  @JsonKey(name: 'TAG_KBN', required: false)
  String? tagKbn;
  @HiveField(28)
  @JsonKey(name: 'SITAMIHOMONJIKAN', required: false)
  String? sitamiHomonJikan;
  @HiveField(29)
  @JsonKey(name: 'SITAMIHOMONJIKAN_END', required: false)
  String? sitamiHomonJikanEnd;
  @HiveField(30)
  @JsonKey(name: 'KOJIHOMONJIKAN', required: false)
  String? kojiHomonJikan;
  @HiveField(31)
  @JsonKey(name: 'KOJIHOMONJIKAN_END', required: false)
  String? kojiHomonJikanEnd;
  @HiveField(32)
  @JsonKey(name: 'KOJIIRAISYO_FILEPATH', required: false)
  String? kojiiraisyoFilePath;
  @HiveField(33)
  @JsonKey(name: 'SITAMIIRAISYO_FILEPATH', required: false)
  String? sitamiiraisyoFilePath;
  @HiveField(34)
  @JsonKey(name: 'CANCEL_RIYU', required: false)
  String? cancelRiyu;
  @HiveField(35)
  @JsonKey(name: 'SITAMIAPO_KBN', required: false)
  String? sitamiapoKbn;
  @HiveField(36)
  @JsonKey(name: 'KOJIAPO_KBN', required: false)
  String? kojiapoKbn;
  @HiveField(37)
  @JsonKey(name: 'MTMORI_YMD', required: false)
  String? mtmoriYMD;
  @HiveField(38)
  @JsonKey(name: 'MEMO', required: false)
  String? memo;
  @HiveField(39)
  @JsonKey(name: 'COMMENT', required: false)
  String? comment;
  @HiveField(40)
  @JsonKey(name: 'READ_FLG', required: false)
  int? readFlg;
  @HiveField(41)
  @JsonKey(name: 'ATOBARAI', required: false)
  String? atobarai;
  @HiveField(42)
  @JsonKey(name: 'BIKO', required: false)
  String? biko;
  @HiveField(43)
  @JsonKey(name: 'SYUYAKU_JYUCYU_ID', required: false)
  String? syuyakuJyucyuId;
  @HiveField(44)
  @JsonKey(name: 'REPORT_FLG', required: false)
  int? reportFlg;
  @HiveField(45)
  @JsonKey(name: 'SITAMI_REPORT', required: false)
  int? sitamiReport;
  @HiveField(46)
  @JsonKey(name: 'ALL_DAY_FLG', required: false)
  int? allDayFlg;
  @HiveField(47)
  @JsonKey(name: 'CO_CD', required: false)
  String? coCd;
  @HiveField(48)
  @JsonKey(name: 'CO_NAME', required: false)
  String? coName;
  @HiveField(49)
  @JsonKey(name: 'CO_POSTNO', required: false)
  String? coPostno;
  @HiveField(50)
  @JsonKey(name: 'CO_ADDRESS', required: false)
  String? coAddress;
  @HiveField(51)
  @JsonKey(name: 'SIT_ITAKUHI', required: false)
  int? sitItakuhi;
  @HiveField(52)
  @JsonKey(name: 'KOJI_ITAKUHI', required: false)
  int? kojiItakuhi;
  @HiveField(53)
  @JsonKey(name: 'SKJ_RENKEI_YMD', required: false)
  String? skjRenkeiYMD;
  @HiveField(54)
  @JsonKey(name: 'KOJI_RENKEI_YMD', required: false)
  String? kojiRenkeiYMD;
  @HiveField(55)
  @JsonKey(name: 'DEL_FLG', required: false)
  int? delFlg;
  @HiveField(56)
  @JsonKey(name: 'ADD_PGID', required: false)
  String? addPGID;
  @HiveField(57)
  @JsonKey(name: 'ADD_TANTCD', required: false)
  String? addTantCd;
  @HiveField(58)
  @JsonKey(name: 'ADD_TANTNM', required: false)
  String? addTantNm;
  @HiveField(59)
  @JsonKey(name: 'ADD_YMD', required: false)
  String? addYMD;
  @HiveField(60)
  @JsonKey(name: 'UPD_PGID', required: false)
  String? updPGID;
  @HiveField(61)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(62)
  @JsonKey(name: 'UPD_TANTNM', required: false)
  String? updTantNm;
  @HiveField(63)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;
  @HiveField(64)
  String? localKojiiraisyoFilePath;
  @HiveField(65)
  String? localSitamiiraisyoFilePath;
  @HiveField(66)
  int? status = 0;
  @HiveField(67)
  String? originalKojiiraisyoFilePath;
  @HiveField(68)
  String? originalSitamiiraisyoFilePath;

  factory TKoji.fromJson(Map<String, dynamic> json) => _$TKojiFromJson(json);
  // Map<String, dynamic> toJson() => _$TKojiToJson(this);

  factory TKoji.fromRequest(Map<String, dynamic> json) {
    return TKoji(
      jyucyuId: json['JYUCYU_ID'] as String,
      sitamiYMD: json['SITAMI_YMD'] as String?,
      kojiYMD: json['KOJI_YMD'] as String?,
      homonTantCd1: json['HOMON_TANT_CD1'] as String?,
      homonTantName1: json['HOMON_TANT_NAME1'] as String?,
      homonTantCd2: json['HOMON_TANT_CD2'] as String?,
      homonTantName2: json['HOMON_TANT_NAME2'] as String?,
      homonTantCd3: json['HOMON_TANT_CD3'] as String?,
      homonTantName3: json['HOMON_TANT_NAME3'] as String?,
      homonTantCd4: json['HOMON_TANT_CD4'] as String?,
      homonTantName4: json['HOMON_TANT_NAME4'] as String?,
      setsakiName: json['SETSAKI_NAME'] as String?,
      setsakiAddress: json['SETSAKI_ADDRESS'] as String?,
      kojiJinin: json['KOJI_JININ']!=null ? int.parse('${json['KOJI_JININ']}') : null,
      sitamiJinin: json['SITAMI_JININ']!=null ? int.parse('${json['SITAMI_JININ']}') : null,
      homonSbt: json['HOMON_SBT'] as String?,
      kojiSt: json['KOJI_ST'] as String?,
      kojiItem: json['KOJI_ITEM'] as String?,
      sitamiKansanPoint: json['SITAMI_KANSAN_POINT']!=null ? double.parse('${json['SITAMI_KANSAN_POINT']}') : null,
      kojiKansanPoint: json['KOJI_KANSAN_POINT']!=null ? double.parse('${json['KOJI_KANSAN_POINT']}') : null,
      sitamiJikan: json['SITAMI_JIKAN']!=null ? int.parse('${json['SITAMI_JIKAN']}') : null,
      kojiJikan: json['KOJI_JIKAN']!=null ? int.parse('${json['KOJI_JIKAN']}') : null,
      kojiKekka: json['KOJI_KEKKA'] as String?,
      tenpoCd: json['TENPO_CD'] as String?,
      hojinFlg: json['HOJIN_FLG']!=null ? int.parse('${json['HOJIN_FLG']}') : null,
      mallCd: json['MALL_CD'] as String?,
      kojigyosyaCd: json['KOJIGYOSYA_CD'] as String?,
      tagKbn: json['TAG_KBN'] as String?,
      sitamiHomonJikan: json['SITAMIHOMONJIKAN'] as String?,
      sitamiHomonJikanEnd: json['SITAMIHOMONJIKAN_END'] as String?,
      kojiHomonJikan: json['KOJIHOMONJIKAN'] as String?,
      kojiHomonJikanEnd: json['KOJIHOMONJIKAN_END'] as String?,
      kojiiraisyoFilePath: json['KOJIIRAISYO_FILEPATH'] as String?,
      sitamiiraisyoFilePath: json['SITAMIIRAISYO_FILEPATH'] as String?,
      cancelRiyu: json['CANCEL_RIYU'] as String?,
      sitamiapoKbn: json['SITAMIAPO_KBN'] as String?,
      kojiapoKbn: json['KOJIAPO_KBN'] as String?,
      mtmoriYMD: json['MTMORI_YMD'] as String?,
      memo: json['MEMO'] as String?,
      comment: json['COMMENT'] as String?,
      readFlg: json['READ_FLG']!=null ? int.parse('${json['READ_FLG']}') : null,
      atobarai: json['ATOBARAI'] as String?,
      biko: json['BIKO'] as String?,
      syuyakuJyucyuId: json['SYUYAKU_JYUCYU_ID'] as String?,
      reportFlg: json['REPORT_FLG']!=null ? int.parse('${json['REPORT_FLG']}') : null,
      sitamiReport: json['SITAMI_REPORT']!=null ? int.parse('${json['SITAMI_REPORT']}') : null,
      allDayFlg: json['ALL_DAY_FLG']!=null ? int.parse('${json['ALL_DAY_FLG']}') : null,
      coCd: json['CO_CD'] as String?,
      coName: json['CO_NAME'] as String?,
      coPostno: json['CO_POSTNO'] as String?,
      coAddress: json['CO_ADDRESS'] as String?,
      sitItakuhi: json['SIT_ITAKUHI']!=null ? int.parse('${json['SIT_ITAKUHI']}') : null,
      kojiItakuhi: json['KOJI_ITAKUHI']!=null ? int.parse('${json['KOJI_ITAKUHI']}') : null,
      skjRenkeiYMD: json['SKJ_RENKEI_YMD'] as String?,
      kojiRenkeiYMD: json['KOJI_RENKEI_YMD'] as String?,
      delFlg: json['DEL_FLG']!=null ? int.parse('${json['DEL_FLG']}') : null,
      addPGID: json['ADD_PGID'] as String?,
      addTantCd: json['ADD_TANTCD'] as String?,
      addTantNm: json['ADD_TANTNM'] as String?,
      addYMD: json['ADD_YMD'] as String?,
      updPGID: json['UPD_PGID'] as String?,
      updTantCd: json['UPD_TANTCD'] as String,
      updTantNm: json['UPD_TANTNM'] as String?,
      updYMD: json['UPD_YMD'] as String,
      status: 0
    );
  }

  Map<String, dynamic> toBodyJson() => <String, dynamic>{
    'JYUCYU_ID': jyucyuId,
    'SITAMI_YMD': sitamiYMD,
    'KOJI_YMD': kojiYMD,
    'HOMON_TANT_CD1': homonTantCd1,
    'HOMON_TANT_NAME1': homonTantName1,
    'HOMON_TANT_CD2': homonTantCd2,
    'HOMON_TANT_NAME2': homonTantName2,
    'HOMON_TANT_CD3': homonTantCd3,
    'HOMON_TANT_NAME3': homonTantName3,
    'HOMON_TANT_CD4': homonTantCd4,
    'HOMON_TANT_NAME4': homonTantName4,
    'SETSAKI_NAME': setsakiName,
    'SETSAKI_ADDRESS': setsakiAddress,
    'KOJI_JININ': kojiJinin,
    'SITAMI_JININ': sitamiJinin,
    'HOMON_SBT': homonSbt,
    'KOJI_ST': kojiSt,
    'KOJI_ITEM': kojiItem,
    'SITAMI_KANSAN_POINT': sitamiKansanPoint,
    'KOJI_KANSAN_POINT': kojiKansanPoint,
    'SITAMI_JIKAN': sitamiJikan,
    'KOJI_JIKAN': kojiJikan,
    'KOJI_KEKKA': kojiKekka,
    'TENPO_CD': tenpoCd,
    'HOJIN_FLG': hojinFlg,
    'MALL_CD': mallCd,
    'KOJIGYOSYA_CD': kojigyosyaCd,
    'TAG_KBN': tagKbn,
    'SITAMIHOMONJIKAN': sitamiHomonJikan,
    'SITAMIHOMONJIKAN_END': sitamiHomonJikanEnd,
    'KOJIHOMONJIKAN': kojiHomonJikan,
    'KOJIHOMONJIKAN_END': kojiHomonJikanEnd,
    'KOJIIRAISYO_FILEPATH': kojiiraisyoFilePath,
    'SITAMIIRAISYO_FILEPATH': sitamiiraisyoFilePath,
    'CANCEL_RIYU': cancelRiyu,
    'SITAMIAPO_KBN': sitamiapoKbn,
    'KOJIAPO_KBN': kojiapoKbn,
    'MTMORI_YMD': mtmoriYMD,
    'MEMO': memo,
    'COMMENT': comment,
    'READ_FLG': readFlg,
    'ATOBARAI': atobarai,
    'BIKO': biko,
    'SYUYAKU_JYUCYU_ID': syuyakuJyucyuId,
    'REPORT_FLG': reportFlg,
    'SITAMI_REPORT': sitamiReport,
    'ALL_DAY_FLG': allDayFlg,
    'CO_CD': coCd,
    'CO_NAME': coName,
    'CO_POSTNO': coPostno,
    'CO_ADDRESS': coAddress,
    'SIT_ITAKUHI': sitItakuhi,
    'KOJI_ITAKUHI': kojiItakuhi,
    'SKJ_RENKEI_YMD': skjRenkeiYMD,
    'KOJI_RENKEI_YMD': kojiRenkeiYMD,
    'DEL_FLG': delFlg,
    'ADD_PGID': addPGID,
    'ADD_TANTCD': addTantCd,
    'ADD_TANTNM': addTantNm,
    'ADD_YMD': addYMD,
    'UPD_PGID': updPGID,
    'UPD_TANTCD': updTantCd,
    'UPD_TANTNM': updTantNm,
    'UPD_YMD': updYMD
  };

  Koji toKoji(){
    return Koji(
        homonSbt: homonSbt!,
        jyucyuId: jyucyuId,
        shitamiJinin: sitamiJinin,
        kojiItem: kojiItem,
        setsakiAddress: setsakiAddress!,
        setsakiName: setsakiName,
        kojiSt: kojiSt!,
        hojinFlag: '${hojinFlg}',
        sitamiHomonJikan: sitamiHomonJikan,
        sitamiHomonJikanEnd: sitamiHomonJikanEnd,
        kojiHomonJikan: kojiHomonJikan,
        kojiHomonJikanEnd: kojiHomonJikanEnd,
        shitamiJikan: sitamiJikan,
        kojiJinin: kojiJinin,
        kojiJikan: kojiJikan,
    );
  }

  void storage({localKojiiraisyoFilePath, localSitamiiraisyoFilePath}){
    this.localKojiiraisyoFilePath = localKojiiraisyoFilePath;
    this.localSitamiiraisyoFilePath = localSitamiiraisyoFilePath;
  }

  void origin({kojiiraisyoFilePath, sitamiiraisyoFilePath}){
    originalKojiiraisyoFilePath = kojiiraisyoFilePath;
    originalSitamiiraisyoFilePath = sitamiiraisyoFilePath;
  }

}