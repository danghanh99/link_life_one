import 'package:hive/hive.dart';
part 't_koji_check.g.dart';

@HiveType(typeId: 11)
class TKojiCheck extends HiveObject{

  TKojiCheck({
    required this.jyucyuId,
    required this.checkFlg1,
    required this.checkFlg2,
    required this.checkFlg3,
    required this.checkFlg4,
    required this.checkFlg5,
    required this.checkFlg6,
    required this.checkFlg7,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  String jyucyuId;
  @HiveField(1)
  int checkFlg1;
  @HiveField(2)
  int checkFlg2;
  @HiveField(3)
  int checkFlg3;
  @HiveField(4)
  int checkFlg4;
  @HiveField(5)
  int checkFlg5;
  @HiveField(6)
  int checkFlg6;
  @HiveField(7)
  int checkFlg7;
  @HiveField(8)
  int delFlg;
  @HiveField(9)
  String addPGID;
  @HiveField(10)
  String addTantCd;
  @HiveField(11)
  DateTime addYMD;
  @HiveField(12)
  String updPGID;
  @HiveField(13)
  String updTantCd;
  @HiveField(14)
  DateTime updYMD;

}