class Buzai {
  final String? BUZAI_KANRI_NO;
  final String? BUZAI_BUNRUI;
  final String? MAKER_NAME;
  final String? HINBAN;
  final String? SYOHIN_NAME;
  bool STATUS;

  Buzai(
      {this.MAKER_NAME,
      this.BUZAI_KANRI_NO,
      this.BUZAI_BUNRUI,
      this.HINBAN,
      this.SYOHIN_NAME,
      this.STATUS = false});

  factory Buzai.fromJson(Map<String, dynamic> json) {
    return Buzai(
      MAKER_NAME: json['BUZAI_MAKER_NAME'] ?? '',
      HINBAN: json['BUZAI_HINBAN'] ?? '',
      SYOHIN_NAME: json['SYOHIN_NAME'] ?? json['BUZAI_SYOHIN_NAME'] ?? '',
      BUZAI_KANRI_NO: json['BUZAI_KANRI_NO'] ?? '',
      BUZAI_BUNRUI: json['BUZAI_BUNRUI'] ?? '',
    );
  }
}
