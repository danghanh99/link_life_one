import 'package:hive/hive.dart';
part 'm_gyosya.g.dart';

@HiveType(typeId: 6)
class MGyosya extends HiveObject{

  MGyosya({
    required this.kojiGyosyaCd,
    required this.gyosyaKBNCd,
    required this.kojiGyosyaName,
    required this.jisyaLikeFlg,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  String kojiGyosyaCd;
  @HiveField(1)
  String gyosyaKBNCd;
  @HiveField(2)
  String kojiGyosyaName;
  @HiveField(3)
  int jisyaLikeFlg;
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