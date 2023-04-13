import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 't_kojimsai.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class TKojimsai extends HiveObject{

  TKojimsai({
    required this.jyucyuId,
    required this.jyucyumsaiId,
    required this.jyucyumsaiIdKikan,
    required this.hinban,
    required this.makerCd,
    required this.ctgotyCd,
    required this.suryo,
    required this.hanbaiTanka,
    required this.kingak,
    required this.kisetuHinban,
    required this.kisetuMaker,
    required this.kensetuKeitai,
    required this.befSekoPhotoFilePath,
    required this.aftSekoPhotoFilePath,
    required this.otherPhotoFolderPath,
    required this.tuikaJisyaCd,
    required this.tuikaSyohinName,
    required this.kojijituikaFlg,
    required this.delFlg,
    required this.renkeiYMD,
    required this.addPGID,
    required this.addTantCd,
    required this.addYMD,
    required this.updPGID,
    required this.updTantCd,
    required this.updYMD,
  });

  @HiveField(0)
  @JsonKey(name: 'JYUCYU_ID', required: true)
  String jyucyuId;
  @HiveField(1)
  @JsonKey(name: 'JYUCYUMSAI_ID', required: true)
  String jyucyumsaiId;
  @HiveField(2)
  @JsonKey(name: 'JYUCYUMSAI_ID_KIKAN', required: false)
  String? jyucyumsaiIdKikan;
  @HiveField(3)
  @JsonKey(name: 'HINBAN', required: false)
  String? hinban;
  @HiveField(4)
  @JsonKey(name: 'MAKER_CD', required: false)
  String? makerCd;
  @HiveField(5)
  @JsonKey(name: 'CTGORY_CD', required: false)
  String? ctgotyCd;
  @HiveField(6)
  @JsonKey(name: 'SURYO', required: false)
  String? suryo;
  @HiveField(7)
  @JsonKey(name: 'HANBAI_TANKA', required: false)
  String? hanbaiTanka;
  @HiveField(8)
  @JsonKey(name: 'KINGAK', required: false)
  String? kingak;
  @HiveField(9)
  @JsonKey(name: 'KISETU_HINBAN', required: false)
  String? kisetuHinban;
  @HiveField(10)
  @JsonKey(name: 'KISETU_MAKER', required: false)
  String? kisetuMaker;
  @HiveField(11)
  @JsonKey(name: 'KENSETU_KEITAI', required: false)
  String? kensetuKeitai;
  @HiveField(12)
  @JsonKey(name: 'BEF_SEKO_PHOTO_FILEPATH', required: false)
  String? befSekoPhotoFilePath;
  @HiveField(13)
  @JsonKey(name: 'AFT_SEKO_PHOTO_FILEPATH', required: false)
  String? aftSekoPhotoFilePath;
  @HiveField(14)
  @JsonKey(name: 'OTHER_PHOTO_FOLDERPATH', required: false)
  String? otherPhotoFolderPath;
  @HiveField(15)
  @JsonKey(name: 'TUIKA_JISYA_CD', required: false)
  String? tuikaJisyaCd;
  @HiveField(16)
  @JsonKey(name: 'TUIKA_SYOHIN_NAME', required: false)
  String? tuikaSyohinName;
  @HiveField(17)
  @JsonKey(name: 'KOJIJITUIKA_FLG', required: false)
  String? kojijituikaFlg;
  @HiveField(18)
  @JsonKey(name: 'DEL_FLG', required: false)
  String? delFlg;
  @HiveField(19)
  @JsonKey(name: 'RENKEI_YMD', required: false)
  String? renkeiYMD;
  @HiveField(20)
  @JsonKey(name: 'ADD_PGID', required: false)
  String? addPGID;
  @HiveField(21)
  @JsonKey(name: 'ADD_TANTCD', required: false)
  String? addTantCd;
  @HiveField(22)
  @JsonKey(name: 'ADD_YMD', required: false)
  String? addYMD;
  @HiveField(23)
  @JsonKey(name: 'UPD_PGID', required: false)
  String? updPGID;
  @HiveField(24)
  @JsonKey(name: 'UPD_TANTCD', required: true)
  String updTantCd;
  @HiveField(25)
  @JsonKey(name: 'UPD_YMD', required: true)
  String updYMD;

  factory TKojimsai.fromJson(Map<String, dynamic> json) => _$TKojimsaiFromJson(json);
  Map<String, dynamic> toJson() => _$TKojimsaiToJson(this);

}