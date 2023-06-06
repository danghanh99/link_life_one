class Buzai {
  final String? BUZAI_KANRI_NO;
  final String? BUZAI_BUNRUI;
  final String? MAKER_NAME;
  final String? HINBAN;
  final String? SYOHIN_NAME;
  final String? jisyaCd;
  final String? kbnmsaiName;
  final String? jituzaikoSu;
  final String? syukkojisekiSuryo;
  final String? buzaihacyumsaiSuryo;
  final String? jissu;
  bool STATUS;

  Buzai(
      {this.MAKER_NAME,
      this.BUZAI_KANRI_NO,
      this.BUZAI_BUNRUI,
      this.HINBAN,
      this.SYOHIN_NAME,
      this.jisyaCd,
      this.kbnmsaiName,
      this.jituzaikoSu,
      this.syukkojisekiSuryo,
      this.buzaihacyumsaiSuryo,
      this.jissu,
      this.STATUS = false});

  factory Buzai.fromJson(Map<String, dynamic> json) {
    return Buzai(
      MAKER_NAME: json['BUZAI_MAKER_NAME'] ?? json['MAKER_NAME'] ?? '',
      HINBAN: json['BUZAI_HINBAN'] ?? json['HINBAN'] ?? '',
      SYOHIN_NAME: json['SYOHIN_NAME'] ?? json['BUZAI_SYOHIN_NAME'] ?? '',
      BUZAI_KANRI_NO: json['BUZAI_KANRI_NO'] ?? '',
      BUZAI_BUNRUI: json['BUZAI_BUNRUI'] ?? '',
      jisyaCd: json['JISYA_CD'] ?? '',
      kbnmsaiName: json['KBNMSAI_NAME'] ?? '',
      jituzaikoSu: '${json['JITUZAIKO_SU'] ?? '0'}',
      syukkojisekiSuryo: '${json['SYUKKOJISEKI_SURYO'] ?? '0'}',
      buzaihacyumsaiSuryo: '${json['BUZAIHACYUMSAI_SURYO'] ?? '0'}',
      jissu: '${json['JISSU'] ?? '0'}'
    );
  }
}
