class ScheduleItem {
  String? jyucyuId;
  String? ymd;
  String? simatiYmd;
  String? kojiYmd;
  String? homonTantCd1;
  String? homonTantCd2;
  String? homonTantCd3;
  String? homonTantCd4;
  String? tantName1;
  String? tantName2;
  String? tantName3;
  String? tantName4;
  String? setsakiName;
  String? setsakiAddress;
  String? kojiJinin;
  String? jinin;
  String? homonSbt;
  String? kojiSt;
  String? kojiItem;
  String? sitamiKansanPoint;
  String? kojiKansanPoint;
  String? jikan;
  String? kojiJikan;
  String? kojiKekka;
  String? tenpoCd;
  String? hojinFlg;
  String? mallCd;
  String? kojigyosyaCd;
  String? tagKbn;
  String? homonjikan;
  String? homonjikanEnd;
  String? kojihomonjikan;
  String? kojihomonjikanEnd;
  String? kojiiraisyoFilepath;
  String? sitamiiraisyoFilepath;
  String? cancelRiyu;
  String? sitamiapoKbn;
  String? kojiapoKbn;
  String? mtmoriYmd;
  String? memo;
  String? comment;
  String? readFlg;
  String? atobarai;
  String? biko;
  String? syuyakuJyucyuId;
  String? reportFlg;
  String? sitamiReport;
  String? allDayFlg;
  String? coName;
  String? coPostno;
  String? coAddress;
  String? kojiItakuhi;
  String? skjRenkeiYmd;
  String? kojiRenkeiYmd;
  String? addTantnm;
  String? addYmd;
  String? updTantnm;
  String? updYmd;
  String? kbnCd;
  String? kbnName;
  String? kbnBiko;
  String? kbnmsaiCd;
  String? kbnmsaiName;
  String? kbnmsaiBiko;
  String? yobikomoku1;
  String? yobikomoku2;
  String? yobikomoku3;
  String? yobikomoku4;
  String? yobikomoku5;
  List<String>? filepath;

  ScheduleItem({
    this.jyucyuId,
    this.ymd,
    this.simatiYmd,
    this.kojiYmd,
    this.homonTantCd1,
    this.homonTantCd2,
    this.homonTantCd3,
    this.homonTantCd4,
    this.tantName1,
    this.tantName2,
    this.tantName3,
    this.tantName4,
    this.setsakiName,
    this.setsakiAddress,
    this.kojiJinin,
    this.jinin,
    this.homonSbt,
    this.kojiSt,
    this.kojiItem,
    this.sitamiKansanPoint,
    this.kojiKansanPoint,
    this.jikan,
    this.kojiJikan,
    this.kojiKekka,
    this.tenpoCd,
    this.hojinFlg,
    this.mallCd,
    this.kojigyosyaCd,
    this.tagKbn,
    this.homonjikan,
    this.homonjikanEnd,
    this.kojihomonjikan,
    this.kojihomonjikanEnd,
    this.kojiiraisyoFilepath,
    this.sitamiiraisyoFilepath,
    this.cancelRiyu,
    this.sitamiapoKbn,
    this.kojiapoKbn,
    this.mtmoriYmd,
    this.memo,
    this.comment,
    this.readFlg,
    this.atobarai,
    this.biko,
    this.syuyakuJyucyuId,
    this.reportFlg,
    this.sitamiReport,
    this.allDayFlg,
    this.coName,
    this.coPostno,
    this.coAddress,
    this.kojiItakuhi,
    this.skjRenkeiYmd,
    this.kojiRenkeiYmd,
    this.addTantnm,
    this.addYmd,
    this.updTantnm,
    this.updYmd,
    this.kbnCd,
    this.kbnName,
    this.kbnBiko,
    this.kbnmsaiCd,
    this.kbnmsaiName,
    this.kbnmsaiBiko,
    this.yobikomoku1,
    this.yobikomoku2,
    this.yobikomoku3,
    this.yobikomoku4,
    this.yobikomoku5,
    this.filepath,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      jyucyuId: json['JYUCYU_ID'] ?? '',
      ymd: json['YMD'] ?? '',
      simatiYmd: json['SITAMI_YMD'] ?? '',
      kojiYmd: json['KOJI_YMD'] ?? '',
      homonTantCd1: json['HOMON_TANT_CD1'] ?? '',
      homonTantCd2: json['HOMON_TANT_CD2'] ?? '',
      homonTantCd3: json['HOMON_TANT_CD3'] ?? '',
      homonTantCd4: json['HOMON_TANT_CD4'] ?? '',
      tantName1: json['TANT_NAME1'] ?? '',
      tantName2: json['TANT_NAME2'] ?? '',
      tantName3: json['TANT_NAME3'] ?? '',
      tantName4: json['TANT_NAME4'] ?? '',
      setsakiName: json['SETSAKI_NAME'] ?? '',
      setsakiAddress: json['SETSAKI_ADDRESS'] ?? '',
      kojiJinin: json['KOJI_JININ'] ?? '',
      jinin: json['JININ'] ?? '',
      homonSbt: json['HOMON_SBT'] ?? '',
      kojiSt: json['KOJI_ST'] ?? '',
      kojiItem: json['KOJI_ITEM'] ?? '',
      sitamiKansanPoint: json['SITAMI_KANSAN_POINT'] ?? '',
      kojiKansanPoint: json['KOJI_KANSAN_POINT'] ?? '',
      jikan: json['JIKAN'] ?? '',
      kojiJikan: json['KOJI_JIKAN'] ?? '',
      kojiKekka: json['KOJI_KEKKA'] ?? '',
      tenpoCd: json['TENPO_CD'] ?? '',
      hojinFlg: json['HOJIN_FLG'] ?? '',
      mallCd: json['MALL_CD'] ?? '',
      kojigyosyaCd: json['KOJIGYOSYA_CD'] ?? '',
      tagKbn: json['TAG_KBN'] ?? '',
      homonjikan: json['HOMONJIKAN'] ?? '',
      homonjikanEnd: json['HOMONJIKAN_END'] ?? '',
      kojihomonjikan: json['KOJIHOMONJIKAN'] ?? '',
      kojihomonjikanEnd: json['KOJIHOMONJIKAN_END'] ?? '',
      kojiiraisyoFilepath: json['KOJIIRAISYO_FILEPATH'] ?? '',
      sitamiiraisyoFilepath: json['SITAMIIRAISYO_FILEPATH'] ?? '',
      cancelRiyu: json['CANCEL_RIYU'] ?? '',
      sitamiapoKbn: json['SITAMIAPO_KBN'] ?? '',
      kojiapoKbn: json['KOJIAPO_KBN'] ?? '',
      mtmoriYmd: json['MTMORI_YMD'] ?? '',
      memo: json['MEMO'] ?? '',
      comment: json['COMMENT'] ?? '',
      readFlg: json['READ_FLG'] ?? '',
      atobarai: json['ATOBARAI'] ?? '',
      biko: json['BIKO'] ?? '',
      syuyakuJyucyuId: json['SYUYAKU_JYUCYU_ID'] ?? '',
      reportFlg: json['REPORT_FLG'] ?? '',
      sitamiReport: json['SITAMI_REPORT'] ?? '',
      allDayFlg: json['ALL_DAY_FLG'] ?? '',
      coName: json['CO_NAME'] ?? '',
      coPostno: json['CO_POSTNO'] ?? '',
      coAddress: json['CO_ADDRESS'] ?? '',
      kojiItakuhi: json['KOJI_ITAKUHI'] ?? '',
      skjRenkeiYmd: json['SKJ_RENKEI_YMD'] ?? '',
      kojiRenkeiYmd: json['KOJI_RENKEI_YMD'] ?? '',
      addTantnm: json['ADD_TANTNM'] ?? '',
      addYmd: json['ADD_YMD'] ?? '',
      updTantnm: json['UPD_TANTNM'] ?? '',
      updYmd: json['UPD_YMD'] ?? '',
      kbnCd: json['KBN_CD'] ?? '',
      kbnName: json['KBN_NAME'] ?? '',
      kbnBiko: json['KBN_BIKO'] ?? '',
      kbnmsaiCd: json['KBNMSAI_CD'] ?? '',
      kbnmsaiName: json['KBNMSAI_NAME'] ?? '',
      kbnmsaiBiko: json['KBNMSAI_BIKO'] ?? '',
      yobikomoku1: json['YOBIKOMOKU1'] ?? '',
      yobikomoku2: json['YOBIKOMOKU2'] ?? '',
      yobikomoku3: json['YOBIKOMOKU3'] ?? '',
      yobikomoku4: json['YOBIKOMOKU4'] ?? '',
      yobikomoku5: json['YOBIKOMOKU5'] ?? '',
      filepath: List.from(json['FILEPATH']).map((e) => e.toString()).toList(),
    );
  }
}
