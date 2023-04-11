import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 't_tirasi.g.dart';

@HiveType(typeId: 13)
@JsonSerializable()
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
  @JsonKey(name: 'TANT_CD', required: true)
  String tantCd;
  @HiveField(1)
  @JsonKey(name: 'YMD', required: true)
  String YMD;
  @HiveField(2)
  @JsonKey(name: 'KOJI_TIRASISU', required: true)
  int kojiTirasisu;
  @HiveField(3)
  @JsonKey(name: 'RENKEI_YMD', required: true)
  String renkeiYMD;
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