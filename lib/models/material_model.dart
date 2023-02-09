import 'package:link_life_one/models/default_inventory.dart';

class MaterialModel {
  String? syukkoId;
  String? ctgoryName;
  String? makerName;
  String? jisyaCode;
  String? syoshinName;
  String? jissu;
  String? suryo;
  String? ctgoryCode;
  String? makerCode;
  String? genka;
  String? basyoGyosyaSybetCode;
  String? sokoCode;
  String? zaikoSybetCode;
  String? zaikoId;

  MaterialModel({
    this.syukkoId,
    this.ctgoryName,
    this.makerName,
    this.jisyaCode,
    this.syoshinName,
    this.jissu,
    this.suryo,
    this.ctgoryCode,
    this.makerCode,
    this.genka,
    this.basyoGyosyaSybetCode,
    this.sokoCode,
    this.zaikoSybetCode,
    this.zaikoId
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
    syukkoId: json['SYUKKO_ID'] ?? '',
    ctgoryName: json['CTGORY_NAME'] ?? '',
    makerName: json['MAKER_NAME'] ?? '',
    jisyaCode: json['JISYA_CD'] ?? '',
    syoshinName: json['SYOHIN_NAME'] ?? '',
    jissu: json['JISSU'] ?? '',
    suryo: json['SURYO'] ?? '',
    ctgoryCode: json['CTGORY_CD'] ?? '',
    makerCode: json['MAKER_CD'] ?? '',
    genka: json['GENKA'] ?? '',
    basyoGyosyaSybetCode: json['BASYO_GYOSYA_SYBET_CD'] ?? '',
    sokoCode: json['SOKO_CD'] ?? '',
    zaikoSybetCode: json['ZAIKO_SYBET_CD'] ?? '',
    zaikoId: json['ZAIKO_ID'] ?? '',
  );

  factory MaterialModel.fromDefaultInventory(DefaultInventory inventory) => MaterialModel(
    ctgoryName: inventory.categoryName,
    makerName: inventory.makerName,
    jisyaCode: inventory.jisyaCode,
    syoshinName: inventory.syoshinName,
    jissu: inventory.jissu,
    suryo: ''
  );
}