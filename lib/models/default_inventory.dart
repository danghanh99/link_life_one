class DefaultInventory {
  String? zaikoId;
  String? categoryName;
  String? makerName;
  String? jisyaCode;
  String? syoshinName;
  String? jissu;
  String? hikiZumiSu;
  int? zaikoSu;

  DefaultInventory(
      {this.zaikoId,
      this.categoryName,
      this.makerName,
      this.jisyaCode,
      this.syoshinName,
      this.jissu,
      this.hikiZumiSu,
      this.zaikoSu});

  factory DefaultInventory.fromJson(Map<String, dynamic> json) =>
      DefaultInventory(
          zaikoId: json['ZAIKO_ID'] ?? '',
          categoryName: json['CTGORY_NAME'] ?? '',
          makerName: json['MAKER_NAME'] ?? '',
          jisyaCode: json['JISYA_CD'] ?? json['HINBAN'] ?? '',
          syoshinName: json['SYOHIN_NAME'] ?? '',
          jissu: json['JISSU'] ?? '',
          hikiZumiSu: json['HIKI_ZUMI_SU'] ?? '',
          zaikoSu: json['ZAIKO_SU'] ?? 0
      );

  factory DefaultInventory.fromQRJson(Map<String, dynamic> json) =>
      DefaultInventory(
          zaikoId: '',
          categoryName: json['CTGORY_NAME'] ?? '',
          makerName: json['MAKER_NAME'] ?? '',
          jisyaCode: json['HINBAN'] ?? '',
          syoshinName: json['SYOHIN_NAME'] ?? '',
          jissu: '${json['JISSU']}' ?? '',
          hikiZumiSu: json['HIKI_ZUMI_SU'] ?? '',
          zaikoSu: json['ZAIKO_SU'] ?? 0
      );
}
