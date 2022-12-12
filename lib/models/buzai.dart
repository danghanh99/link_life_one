class Buzai {
  final String? MAKER_NAME;
  final String? BUNRUI;
  final String? LOT;
  final String? HACYU_TANKA;
  final String? SURYO;
  final String? TANI_CD;
  final String? KINGAK;
  final String? HINBAN;
  final String? SYOHIN_NAME;
  final String? JISYA_CD;
  final String? BUZAI_HACYUMSAI_ID;
  final String? SYOZOKU_CD;
  bool STATUS;

  Buzai(
      {this.MAKER_NAME,
      this.BUNRUI,
      this.LOT,
      this.HACYU_TANKA,
      this.SURYO,
      this.TANI_CD,
      this.KINGAK,
      this.HINBAN,
      this.SYOHIN_NAME,
      this.JISYA_CD,
      this.BUZAI_HACYUMSAI_ID,
      this.SYOZOKU_CD,
      this.STATUS = false});

  factory Buzai.fromJson(Map<String, dynamic> json) {
    return Buzai(
      MAKER_NAME: json['MAKER_NAME'] ?? '',
      BUNRUI: json['BUNRUI'] ?? '',
      LOT: json['LOT'] ?? '',
      HACYU_TANKA: json['HACYU_TANKA'] ?? '',
      SURYO: json['SURYO'] ?? '',
      TANI_CD: json['TANI_CD'] ?? '',
      KINGAK: json['KINGAK'] ?? '',
      HINBAN: json['HINBAN'] ?? '',
      SYOHIN_NAME: json['SYOHIN_NAME'] ?? '',
      JISYA_CD: json['JISYA_CD'] ?? '',
      BUZAI_HACYUMSAI_ID: json['BUZAI_HACYUMSAI_ID'] ?? '',
      SYOZOKU_CD: json['SYOZOKU_CD'] ?? '',
    );
  }
}
