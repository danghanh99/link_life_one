import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 't_kojimsai.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class TKojimsai extends HiveObject{

  TKojimsai({
    required this.jyucyuId,
    required this.jyucyumsaiId,
    this.jyucyumsaiIdKikan,
    this.hinban,
    this.makerCd,
    this.ctgotyCd,
    this.suryo,
    this.hanbaiTanka,
    this.kingak,
    this.kisetuHinban,
    this.kisetuMaker,
    this.kensetuKeitai,
    this.befSekoPhotoFilePath,
    this.aftSekoPhotoFilePath,
    this.otherPhotoFolderPath,
    this.tuikaJisyaCd,
    this.tuikaSyohinName,
    this.kojijituikaFlg,
    this.delFlg,
    this.renkeiYMD,
    this.addPGID,
    this.addTantCd,
    this.addYMD,
    this.updPGID,
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
  dynamic otherPhotoFolderPath;
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

  factory TKojimsai.fromRequest(Map<String, dynamic> json) {
    List<String> otherFilePath = [];
    dynamic otherPath = json['OTHER_PHOTO_FOLDERPATH'];
    if (otherPath.runtimeType == String) {
      otherFilePath = [otherPath];
    }
    if (otherPath.runtimeType == List<String>) {
      otherFilePath = otherPath;
    }
    return TKojimsai(
      jyucyuId: json['JYUCYU_ID'] as String,
      jyucyumsaiId: json['JYUCYUMSAI_ID'] as String,
      jyucyumsaiIdKikan: json['JYUCYUMSAI_ID_KIKAN'] as String?,
      hinban: json['HINBAN'] as String?,
      makerCd: json['MAKER_CD'] as String?,
      ctgotyCd: json['CTGORY_CD'] as String?,
      suryo: json['SURYO'] as String?,
      hanbaiTanka: json['HANBAI_TANKA'] as String?,
      kingak: json['KINGAK'] as String?,
      kisetuHinban: json['KISETU_HINBAN'] as String?,
      kisetuMaker: json['KISETU_MAKER'] as String?,
      kensetuKeitai: json['KENSETU_KEITAI'] as String?,
      befSekoPhotoFilePath: json['BEF_SEKO_PHOTO_FILEPATH'] as String?,
      aftSekoPhotoFilePath: json['AFT_SEKO_PHOTO_FILEPATH'] as String?,
      otherPhotoFolderPath: otherFilePath,
      tuikaJisyaCd: json['TUIKA_JISYA_CD'] as String?,
      tuikaSyohinName: json['TUIKA_SYOHIN_NAME'] as String?,
      kojijituikaFlg: json['KOJIJITUIKA_FLG'] as String?,
      delFlg: json['DEL_FLG'] as String?,
      renkeiYMD: json['RENKEI_YMD'] as String?,
      addPGID: json['ADD_PGID'] as String?,
      addTantCd: json['ADD_TANTCD'] as String?,
      addYMD: json['ADD_YMD'] as String?,
      updPGID: json['UPD_PGID'] as String?,
      updTantCd: json['UPD_TANTCD'] as String,
      updYMD: json['UPD_YMD'] as String,
    );
  }

}