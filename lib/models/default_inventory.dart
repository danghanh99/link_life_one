class DefaultInventory {
  String? zaikoId;
  String? categoryName;
  String? makerName;
  String? jisyaCode;
  String? syoshinName;
  String? jissu;

  DefaultInventory(
      {this.zaikoId,
      this.categoryName,
      this.makerName,
      this.jisyaCode,
      this.syoshinName,
      this.jissu});

  factory DefaultInventory.fromJson(Map<String, dynamic> json) =>
      DefaultInventory(
          zaikoId: '',
          categoryName: json['CTGORY_NAME'] ?? '',
          makerName: json['MAKER_NAME'] ?? '',
          jisyaCode: json['HINBAN'] ?? '',
          syoshinName: json['SYOHIN_NAME'] ?? '',
          jissu: json['JISSU'] ?? '');
}
