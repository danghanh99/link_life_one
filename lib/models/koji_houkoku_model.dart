import 'package:hive_flutter/hive_flutter.dart';

part 'koji_houkoku_model.g.dart';


@HiveType(typeId: 5)
class KojiHoukokuModel extends HiveObject {
  @HiveField(0)
  String? jyucyuMsaiId;
  @HiveField(1)
  String? jyucyuMsaiIdKikan;
  @HiveField(2)
  String? hinban;
  @HiveField(3)
  String? makerCd;
  @HiveField(4)
  String? ctgoryCd;
  @HiveField(5)
  String? suryo;
  @HiveField(6)
  String? kingak;
  @HiveField(7)
  String? kisetuHinban;
  @HiveField(8)
  String? kisetuMaker;
  @HiveField(9)
  String? kisetuMakerCd;
  @HiveField(10)
  String? kensetuKeitai;
  @HiveField(11)
  String? befSekiPhotoFilePath;
  @HiveField(12)
  String? aftSekoPhotoFilePath;
  @HiveField(13)
  List<String>? otherPhotoFolderPath;
  @HiveField(14)
  String? tuikaJisyaCd;
  @HiveField(15)
  String? tuikaSyohinName;
  @HiveField(16)
  String? kojijiTuikaFlg;
  @HiveField(17)
  String? kojiSt;
  @HiveField(18)
  String? hojinFlg;
  @HiveField(19)
  String? tenpoCd;


  bool isChangeBefore = false;
  bool isChangeAfter = false;
  bool isAddOthers = false;

  KojiHoukokuModel(
      {this.jyucyuMsaiId,
      this.jyucyuMsaiIdKikan,
      this.hinban,
      this.makerCd,
      this.ctgoryCd,
      this.suryo,
      this.kingak,
      this.kisetuHinban,
      this.kisetuMaker,
      this.kisetuMakerCd,
      this.kensetuKeitai,
      this.befSekiPhotoFilePath,
      this.aftSekoPhotoFilePath,
      this.otherPhotoFolderPath,
      this.tuikaJisyaCd,
      this.tuikaSyohinName,
      this.kojijiTuikaFlg,
      this.kojiSt,
      this.hojinFlg,
      this.tenpoCd});

  KojiHoukokuModel.empty() {
    jyucyuMsaiId = '';
    jyucyuMsaiIdKikan = '';
    hinban = '';
    makerCd = '';
    ctgoryCd = '';
    suryo = '';
    kingak = '';
    kisetuHinban = '';
    kisetuMaker = '';
    kisetuMakerCd = '';
    kensetuKeitai = '';
    befSekiPhotoFilePath = '';
    aftSekoPhotoFilePath = '';
    otherPhotoFolderPath = [];
    tuikaJisyaCd = '';
    tuikaSyohinName = '';
    kojijiTuikaFlg = '';
    kojiSt = '';
    hojinFlg = '';
    tenpoCd = '';
  }

  factory KojiHoukokuModel.fromJson(Map<String, dynamic> json) {
    List<String> otherFilePath = [];
    dynamic otherPath = json['OTHER_PHOTO_FOLDERPATH'];
    if (otherPath.runtimeType == String) {
      otherFilePath = [otherPath];
    }
    if (otherPath.runtimeType == List<String>) {
      otherFilePath = otherPath;
    }
    return KojiHoukokuModel(
    jyucyuMsaiId: json['JYUCYUMSAI_ID'],
    jyucyuMsaiIdKikan: json['JYUCYUMSAI_ID_KIKAN'],
    hinban: json['HINBAN'],
    makerCd: json['MAKER_CD'],
    ctgoryCd: json['CTGORY_CD'],
    suryo: json['SURYO'],
    kingak: json['KINGAK'],
    kisetuHinban: json['KISETU_HINBAN'],
    kisetuMaker: json['KISETU_MAKER'],
    kisetuMakerCd: json['KISETU_MAKER_CD'],
    kensetuKeitai: json['KENSETU_KEITAI'],
    befSekiPhotoFilePath: json['BEF_SEKO_PHOTO_FILEPATH'],
    aftSekoPhotoFilePath: json['AFT_SEKO_PHOTO_FILEPATH'],
    otherPhotoFolderPath: otherFilePath,
    tuikaJisyaCd: json['TUIKA_JISYA_CD'],
    tuikaSyohinName: json['TUIKA_SYOHIN_NAME'],
    kojijiTuikaFlg: json['KOJIJITUIKA_FLG'],
    kojiSt: json['KOJI_ST'],
    hojinFlg: json['HOJIN_FLG'],
    tenpoCd: json['TENPO_CD']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['JYUCYUMSAI_ID'] = jyucyuMsaiId;
    data['JYUCYUMSAI_ID_KIKAN'] = jyucyuMsaiIdKikan;
    data['HINBAN'] = hinban;
    data['MAKER_CD'] = makerCd;
    data['CTGORY_CD'] = ctgoryCd;
    data['SURYO'] = suryo;
    data['KINGAK'] = kingak;
    data['KISETU_HINBAN'] = kisetuHinban;
    data['KISETU_MAKER'] = kisetuMaker;
    data['KISETU_MAKER_CD'] = kisetuMakerCd;
    data['KENSETU_KEITAI'] = kensetuKeitai;
    data['BEF_SEKO_PHOTO_FILEPATH'] = befSekiPhotoFilePath;
    data['AFT_SEKO_PHOTO_FILEPATH'] = aftSekoPhotoFilePath;
    data['OTHER_PHOTO_FOLDERPATH'] = otherPhotoFolderPath;
    data['TUIKA_JISYA_CD'] = tuikaJisyaCd;
    data['TUIKA_SYOHIN_NAME'] = tuikaSyohinName;
    data['KOJIJITUIKA_FLG'] = kojijiTuikaFlg;
    data['KOJI_ST'] = kojiSt;
    data['HOJIN_FLG'] = hojinFlg;
    data['TENPO_CD'] = tenpoCd;
    return data;
  }

  bool get isEmpty {
    return jyucyuMsaiId == '' &&
        jyucyuMsaiIdKikan == '' &&
        hinban == '' &&
        makerCd == '' &&
        ctgoryCd == '' &&
        suryo == '' &&
        kingak == '' &&
        kisetuHinban == '' &&
        kisetuMaker == '' &&
        kisetuMakerCd == '' &&
        kensetuKeitai == '' &&
        befSekiPhotoFilePath == '' &&
        aftSekoPhotoFilePath == '' &&
        otherPhotoFolderPath!.isEmpty &&
        tuikaJisyaCd == '' &&
        tuikaSyohinName == '' &&
        kojijiTuikaFlg == '' &&
        kojiSt == '' &&
        hojinFlg == '' &&
        tenpoCd == '';
  }
}
