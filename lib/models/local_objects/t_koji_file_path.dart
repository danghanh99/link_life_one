import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 't_koji_file_path.g.dart';

@HiveType(typeId: 12)
@JsonSerializable()
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
  @JsonKey(name: 'FILEPATH_ID', required: true)
  String filePathId;
  @HiveField(1)
  @JsonKey(name: 'ID', required: true)
  String id;
  @HiveField(2)
  @JsonKey(name: 'FILEPATH', required: true)
  String filePath;
  @HiveField(3)
  @JsonKey(name: 'FILE_KBN_CD', required: true)
  String fileKbnCd;
  @HiveField(4)
  @JsonKey(name: 'DEL_FLG', required: true)
  int delFlg;
  @HiveField(5)
  @JsonKey(name: 'ADD_PGID', required: true)
  String addPGID;
  @HiveField(6)
  @JsonKey(name: 'ADD_TANTCD', required: true)
  String addTantCd;
  @HiveField(7)
  @JsonKey(name: 'ADD_YMD', required: true)
  String addYMD;
  @HiveField(8)
  @JsonKey(name: 'UPD_PGID', required: true)
  String updPGID;
  @HiveField(9)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(10)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

}