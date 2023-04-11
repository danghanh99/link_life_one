import 'package:hive/hive.dart';
part 't_tirasi.g.dart';

@HiveType(typeId: 13)
class TTirasi extends HiveObject{

  TTirasi({
    required this.tantCd,
    required this.YMD,
    required this.kojiTirasisu,
    required this.renkeiYMD,
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
  DateTime YMD;
  @HiveField(2)
  int kojiTirasisu;
  @HiveField(3)
  DateTime renkeiYMD;
  @HiveField(4)
  int delFlg;
  @HiveField(5)
  String addPGID;
  @HiveField(6)
  String addTantCd;
  @HiveField(7)
  DateTime addYMD;
  @HiveField(8)
  String updPGID;
  @HiveField(9)
  String updTantCd;
  @HiveField(10)
  DateTime updYMD;

}