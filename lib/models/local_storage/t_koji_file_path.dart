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
    required this.updYMD,
    this.status = 0
  });

  @HiveField(0)
  @JsonKey(name: 'FILEPATH_ID', required: true)
  String filePathId;
  @HiveField(1)
  @JsonKey(name: 'ID', required: false)
  String? id;
  @HiveField(2)
  @JsonKey(name: 'FILEPATH', required: false)
  String? filePath;
  @HiveField(3)
  @JsonKey(name: 'FILE_KBN_CD', required: false)
  String? fileKbnCd;
  @HiveField(4)
  @JsonKey(name: 'DEL_FLG', required: false)
  String? delFlg;
  @HiveField(5)
  @JsonKey(name: 'ADD_PGID', required: false)
  String? addPGID;
  @HiveField(6)
  @JsonKey(name: 'ADD_TANTCD', required: false)
  String? addTantCd;
  @HiveField(7)
  @JsonKey(name: 'ADD_YMD', required: false)
  String? addYMD;
  @HiveField(8)
  @JsonKey(name: 'UPD_PGID', required: false)
  String? updPGID;
  @HiveField(9)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(10)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;
  @HiveField(11)
  String? localPath;
  @HiveField(12)
  int? status = 0;
  @HiveField(13)
  String? originalPath;
  @HiveField(14)
  @JsonKey(name: 'RENKEIZUMI_FLG', required: false)
  String? renkeiZumiFlg;

  factory TKojiFilePath.fromJson(Map<String, dynamic> json) => _$TKojiFilePathFromJson(json);
  // Map<String, dynamic> toJson() => _$TKojiFilePathToJson(this);

  Map<String, dynamic> toBodyJson() => <String, dynamic>{
    'FILEPATH_ID': filePathId,
    'ID': id,
    'FILEPATH': filePath,
    'FILE_KBN_CD': fileKbnCd,
    'DEL_FLG': delFlg,
    'ADD_PGID': addPGID,
    'ADD_TANTCD': addTantCd,
    'ADD_YMD': addYMD,
    'UPD_PGID': updPGID,
    'UPD_TANTCD': updTantCd,
    'UPD_YMD': updYMD,
    'RENKEIZUMI_FLG': renkeiZumiFlg
  };

  void storage(localPath){
    this.localPath = localPath;
  }

  void origin(path){
    originalPath = path;
  }

}