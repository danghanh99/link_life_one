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
  String? autoFlg;

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
    this.zaikoId,
    this.autoFlg = '0'
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
    autoFlg: json['AUTO_FLG'] ?? '0',
  );

  factory MaterialModel.fromDefaultInventory(DefaultInventory inventory) => MaterialModel(
    ctgoryName: inventory.categoryName,
    makerName: inventory.makerName,
    jisyaCode: inventory.jisyaCode,
    syoshinName: inventory.syoshinName,
    jissu: (inventory.jissu??'').isEmpty ? '${inventory.zaikoSu}' : inventory.jissu,
    suryo: ''
  );

  factory MaterialModel.fromDefaultInventoryWithSuryo(DefaultInventory inventory, int suryo) => MaterialModel(
      ctgoryName: inventory.categoryName,
      makerName: inventory.makerName,
      jisyaCode: inventory.jisyaCode,
      syoshinName: inventory.syoshinName,
      jissu: (inventory.jissu??'').isEmpty ? '${inventory.zaikoSu}' : inventory.jissu,
      suryo: '$suryo'
  );

  Map<String, dynamic> toJson() => {
    'SYUKKO_ID': syukkoId ?? '',
    'CTGORY_CD': ctgoryCode ?? '',
    'CTGORY_NAME': ctgoryName ?? '',
    'MAKER_CD': makerCode ?? '',
    'MAKER_NAME': makerName ?? '',
    'JISYA_CD': jisyaCode ?? '',
    'SYOHIN_NAME': syoshinName ?? '',
    'GENKA': genka ?? '',
    'SURYO': suryo ?? '',
    'BASYO_GYOSYA_SYBET_CD': basyoGyosyaSybetCode ?? '',
    'SOKO_CD': sokoCode ?? '',
    'ZAIKO_SYBET_CD': zaikoSybetCode ?? '',
    'ZAIKO_ID': zaikoId ?? '',
    'AUTO_FLG': autoFlg ?? '',
  };
}