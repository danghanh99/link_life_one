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
  @JsonKey(name: 'KOJI_TIRASISU', required: false)
  int? kojiTirasisu;
  @HiveField(3)
  @JsonKey(name: 'RENKEI_YMD', required: false)
  String? renkeiYMD;
  @HiveField(4)
  @JsonKey(name: 'DEL_FLG', required: false)
  int? delFlg;
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

  factory TTirasi.fromJson(Map<String, dynamic> json) => _$TTirasiFromJson(json);
  Map<String, dynamic> toJson() => _$TTirasiToJson(this);

  factory TTirasi.fromRequest(Map<String, dynamic> json) => TTirasi(
    tantCd: json['TANT_CD'] as String,
    YMD: json['YMD'] as String,
    kojiTirasisu: json['KOJI_TIRASISU']!=null ? int.parse('${json['KOJI_TIRASISU']}') : null,
    renkeiYMD: json['RENKEI_YMD'] as String?,
    delFlg: json['DEL_FLG']!=null ? int.parse('${json['DEL_FLG']}') : null,
    addPGID: json['ADD_PGID'] as String?,
    addTantCd: json['ADD_TANTCD'] as String?,
    addYMD: json['ADD_YMD'] as String?,
    updPGID: json['UPD_PGID'] as String?,
    updTantCd: json['UPD_TANTCD'] as String,
    updYMD: json['UPD_YMD'] as String,
  );

}