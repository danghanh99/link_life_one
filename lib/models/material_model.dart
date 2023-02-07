class MaterialModel {
  String? ctgoryName;
  String? makerName;
  String? jisyaCode;
  String? syoshinName;
  String? jissu;
  String? suryo;
  MaterialModel({
    this.ctgoryName,
    this.makerName,
    this.jisyaCode,
    this.syoshinName,
    this.jissu,
    this.suryo
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
    ctgoryName: json['CTGORY_NAME'] ?? '',
    makerName: json['MAKER_NAME'] ?? '',
    jisyaCode: json['JISYA_CD'] ?? '',
    syoshinName: json['SYOHIN_NAME'] ?? '',
    jissu: json['JISSU'] ?? '',
    suryo: json['SURYO'] ?? '',
  );
}