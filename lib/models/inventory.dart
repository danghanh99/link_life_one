class Inventory {
  final String? buzaiKanriGoban;
  final String? hinban;
  final String? shohinmei;
  final String? sengetsuJitsuZaiko;
  final String? bunrui;
  final int? tanka;
  final String? shukkoSuuryou;
  final String? hacchuuSuuryou;
  int? tougetsuJitsuZaiko;
  final String? meekaa;

  Inventory(
      {this.buzaiKanriGoban,
      this.hinban,
      this.shohinmei,
      this.sengetsuJitsuZaiko,
      this.bunrui,
      this.tanka,
      this.shukkoSuuryou,
      this.hacchuuSuuryou,
      this.tougetsuJitsuZaiko,
      this.meekaa});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
        buzaiKanriGoban: json['BUZAI_KANRI_NO'] ?? '',
        hinban: json['HINBAN'] ?? '',
        shohinmei: json['SYOHIN_NAME'] ?? '',
        sengetsuJitsuZaiko: json['SENGETU_JITUZAIKO_SU'] ?? '',
        tougetsuJitsuZaiko: int.parse(json['JITUZAIKO_SU'] ?? '0'),
        bunrui: json['BUZAI_BUNRUI'] ?? '',
        tanka: int.parse(json['SIIRE_TANKA'] ?? '1'),
        shukkoSuuryou: json['SYUKKOJISEKI_SURYO'] ?? '',
        hacchuuSuuryou: json['BUZAIHACYUMSAI_SURYO'] ?? '',
        meekaa: json['MAKER_NAME'] ?? '');
  }
}
