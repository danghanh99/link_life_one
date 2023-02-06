
class InventorySchedule {
  String? nyukoId;
  String? nyukoYoteiYMD;
  String? ctgoryName;
  String? makerName;
  String? jisyaCode;
  String? syohinName;
  String? suryo;
  String? setsakiName;
  String? kojiYMD;

  InventorySchedule(
      {this.nyukoId,
      this.nyukoYoteiYMD,
      this.ctgoryName,
      this.makerName,
      this.jisyaCode,
      this.syohinName,
      this.suryo,
      this.setsakiName,
      this.kojiYMD});

  factory InventorySchedule.fromJson(Map json) => InventorySchedule(
        nyukoId: json['NYUKO_ID'] ?? '',
        nyukoYoteiYMD: json['NYUKO_YOTEI_YMD'],
        ctgoryName: json['CTGORY_NAME'] ?? '',
        makerName: json['MAKER_NAME'] ?? '',
        jisyaCode: json['JISYA_CD'] ?? '',
        syohinName: json['SYOHIN_NAME'] ?? '',
        suryo: json['SURYO'] ?? '',
        setsakiName: json['SETSAKI_NAME'] ?? '',
        kojiYMD: json['KOJI_YMD'],
      );
}
