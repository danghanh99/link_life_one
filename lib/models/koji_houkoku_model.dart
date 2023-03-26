class KojiHoukokuModel {
  String? jyucyuMsaiId;
  String? jyucyuMsaiIdKikan;
  String? hinban;
  String? makerCd;
  String? ctgoryCd;
  String? suryo;
  String? kingak;
  String? kisetuHinban;
  String? kisetuMaker;
  String? kisetuMakerCd;
  String? kensetuKeitai;
  String? befSekiPhotoFilePath;
  String? aftSekoPhotoFilePath;
  List<String>? otherPhotoFolderPath;
  String? tuikaJisyaCd;
  String? tuikaSyohinName;
  String? kojijiTuikaFlg;
  String? kojiSt;
  String? hojinFlg;
  String? tenpoCd;

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
        otherPhotoFolderPath == '' &&
        tuikaJisyaCd == '' &&
        tuikaSyohinName == '' &&
        kojijiTuikaFlg == '' &&
        kojiSt == '' &&
        hojinFlg == '' &&
        tenpoCd == '';
  }
}
