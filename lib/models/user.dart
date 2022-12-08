import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class User extends Equatable {
  User({
    required this.TANT_CD,
    required this.TANT_NAME,
    required this.TANT_KNAME,
    required this.BUZAI_HACOK_FLG,
    required this.SYOZOKUBUSYO_CD,
    required this.PASSWORD,
    required this.PASSWORD_UPD_YMD,
    required this.MENUPTN_CD,
    required this.TANT_KBN_CD,
    required this.SYOZOKU_CD,
    required this.KENGEN_CD,
    required this.DAYLY_SALES,
    required this.MONTHLY_SALES,
    required this.KAISYU_RUIKEI,
    required this.DEL_FLG,
    required this.ADD_PGID,
    required this.ADD_TANTCD,
    required this.ADD_YMD,
    required this.UPD_PGID,
    required this.UPD_TANTCD,
    required this.UPD_YMD,
  });

  @HiveField(1)
  @JsonKey(name: 'TANT_CD', required: true)
  final String TANT_CD;

  @HiveField(2)
  @JsonKey(name: 'TANT_NAME', required: true)
  final String TANT_NAME;
  @HiveField(3)
  @JsonKey(name: 'TANT_KNAME', required: true)
  final String TANT_KNAME;
  @HiveField(4)
  @JsonKey(name: 'BUZAI_HACOK_FLG', required: true)
  final String BUZAI_HACOK_FLG;
  @HiveField(5)
  @JsonKey(name: 'SYOZOKUBUSYO_CD', required: true)
  final String SYOZOKUBUSYO_CD;
  @HiveField(6)
  @JsonKey(name: 'PASSWORD', required: true)
  final String PASSWORD;
  @HiveField(7)
  @JsonKey(name: 'PASSWORD_UPD_YMD', required: true)
  final String PASSWORD_UPD_YMD;
  @HiveField(8)
  @JsonKey(name: 'MENUPTN_CD', required: true)
  final String MENUPTN_CD;
  @HiveField(9)
  @JsonKey(name: 'TANT_KBN_CD', required: true)
  final String TANT_KBN_CD;
  @HiveField(10)
  @JsonKey(name: 'SYOZOKU_CD', required: true)
  final String SYOZOKU_CD;
  @HiveField(11)
  @JsonKey(name: 'KENGEN_CD', required: true)
  final String KENGEN_CD;
  @HiveField(12)
  @JsonKey(name: 'DAYLY_SALES', required: true)
  final String DAYLY_SALES;
  @HiveField(13)
  @JsonKey(name: 'MONTHLY_SALES', required: true)
  final String MONTHLY_SALES;
  @HiveField(14)
  @JsonKey(name: 'KAISYU_RUIKEI', required: true)
  final String KAISYU_RUIKEI;
  @HiveField(15)
  @JsonKey(name: 'DEL_FLG', required: true)
  final String DEL_FLG;
  @HiveField(16)
  @JsonKey(name: 'ADD_PGID', required: true)
  final String ADD_PGID;
  @HiveField(17)
  @JsonKey(name: 'ADD_TANTCD', required: true)
  final String ADD_TANTCD;
  @HiveField(18)
  @JsonKey(name: 'ADD_YMD', required: true)
  final String ADD_YMD;
  @HiveField(19)
  @JsonKey(name: 'UPD_PGID', required: true)
  final String UPD_PGID;
  @HiveField(20)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  final String UPD_TANTCD;
  @HiveField(21)
  @JsonKey(name: 'UPD_YMD', required: true)
  final String UPD_YMD;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      TANT_CD: json["TANT_CD"],
      TANT_NAME: json["TANT_NAME"],
      TANT_KNAME: json["TANT_KNAME"],
      BUZAI_HACOK_FLG: json["BUZAI_HACOK_FLG"],
      SYOZOKUBUSYO_CD: json["SYOZOKUBUSYO_CD"],
      PASSWORD: json["PASSWORD"],
      PASSWORD_UPD_YMD: json["PASSWORD_UPD_YMD"],
      MENUPTN_CD: json["MENUPTN_CD"],
      TANT_KBN_CD: json["TANT_KBN_CD"],
      SYOZOKU_CD: json['SYOZOKU_CD'],
      KENGEN_CD: json["KENGEN_CD"],
      DAYLY_SALES: json["DAYLY_SALES"],
      MONTHLY_SALES: json["MONTHLY_SALES"],
      KAISYU_RUIKEI: json["KAISYU_RUIKEI"],
      DEL_FLG: json["DEL_FLG"],
      ADD_PGID: json["ADD_PGID"],
      ADD_TANTCD: json["ADD_TANTCD"],
      ADD_YMD: json['ADD_YMD'],
      UPD_PGID: json["UPD_PGID"],
      UPD_TANTCD: json["UPD_TANTCD"],
      UPD_YMD: json["UPD_YMD"],
    );
  }

  @override
  List<Object?> get props => [
        TANT_CD,
        TANT_NAME,
        TANT_KNAME,
        BUZAI_HACOK_FLG,
        SYOZOKUBUSYO_CD,
        PASSWORD,
        PASSWORD_UPD_YMD,
        MENUPTN_CD,
        TANT_KBN_CD,
        SYOZOKU_CD,
        KENGEN_CD,
        DAYLY_SALES,
        MONTHLY_SALES,
        KAISYU_RUIKEI,
        DEL_FLG,
        ADD_PGID,
        ADD_TANTCD,
        ADD_YMD,
        UPD_PGID,
        UPD_TANTCD,
        UPD_YMD,
      ];
}
