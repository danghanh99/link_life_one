import 'package:hive/hive.dart';
part 'm_syohin.g.dart';

@HiveType(typeId: 7)
class MSyohin extends HiveObject{

  MSyohin({
    required this.jisyaCd,
    required this.syohinName,
    required this.hinban,
    required this.syohinSybetCd,
    required this.makerCd,
    required this.ctgoryCd,
    required this.hanbaiTanka,
    required this.changeFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  String jisyaCd;
  @HiveField(1)
  String syohinName;
  @HiveField(2)
  String hinban;
  @HiveField(3)
  String syohinSybetCd;
  @HiveField(4)
  String makerCd;
  @HiveField(5)
  String ctgoryCd;
  @HiveField(6)
  String hanbaiTanka;
  @HiveField(7)
  int changeFlg;
  @HiveField(8)
  String addPGID;
  @HiveField(9)
  String addTantCd;
  @HiveField(10)
  DateTime addYMD;
  @HiveField(11)
  String updPGID;
  @HiveField(12)
  String updTantCd;
  @HiveField(13)
  DateTime updYMD;

}