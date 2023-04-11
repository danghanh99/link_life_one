import 'package:hive/hive.dart';
part 'm_kbn.g.dart';

@HiveType(typeId: 14)
class MKBN extends HiveObject{

  MKBN({
    required this.kbnCd,
    required this.kbnName,
    required this.kbnBiko,
    required this.kbnmsaiCd,
    required this.kbnmsaiName,
    required this.kbnmsaiBiko,
    required this.yobikomoku1,
    required this.yobikomoku2,
    required this.yobikomoku3,
    required this.yobikomoku4,
    required this.yobikomoku5,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  String kbnCd;
  @HiveField(1)
  String kbnName;
  @HiveField(2)
  String kbnBiko;
  @HiveField(3)
  String kbnmsaiCd;
  @HiveField(4)
  String kbnmsaiName;
  @HiveField(5)
  String kbnmsaiBiko;
  @HiveField(6)
  String yobikomoku1;
  @HiveField(7)
  String yobikomoku2;
  @HiveField(8)
  String yobikomoku3;
  @HiveField(9)
  String yobikomoku4;
  @HiveField(10)
  String yobikomoku5;
  @HiveField(11)
  int delFlg;
  @HiveField(12)
  String addPGID;
  @HiveField(13)
  String addTantCd;
  @HiveField(14)
  DateTime addYMD;
  @HiveField(15)
  String updPGID;
  @HiveField(16)
  String updTantCd;
  @HiveField(17)
  DateTime updYMD;

}