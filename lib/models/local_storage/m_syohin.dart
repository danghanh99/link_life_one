import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_syohin.g.dart';

@HiveType(typeId: 7)
@JsonSerializable()
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
  @JsonKey(name: 'JISYA_CD', required: true)
  String jisyaCd;
  @HiveField(1)
  @JsonKey(name: 'SYOHIN_NAME', required: true)
  String syohinName;
  @HiveField(2)
  @JsonKey(name: 'HINBAN', required: true)
  String hinban;
  @HiveField(3)
  @JsonKey(name: 'SYOHIN_SYBET_CD', required: false)
  String? syohinSybetCd;
  @HiveField(4)
  @JsonKey(name: 'MAKER_CD', required: false)
  String? makerCd;
  @HiveField(5)
  @JsonKey(name: 'CTGORY_CD', required: false)
  String? ctgoryCd;
  @HiveField(6)
  @JsonKey(name: 'HANBAI_TANKA', required: false)
  String? hanbaiTanka;
  @HiveField(7)
  @JsonKey(name: 'CHANGE_FLG', required: false)
  String? changeFlg;
  @HiveField(8)
  @JsonKey(name: 'ADD_PGID', required: false)
  String? addPGID;
  @HiveField(9)
  @JsonKey(name: 'ADD_TANTCD', required: false)
  String? addTantCd;
  @HiveField(10)
  @JsonKey(name: 'ADD_YMD', required: true)
  String addYMD;
  @HiveField(11)
  @JsonKey(name: 'UPD_PGID', required: false)
  String? updPGID;
  @HiveField(12)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(13)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

  factory MSyohin.fromJson(Map<String, dynamic> json) => _$MSyohinFromJson(json);
  Map<String, dynamic> toJson() => _$MSyohinToJson(this);

}