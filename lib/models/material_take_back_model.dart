class MaterialTakeBackModel {
  String? syukkoId;
  String? ctgoryName;
  String? makerName;
  String? jisyaCode;
  String? syohinName;
  String? suryo;

  MaterialTakeBackModel(
      {this.syukkoId,
      this.ctgoryName,
      this.makerName,
      this.jisyaCode,
      this.syohinName,
      this.suryo});

  factory MaterialTakeBackModel.fromJson(Map json) => MaterialTakeBackModel(
        syukkoId: json['SYUKKO_ID'] ?? '',
        ctgoryName: json['CTGORY_NAME'] ?? '',
        makerName: json['MAKER_NAME'] ?? '',
        jisyaCode: json['JISYA_CD'] ?? '',
        syohinName: json['SYOHIN_NAME'] ?? '',
        suryo: json['SURYO'] ?? '',
      );
}