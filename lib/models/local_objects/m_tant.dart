import 'package:hive/hive.dart';
part 'm_tant.g.dart';

@HiveType(typeId: 8)
class MTant extends HiveObject{

  MTant({
    required this.tantCd,
    required this.tantName,
    required this.tantKName,
    required this.buzaiHacokFlg,
    required this.syozokubusyoCd,
    required this.password,
    required this.passwordUpdYMD,
    required this.menuPtncd,
    required this.tantKbnCd,
    required this.syozokuCd,
    required this.kengenCd,
    required this.daylySales,
    required this.monthlySales,
    required this.kaisyuRuikei,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  String tantCd;
  @HiveField(1)
  String tantName;
  @HiveField(2)
  String tantKName;
  @HiveField(3)
  int buzaiHacokFlg;
  @HiveField(4)
  String syozokubusyoCd;
  @HiveField(5)
  String password;
  @HiveField(6)
  DateTime passwordUpdYMD;
  @HiveField(7)
  String menuPtncd;
  @HiveField(8)
  String tantKbnCd;
  @HiveField(9)
  String syozokuCd;
  @HiveField(10)
  String kengenCd;
  @HiveField(11)
  int daylySales;
  @HiveField(12)
  int monthlySales;
  @HiveField(13)
  int kaisyuRuikei;
  @HiveField(14)
  int delFlg;
  @HiveField(15)
  String addPGID;
  @HiveField(16)
  String addTantCd;
  @HiveField(17)
  DateTime addYMD;
  @HiveField(18)
  String updPGID;
  @HiveField(19)
  String updTantCd;
  @HiveField(20)
  DateTime updYMD;

}