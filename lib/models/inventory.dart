class Inventory {
  final String? buzaiKanriGoban;
  final String? hinban;
  final String? shohinmei;
  final String? sengetsuJitsuZaiko;
  final String? bunrui;
  final int? tanka;
  final String? shukkoSuuryou;
  final String? hacchuuSuuryou;
  final String? haibanFlg;
  int? tougetsuJitsuZaiko;
  final String? meekaa;
  bool STATUS;
  bool isFromDatabase;
  String? tanaId;
  String? tanamsaiId;
  String? tanaYmd;
  String? monthlyKeizoYm;
  String? basyoGyosyaSybetCd;
  String? sokoCd;
  String? syozokuCd;
  String? buzaiSiireName;
  String? buzaiSiireTanka;
  String? buzaiSoryo;
  String? buzaiHcyuId;

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
      this.meekaa,
      this.haibanFlg,
      this.tanaId,
      this.tanamsaiId,
      this.tanaYmd,
      this.monthlyKeizoYm,
      this.basyoGyosyaSybetCd,
      this.sokoCd,
      this.syozokuCd,
      this.buzaiSiireName,
      this.buzaiSiireTanka,
      this.buzaiSoryo,
      this.buzaiHcyuId,
      this.STATUS = false,
      this.isFromDatabase = false});

  factory Inventory.fromJson(Map<String, dynamic> json, {bool isFromDatabase = false}) {
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
        haibanFlg: json['HAIBAN_FLG'] ?? '0',
        meekaa: json['MAKER_NAME'] ?? json['BUZAI_MAKER_NAME'] ?? '',
        tanaId: json['TANA_ID'] ?? '',
        tanamsaiId: json['TANAMSAI_ID'] ?? '',
        tanaYmd: json['TANA_YMD'] ?? '',
        monthlyKeizoYm: json['MONTHLY_KEIJO_YM'] ?? '',
        basyoGyosyaSybetCd: json['BASYO_GYOSYA_SYBET_CD'] ?? '',
        sokoCd: json['SOKO_CD'] ?? '',
        syozokuCd: json['SYOZOKU_CD'] ?? '',
        buzaiSiireName: json['BUZAI_SIIRE_NAME'] ?? '',
        buzaiSiireTanka: json['BUZAI_SIIRE_TANKA'] ?? '',
        buzaiSoryo: json['BUZAI_SORYO'] ?? '',
        buzaiHcyuId: json['BUZAI_HACYU_ID'] ?? '',
        isFromDatabase: isFromDatabase
    );
  }
}
