import 'dart:convert';
import 'dart:io';

import 'package:link_life_one/models/koji_houkoku_model.dart';

class ConsentModel {
  String? singleSummarize;
  String? loginId;
  String? jyucyuId;
  String? biko;
  String? kensetukeitai;
  List<CheckFlagList>? checkFlagList;
  List<TableDetailModel>? tableDetails;
  List<KojiHoukokuModel>? kojiHoukoku;

  ConsentModel(
      {this.singleSummarize,
      this.loginId,
      this.jyucyuId,
      this.biko,
      this.kensetukeitai,
      this.checkFlagList,
      this.tableDetails,
      this.kojiHoukoku});

  ConsentModel.fromJson(Map<String, dynamic> json) {
    singleSummarize = json['SINGLE_SUMMARIZE'];
    loginId = json['LOGIN_ID'];
    jyucyuId = json['JYUCYU_ID'];
    biko = json['BIKO'];
    kensetukeitai = json['KENSETU_KEITAI'];
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
    kojiHoukoku = json['KOJI_HOUKOKU'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SINGLE_SUMMARIZE'] = singleSummarize;
    data['LOGIN_ID'] = loginId;
    data['JYUCYU_ID'] = jyucyuId;
    data['BIKO'] = biko;
    data['KENSETU_KEITAI'] = kensetukeitai;
    if (checkFlagList != null) {
      data['CHECK_FLG'] = checkFlagList?.map((v) => v.toJson()).toList();
    }
    if (tableDetails != null) {
      data['NEW_DETAIL'] = tableDetails?.map((v) => v.toJson()).toList();
    }
    if (kojiHoukoku != null) {
      List<Map<String, dynamic>> listKojiHoukoku = [];
      for (var element in kojiHoukoku!) {
        if (element.isEmpty) {
          continue;
        }
        Map<String, dynamic> jsonElement = element.toJson();
        String befPath = jsonElement['BEF_SEKO_PHOTO_FILEPATH'];
        if (!isNetworkPath(befPath) && befPath != '') {
          jsonElement['BEF_SEKO_PHOTO_FILEPATH'] = base64String(befPath);
        }
        String aftPath = jsonElement['AFT_SEKO_PHOTO_FILEPATH'];
        if (!isNetworkPath(aftPath) && aftPath != '') {
          jsonElement['AFT_SEKO_PHOTO_FILEPATH'] = base64String(aftPath);
        }
        List<String> otherImages = jsonElement['OTHER_PHOTO_FOLDERPATH'];
        for (var i = 0; i < otherImages.length; i++) {
          String item = otherImages.elementAt(i);
          if (!isNetworkPath(item) && item.isNotEmpty) {
            otherImages[i] = base64String(item);
          }
        }
        jsonElement['OTHER_PHOTO_FOLDERPATH'] = otherImages;
        listKojiHoukoku.add(jsonElement);
      }
      data['KOJI_HOUKOKU'] = listKojiHoukoku;
    }
    return data;
  }

  String base64String(String filePath) {
    File imageFile = File(filePath);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  bool isNetworkPath(String path) {
    final uri = Uri.parse(path);
    return uri.scheme.startsWith('http') || uri.scheme.startsWith('ftp');
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
