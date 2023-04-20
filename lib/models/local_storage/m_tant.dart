import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_tant.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class MTant extends HiveObject{

  MTant({
    required this.tantCd,
    required this.tantName,
    required this.tantKName,
    required this.buzaiHacokFlg,
    required this.syozokubusyoCd,
    required this.password,
    required this.passwordUpdYMD,
    required this.menuPtncd,
    required this.tantKbnCd,
    required this.syozokuCd,
    required this.kengenCd,
    required this.daylySales,
    required this.monthlySales,
    required this.kaisyuRuikei,
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
  @JsonKey(name: 'TANT_CD', required: true)
  String tantCd;
  @HiveField(1)
  @JsonKey(name: 'TANT_NAME', required: true)
  String tantName;
  @HiveField(2)
  @JsonKey(name: 'TANT_KNAME', required: false)
  String? tantKName;
  @HiveField(3)
  @JsonKey(name: 'BUZAI_HACOK_FLG', required: false)
  String? buzaiHacokFlg;
  @HiveField(4)
  @JsonKey(name: 'SYOZOKUBUSYO_CD', required: true)
  String syozokubusyoCd;
  @HiveField(5)
  @JsonKey(name: 'PASSWORD', required: true)
  String password;
  @HiveField(6)
  @JsonKey(name: 'PASSWORD_UPD_YMD', required: true)
  String passwordUpdYMD;
  @HiveField(7)
  @JsonKey(name: 'MENUPTN_CD', required: true)
  String menuPtncd;
  @HiveField(8)
  @JsonKey(name: 'TANT_KBN_CD', required: true)
  String tantKbnCd;
  @HiveField(9)
  @JsonKey(name: 'SYOZOKU_CD', required: false)
  String? syozokuCd;
  @HiveField(10)
  @JsonKey(name: 'KENGEN_CD', required: true)
  String kengenCd;
  @HiveField(11)
  @JsonKey(name: 'DAYLY_SALES', required: false)
  String? daylySales;
  @HiveField(12)
  @JsonKey(name: 'MONTHLY_SALES', required: false)
  String? monthlySales;
  @HiveField(13)
  @JsonKey(name: 'KAISYU_RUIKEI', required: false)
  String? kaisyuRuikei;
  @HiveField(14)
  @JsonKey(name: 'DEL_FLG', required: false)
  String? delFlg;
  @HiveField(15)
  @JsonKey(name: 'ADD_PGID', required: false)
  String? addPGID;
  @HiveField(16)
  @JsonKey(name: 'ADD_TANTCD', required: false)
  String? addTantCd;
  @HiveField(17)
  @JsonKey(name: 'ADD_YMD', required: false)
  String? addYMD;
  @HiveField(18)
  @JsonKey(name: 'UPD_PGID', required: false)
  String? updPGID;
  @HiveField(19)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(20)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;
  @HiveField(21)
  int? status = 0;

  factory MTant.fromJson(Map<String, dynamic> json) => _$MTantFromJson(json);
  Map<String, dynamic> toJson() => _$MTantToJson(this);

}