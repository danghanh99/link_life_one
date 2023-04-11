import 'package:hive/hive.dart';
part 't_koji.g.dart';

@HiveType(typeId: 9)
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
  String jyucyuId;
  @HiveField(1)
  DateTime sitamiYMD;
  @HiveField(2)
  DateTime kojiYMD;
  @HiveField(3)
  String homonTantCd1;
  @HiveField(4)
  String homonTantName1;
  @HiveField(5)
  String homonTantCd2;
  @HiveField(6)
  String homonTantName2;
  @HiveField(7)
  String homonTantCd3;
  @HiveField(8)
  String homonTantName3;
  @HiveField(9)
  String homonTantCd4;
  @HiveField(10)
  String homonTantName4;
  @HiveField(11)
  String setsakiName;
  @HiveField(12)
  String setsakiAddress;
  @HiveField(13)
  int kojiJinin;
  @HiveField(14)
  int sitamiJinin;
  @HiveField(15)
  String homonSbt;
  @HiveField(16)
  String kojiSt;
  @HiveField(17)
  String kojiItem;
  @HiveField(18)
  double sitamiKansanPoint;
  @HiveField(19)
  double kojiKansanPoint;
  @HiveField(20)
  int sitamiJikan;
  @HiveField(21)
  int kojiJikan;
  @HiveField(22)
  String kojiKekka;
  @HiveField(23)
  String tenpoCd;
  @HiveField(24)
  int hojinFlg;
  @HiveField(25)
  String mallCd;
  @HiveField(26)
  String kojigyosyaCd;
  @HiveField(27)
  String tagKbn;
  @HiveField(28)
  String sitamiHomonJikan;
  @HiveField(29)
  String sitamiHomonJikanEnd;
  @HiveField(30)
  String kojiHomonJikan;
  @HiveField(31)
  String kojiHomonJikanEnd;
  @HiveField(32)
  String kojiiraisyoFilePath;
  @HiveField(33)
  String sitamiiraisyoFilePath;
  @HiveField(34)
  String cancelRiyu;
  @HiveField(35)
  String sitamiapoKbn;
  @HiveField(36)
  String kojiapoKbn;
  @HiveField(37)
  DateTime mtmoriYMD;
  @HiveField(38)
  String memo;
  @HiveField(39)
  String comment;
  @HiveField(40)
  int readFlg;
  @HiveField(41)
  String atobarai;
  @HiveField(42)
  String biko;
  @HiveField(43)
  String syuyakuJyucyuId;
  @HiveField(44)
  int reportFlg;
  @HiveField(45)
  int sitamiReport;
  @HiveField(46)
  int allDayFlg;
  @HiveField(47)
  String coCd;
  @HiveField(48)
  String coName;
  @HiveField(49)
  String coPostno;
  @HiveField(50)
  String coAddress;
  @HiveField(51)
  int sitItakuhi;
  @HiveField(52)
  int kojiItakuhi;
  @HiveField(53)
  DateTime skjRenkeiYMD;
  @HiveField(54)
  DateTime kojiRenkeiYMD;
  @HiveField(55)
  int delFlg;
  @HiveField(56)
  String addPGID;
  @HiveField(57)
  String addTantCd;
  @HiveField(58)
  String addTantNm;
  @HiveField(59)
  DateTime addYMD;
  @HiveField(60)
  String updPGID;
  @HiveField(61)
  String updTantCd;
  @HiveField(62)
  String updTantNm;
  @HiveField(63)
  DateTime updYMD;

}