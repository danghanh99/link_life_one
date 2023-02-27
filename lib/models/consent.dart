class ConsentModel {
  String? singleSummarize;
  String? jyucyuId;
  String? biko;
  String? kensetukeitai;
  String? befSekoPhotoFilePath;
  String? aftSekoPhotoFilePath;
  String? otherSekoPhotoFilePath;
  List<CheckFlagList>? checkFlagList;
  List<TableDetailModel>? tableDetails;

  ConsentModel(
      {this.singleSummarize,
      this.jyucyuId,
      this.biko,
      this.kensetukeitai,
      this.befSekoPhotoFilePath,
      this.aftSekoPhotoFilePath,
      this.otherSekoPhotoFilePath,
      this.checkFlagList,
      this.tableDetails});

  ConsentModel.fromJson(Map<String, dynamic> json) {
    singleSummarize = json['SINGLE_SUMMARIZE'];
    jyucyuId = json['JYUCYU_ID'];
    biko = json['BIKO'];
    kensetukeitai = json['KENSETU_KEITAI'];
    befSekoPhotoFilePath = json['BEF_SEKO_PHOTO_FILEPATH'];
    aftSekoPhotoFilePath = json['AFT_SEKO_PHOTO_FILEPATH'];
    otherSekoPhotoFilePath = json['OTHER_PHOTO_FOLDERPATH'];
    if (json['CHECK_FLG'] != null) {
      checkFlagList = [];
      json['CHECK_FLG'].forEach((v) {
        checkFlagList?.add(CheckFlagList.fromJson(v));
      });
    }
    if (json['NEW_DETAIL'] != null) {
      tableDetails = [];
      json['NEW_DETAIL'].forEach((v) {
        tableDetails?.add(TableDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SINGLE_SUMMARIZE'] = singleSummarize;
    data['JYUCYU_ID'] = jyucyuId;
    data['BIKO'] = biko;
    data['KENSETU_KEITAI'] = kensetukeitai;
    data['BEF_SEKO_PHOTO_FILEPATH'] = befSekoPhotoFilePath;
    data['AFT_SEKO_PHOTO_FILEPATH'] = aftSekoPhotoFilePath;
    data['OTHER_PHOTO_FOLDERPATH'] = otherSekoPhotoFilePath;
    if (checkFlagList != null) {
      data['CHECK_FLG'] = checkFlagList?.map((v) => v.toJson()).toList();
    }
    if (tableDetails != null) {
      data['NEW_DETAIL'] = tableDetails?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckFlagList {
  String? checkFlag1;
  String? checkFlag2;
  String? checkFlag3;
  String? checkFlag4;
  String? checkFlag5;
  String? checkFlag6;
  String? checkFlag7;
  String? checkFlag8;

  CheckFlagList(
      {this.checkFlag1,
      this.checkFlag2,
      this.checkFlag3,
      this.checkFlag4,
      this.checkFlag5,
      this.checkFlag6,
      this.checkFlag7,
      this.checkFlag8});

  CheckFlagList.fromJson(Map<String, dynamic> json) {
    checkFlag1 = json['CHECK_FLG1'];
    checkFlag2 = json['CHECK_FLG2'];
    checkFlag3 = json['CHECK_FLG3'];
    checkFlag4 = json['CHECK_FLG4'];
    checkFlag5 = json['CHECK_FLG5'];
    checkFlag6 = json['CHECK_FLG6'];
    checkFlag7 = json['CHECK_FLG7'];
    checkFlag8 = json['CHECK_FLG8'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CHECK_FLG1'] = checkFlag1;
    data['CHECK_FLG2'] = checkFlag2;
    data['CHECK_FLG3'] = checkFlag3;
    data['CHECK_FLG4'] = checkFlag4;
    data['CHECK_FLG5'] = checkFlag5;
    data['CHECK_FLG6'] = checkFlag6;
    data['CHECK_FLG7'] = checkFlag7;
    return data;
  }
}

class TableDetailModel {
  String? suryo;
  String? hanbaitanka;
  String? kingak;
  String? tuikajisyaCode;
  String? tuikasyohinName;

  TableDetailModel(
      {this.suryo,
      this.hanbaitanka,
      this.kingak,
      this.tuikajisyaCode,
      this.tuikasyohinName});

  TableDetailModel.fromJson(Map<String, dynamic> json) {
    suryo = json['SURYO'] ?? '';
    hanbaitanka = json['HANBAI_TANKA'] ?? '';
    kingak = json['KINGAK'] ?? '';
    tuikajisyaCode = json['TUIKA_JISYA_CD'] ?? '';
    tuikasyohinName = json['TUIKA_SYOHIN_NAME'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SURYO'] = suryo;
    data['HANBAI_TANKA'] = hanbaitanka;
    data['KINGAK'] = kingak;
    data['TUIKA_JISYA_CD'] = tuikajisyaCode;
    data['TUIKA_SYOHIN_NAME'] = tuikasyohinName;
    return data;
  }
}
