import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
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
    required this.updYMD
  });

  @HiveField(0)
  @JsonKey(name: 'JYUCYU_ID', required: true)
  String jyucyuId;
  @HiveField(1)
  @JsonKey(name: 'SITAMI_YMD', required: true)
  String sitamiYMD;
  @HiveField(2)
  @JsonKey(name: 'KOJI_YMD', required: true)
  String kojiYMD;
  @HiveField(3)
  @JsonKey(name: 'HOMON_TANT_CD1', required: true)
  String homonTantCd1;
  @HiveField(4)
  @JsonKey(name: 'HOMON_TANT_NAME1', required: true)
  String homonTantName1;
  @HiveField(5)
  @JsonKey(name: 'HOMON_TANT_CD2', required: true)
  String homonTantCd2;
  @HiveField(6)
  @JsonKey(name: 'HOMON_TANT_NAME2', required: true)
  String homonTantName2;
  @HiveField(7)
  @JsonKey(name: 'HOMON_TANT_CD3', required: true)
  String homonTantCd3;
  @HiveField(8)
  @JsonKey(name: 'HOMON_TANT_NAME3', required: true)
  String homonTantName3;
  @HiveField(9)
  @JsonKey(name: 'HOMON_TANT_CD4', required: true)
  String homonTantCd4;
  @HiveField(10)
  @JsonKey(name: 'HOMON_TANT_NAME4', required: true)
  String homonTantName4;
  @HiveField(11)
  @JsonKey(name: 'SETSAKI_NAME', required: true)
  String setsakiName;
  @HiveField(12)
  @JsonKey(name: 'SETSAKI_ADDRESS', required: true)
  String setsakiAddress;
  @HiveField(13)
  @JsonKey(name: 'KOJI_JININ', required: true)
  int kojiJinin;
  @HiveField(14)
  @JsonKey(name: 'SITAMI_JININ', required: true)
  int sitamiJinin;
  @HiveField(15)
  @JsonKey(name: 'HOMON_SBT', required: true)
  String homonSbt;
  @HiveField(16)
  @JsonKey(name: 'KOJI_ST', required: true)
  String kojiSt;
  @HiveField(17)
  @JsonKey(name: 'KOJI_ITEM', required: true)
  String kojiItem;
  @HiveField(18)
  @JsonKey(name: 'SITAMI_KANSAN_POINT', required: true)
  double sitamiKansanPoint;
  @HiveField(19)
  @JsonKey(name: 'KOJI_KANSAN_POINT', required: true)
  double kojiKansanPoint;
  @HiveField(20)
  @JsonKey(name: 'SITAMI_JIKAN', required: true)
  int sitamiJikan;
  @HiveField(21)
  @JsonKey(name: 'KOJI_JIKAN', required: true)
  int kojiJikan;
  @HiveField(22)
  @JsonKey(name: 'KOJI_KEKKA', required: true)
  String kojiKekka;
  @HiveField(23)
  @JsonKey(name: 'TENPO_CD', required: true)
  String tenpoCd;
  @HiveField(24)
  @JsonKey(name: 'HOJIN_FLG', required: true)
  int hojinFlg;
  @HiveField(25)
  @JsonKey(name: 'MALL_CD', required: true)
  String mallCd;
  @HiveField(26)
  @JsonKey(name: 'KOJIGYOSYA_CD', required: true)
  String kojigyosyaCd;
  @HiveField(27)
  @JsonKey(name: 'TAG_KBN', required: true)
  String tagKbn;
  @HiveField(28)
  @JsonKey(name: 'SITAMIHOMONJIKAN', required: true)
  String sitamiHomonJikan;
  @HiveField(29)
  @JsonKey(name: 'SITAMIHOMONJIKAN_END', required: true)
  String sitamiHomonJikanEnd;
  @HiveField(30)
  @JsonKey(name: 'KOJIHOMONJIKAN', required: true)
  String kojiHomonJikan;
  @HiveField(31)
  @JsonKey(name: 'KOJIHOMONJIKAN_END', required: true)
  String kojiHomonJikanEnd;
  @HiveField(32)
  @JsonKey(name: 'KOJIIRAISYO_FILEPATH', required: true)
  String kojiiraisyoFilePath;
  @HiveField(33)
  @JsonKey(name: 'SITAMIIRAISYO_FILEPATH', required: true)
  String sitamiiraisyoFilePath;
  @HiveField(34)
  @JsonKey(name: 'CANCEL_RIYU', required: true)
  String cancelRiyu;
  @HiveField(35)
  @JsonKey(name: 'SITAMIAPO_KBN', required: true)
  String sitamiapoKbn;
  @HiveField(36)
  @JsonKey(name: 'KOJIAPO_KBN', required: true)
  String kojiapoKbn;
  @HiveField(37)
  @JsonKey(name: 'MTMORI_YMD', required: true)
  String mtmoriYMD;
  @HiveField(38)
  @JsonKey(name: 'MEMO', required: true)
  String memo;
  @HiveField(39)
  @JsonKey(name: 'COMMENT', required: true)
  String comment;
  @HiveField(40)
  @JsonKey(name: 'READ_FLG', required: true)
  int readFlg;
  @HiveField(41)
  @JsonKey(name: 'ATOBARAI', required: true)
  String atobarai;
  @HiveField(42)
  @JsonKey(name: 'BIKO', required: true)
  String biko;
  @HiveField(43)
  @JsonKey(name: 'SYUYAKU_JYUCYU_ID', required: true)
  String syuyakuJyucyuId;
  @HiveField(44)
  @JsonKey(name: 'REPORT_FLG', required: true)
  int reportFlg;
  @HiveField(45)
  @JsonKey(name: 'SITAMI_REPORT', required: true)
  int sitamiReport;
  @HiveField(46)
  @JsonKey(name: 'ALL_DAY_FLG', required: true)
  int allDayFlg;
  @HiveField(47)
  @JsonKey(name: 'CO_CD', required: true)
  String coCd;
  @HiveField(48)
  @JsonKey(name: 'CO_NAME', required: true)
  String coName;
  @HiveField(49)
  @JsonKey(name: 'CO_POSTNO', required: true)
  String coPostno;
  @HiveField(50)
  @JsonKey(name: 'CO_ADDRESS', required: true)
  String coAddress;
  @HiveField(51)
  @JsonKey(name: 'SIT_ITAKUHI', required: true)
  int sitItakuhi;
  @HiveField(52)
  @JsonKey(name: 'KOJI_ITAKUHI', required: true)
  int kojiItakuhi;
  @HiveField(53)
  @JsonKey(name: 'SKJ_RENKEI_YMD', required: true)
  String skjRenkeiYMD;
  @HiveField(54)
  @JsonKey(name: 'KOJI_RENKEI_YMD', required: true)
  String kojiRenkeiYMD;
  @HiveField(55)
  @JsonKey(name: 'DEL_FLG', required: true)
  int delFlg;
  @HiveField(56)
  @JsonKey(name: 'ADD_PGID', required: true)
  String addPGID;
  @HiveField(57)
  @JsonKey(name: 'ADD_TANTCD', required: true)
  String addTantCd;
  @HiveField(58)
  @JsonKey(name: 'ADD_TANTNM', required: true)
  String addTantNm;
  @HiveField(59)
  @JsonKey(name: 'ADD_YMD', required: true)
  String addYMD;
  @HiveField(60)
  @JsonKey(name: 'UPD_PGID', required: true)
  String updPGID;
  @HiveField(61)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(62)
  @JsonKey(name: 'UPD_TANTNM', required: true)
  String updTantNm;
  @HiveField(63)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

}