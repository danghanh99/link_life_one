import 'package:hive/hive.dart';
part 't_kojimsai.g.dart';

@HiveType(typeId: 10)
class TKojimsai extends HiveObject{

  TKojimsai({
    required this.jyucyuId,
    required this.jyucyumsaiId,
    required this.jyucyumsaiIdKikan,
    required this.hinban,
    required this.makerCd,
    required this.ctgotyCd,
    required this.suryo,
    required this.hanbaiTanka,
    required this.kingak,
    required this.kisetuHinban,
    required this.kisetuMaker,
    required this.kensetuKeitai,
    required this.befSekoPhotoFilePath,
    required this.aftSekoPhotoFilePath,
    required this.otherPhotoFolderPath,
    required this.tuikaJisyaCd,
    required this.tuikaSyohinName,
    required this.kojijituikaFlg,
    required this.delFlg,
    required this.renkeiYMD,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD,
  });

  @HiveField(0)
  String jyucyuId;
  @HiveField(1)
  String jyucyumsaiId;
  @HiveField(2)
  String jyucyumsaiIdKikan;
  @HiveField(3)
  String hinban;
  @HiveField(4)
  String makerCd;
  @HiveField(5)
  String ctgotyCd;
  @HiveField(6)
  int suryo;
  @HiveField(7)
  String hanbaiTanka;
  @HiveField(8)
  String kingak;
  @HiveField(9)
  String kisetuHinban;
  @HiveField(10)
  String kisetuMaker;
  @HiveField(11)
  String kensetuKeitai;
  @HiveField(12)
  String befSekoPhotoFilePath;
  @HiveField(13)
  String aftSekoPhotoFilePath;
  @HiveField(14)
  String otherPhotoFolderPath;
  @HiveField(15)
  String tuikaJisyaCd;
  @HiveField(16)
  String tuikaSyohinName;
  @HiveField(17)
  String kojijituikaFlg;
  @HiveField(18)
  int delFlg;
  @HiveField(19)
  DateTime renkeiYMD;
  @HiveField(20)
  String addPGID;
  @HiveField(21)
  String addTantCd;
  @HiveField(22)
  DateTime addYMD;
  @HiveField(23)
  String updPGID;
  @HiveField(24)
  String updTantCd;
  @HiveField(25)
  DateTime updYMD;

}