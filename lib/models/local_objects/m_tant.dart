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
    required this.updYMD
  });

  @HiveField(0)
  @JsonKey(name: 'TANT_CD', required: true)
  String tantCd;
  @HiveField(1)
  @JsonKey(name: 'TANT_NAME', required: true)
  String tantName;
  @HiveField(2)
  @JsonKey(name: 'TANT_KNAME', required: true)
  String tantKName;
  @HiveField(3)
  @JsonKey(name: 'BUZAI_HACOK_FLG', required: true)
  int buzaiHacokFlg;
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
  @JsonKey(name: 'SYOZOKU_CD', required: true)
  String syozokuCd;
  @HiveField(10)
  @JsonKey(name: 'KENGEN_CD', required: true)
  String kengenCd;
  @HiveField(11)
  @JsonKey(name: 'DAYLY_SALES', required: true)
  int daylySales;
  @HiveField(12)
  @JsonKey(name: 'MONTHLY_SALES', required: true)
  int monthlySales;
  @HiveField(13)
  @JsonKey(name: 'KAISYU_RUIKEI', required: true)
  int kaisyuRuikei;
  @HiveField(14)
  @JsonKey(name: 'DEL_FLG', required: true)
  int delFlg;
  @HiveField(15)
  @JsonKey(name: 'ADD_PGID', required: true)
  String addPGID;
  @HiveField(16)
  @JsonKey(name: 'ADD_TANTCD', required: true)
  String addTantCd;
  @HiveField(17)
  @JsonKey(name: 'ADD_YMD', required: true)
  String addYMD;
  @HiveField(18)
  @JsonKey(name: 'UPD_PGID', required: true)
  String updPGID;
  @HiveField(19)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(20)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

}