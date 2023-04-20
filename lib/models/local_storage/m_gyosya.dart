import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_gyosya.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class MGyosya extends HiveObject{

  MGyosya({
    required this.kojiGyosyaCd,
    required this.gyosyaKBNCd,
    required this.kojiGyosyaName,
    required this.jisyaLikeFlg,
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
  @JsonKey(name: 'KOJIGYOSYA_CD', required: true)
  String kojiGyosyaCd;
  @HiveField(1)
  @JsonKey(name: 'GYOSYA_KBN_CD', required: true)
  String gyosyaKBNCd;
  @HiveField(2)
  @JsonKey(name: 'KOJIGYOSYA_NAME', required: false)
  String? kojiGyosyaName;
  @HiveField(3)
  @JsonKey(name: 'JISYA_LIKE_FLG', required: false)
  String? jisyaLikeFlg;
  @HiveField(4)
  @JsonKey(name: 'DEL_FLG', required: false)
  String? delFlg;
  @HiveField(5)
  @JsonKey(name: 'ADD_PGID', required: true)
  String addPGID;
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
  @JsonKey(name: 'UPD_TANTCD', required: false)
  String? updTantCd;
  @HiveField(10)
  @JsonKey(name: 'UPD_YMD', required: false)
  String? updYMD;
  @HiveField(11)
  int? status = 0;

  factory MGyosya.fromJson(Map<String, dynamic> json) => _$MGyosyaFromJson(json);
  Map<String, dynamic> toJson() => _$MGyosyaToJson(this);

}