import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_kbn.g.dart';

@HiveType(typeId: 14)
@JsonSerializable()
class MKBN extends HiveObject{

  MKBN({
    required this.kbnCd,
    required this.kbnName,
    required this.kbnBiko,
    required this.kbnmsaiCd,
    required this.kbnmsaiName,
    required this.kbnmsaiBiko,
    required this.yobikomoku1,
    required this.yobikomoku2,
    required this.yobikomoku3,
    required this.yobikomoku4,
    required this.yobikomoku5,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  @JsonKey(name: 'KBN_CD', required: true)
  String kbnCd;
  @HiveField(1)
  @JsonKey(name: 'KBN_NAME', required: true)
  String kbnName;
  @HiveField(2)
  @JsonKey(name: 'KBN_BIKO', required: true)
  String kbnBiko;
  @HiveField(3)
  @JsonKey(name: 'KBNMSAI_CD', required: true)
  String kbnmsaiCd;
  @HiveField(4)
  @JsonKey(name: 'KBNMSAI_NAME', required: true)
  String kbnmsaiName;
  @HiveField(5)
  @JsonKey(name: 'KBNMSAI_BIKO', required: true)
  String kbnmsaiBiko;
  @HiveField(6)
  @JsonKey(name: 'YOBIKOMOKU1', required: true)
  String yobikomoku1;
  @HiveField(7)
  @JsonKey(name: 'YOBIKOMOKU2', required: true)
  String yobikomoku2;
  @HiveField(8)
  @JsonKey(name: 'YOBIKOMOKU3', required: true)
  String yobikomoku3;
  @HiveField(9)
  @JsonKey(name: 'YOBIKOMOKU4', required: true)
  String yobikomoku4;
  @HiveField(10)
  @JsonKey(name: 'YOBIKOMOKU5', required: true)
  String yobikomoku5;
  @HiveField(11)
  @JsonKey(name: 'DEL_FLG', required: true)
  int delFlg;
  @HiveField(12)
  @JsonKey(name: 'ADD_PGID', required: true)
  String addPGID;
  @HiveField(13)
  @JsonKey(name: 'ADD_TANTCD', required: true)
  String addTantCd;
  @HiveField(14)
  @JsonKey(name: 'ADD_YMD', required: true)
  String addYMD;
  @HiveField(15)
  @JsonKey(name: 'UPD_PGID', required: true)
  String updPGID;
  @HiveField(16)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(17)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

}