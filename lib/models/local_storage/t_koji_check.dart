import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 't_koji_check.g.dart';

@HiveType(typeId: 11)
@JsonSerializable()
class TKojiCheck extends HiveObject{

  TKojiCheck({
    required this.jyucyuId,
    required this.checkFlg1,
    required this.checkFlg2,
    required this.checkFlg3,
    required this.checkFlg4,
    required this.checkFlg5,
    required this.checkFlg6,
    required this.checkFlg7,
    required this.delFlg,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD
  });

  @HiveField(0)
  @JsonKey(name: 'JYUCYU_ID', required: true)
  String jyucyuId;
  @HiveField(1)
  @JsonKey(name: 'CHECK_FLG1', required: true)
  int checkFlg1;
  @HiveField(2)
  @JsonKey(name: 'CHECK_FLG2', required: true)
  int checkFlg2;
  @HiveField(3)
  @JsonKey(name: 'CHECK_FLG3', required: true)
  int checkFlg3;
  @HiveField(4)
  @JsonKey(name: 'CHECK_FLG4', required: true)
  int checkFlg4;
  @HiveField(5)
  @JsonKey(name: 'CHECK_FLG5', required: true)
  int checkFlg5;
  @HiveField(6)
  @JsonKey(name: 'CHECK_FLG6', required: true)
  int checkFlg6;
  @HiveField(7)
  @JsonKey(name: 'CHECK_FLG7', required: true)
  int checkFlg7;
  @HiveField(8)
  @JsonKey(name: 'DEL_FLG', required: true)
  int delFlg;
  @HiveField(9)
  @JsonKey(name: 'ADD_PGID', required: true)
  String addPGID;
  @HiveField(10)
  @JsonKey(name: 'ADD_TANTCD', required: true)
  String addTantCd;
  @HiveField(11)
  @JsonKey(name: 'ADD_YMD', required: true)
  String addYMD;
  @HiveField(12)
  @JsonKey(name: 'UPD_PGID', required: true)
  String updPGID;
  @HiveField(13)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(14)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

}