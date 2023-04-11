import 'package:hive/hive.dart';
part 't_koji_file_path.g.dart';

@HiveType(typeId: 12)
class TKojiFilePath extends HiveObject{

  TKojiFilePath({
    required this.filePathId,
    required this.id,
    required this.filePath,
    required this.fileKbnCd,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  String filePathId;
  @HiveField(1)
  String id;
  @HiveField(2)
  String filePath;
  @HiveField(3)
  String fileKbnCd;
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