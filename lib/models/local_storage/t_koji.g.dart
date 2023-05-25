// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_koji.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TKojiAdapter extends TypeAdapter<TKoji> {
  @override
  final int typeId = 9;

  @override
  TKoji read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TKoji(
      jyucyuId: fields[0] as String,
      sitamiYMD: fields[1] as String?,
      kojiYMD: fields[2] as String?,
      homonTantCd1: fields[3] as String?,
      homonTantName1: fields[4] as String?,
      homonTantCd2: fields[5] as String?,
      homonTantName2: fields[6] as String?,
      homonTantCd3: fields[7] as String?,
      homonTantName3: fields[8] as String?,
      homonTantCd4: fields[9] as String?,
      homonTantName4: fields[10] as String?,
      setsakiName: fields[11] as String?,
      setsakiAddress: fields[12] as String?,
      kojiJinin: fields[13] as int?,
      sitamiJinin: fields[14] as int?,
      homonSbt: fields[15] as String?,
      kojiSt: fields[16] as String?,
      kojiItem: fields[17] as String?,
      sitamiKansanPoint: fields[18] as double?,
      kojiKansanPoint: fields[19] as double?,
      sitamiJikan: fields[20] as int?,
      kojiJikan: fields[21] as int?,
      kojiKekka: fields[22] as String?,
      tenpoCd: fields[23] as String?,
      hojinFlg: fields[24] as int?,
      mallCd: fields[25] as String?,
      kojigyosyaCd: fields[26] as String?,
      tagKbn: fields[27] as String?,
      sitamiHomonJikan: fields[28] as String?,
      sitamiHomonJikanEnd: fields[29] as String?,
      kojiHomonJikan: fields[30] as String?,
      kojiHomonJikanEnd: fields[31] as String?,
      kojiiraisyoFilePath: fields[32] as String?,
      sitamiiraisyoFilePath: fields[33] as String?,
      cancelRiyu: fields[34] as String?,
      sitamiapoKbn: fields[35] as String?,
      kojiapoKbn: fields[36] as String?,
      mtmoriYMD: fields[37] as String?,
      memo: fields[38] as String?,
      comment: fields[39] as String?,
      readFlg: fields[40] as int?,
      atobarai: fields[41] as String?,
      biko: fields[42] as String?,
      syuyakuJyucyuId: fields[43] as String?,
      reportFlg: fields[44] as int?,
      sitamiReport: fields[45] as int?,
      allDayFlg: fields[46] as int?,
      coCd: fields[47] as String?,
      coName: fields[48] as String?,
      coPostno: fields[49] as String?,
      coAddress: fields[50] as String?,
      sitItakuhi: fields[51] as int?,
      kojiItakuhi: fields[52] as int?,
      skjRenkeiYMD: fields[53] as String?,
      kojiRenkeiYMD: fields[54] as String?,
      delFlg: fields[55] as int?,
      addPGID: fields[56] as String?,
      addTantCd: fields[57] as String?,
      addTantNm: fields[58] as String?,
      addYMD: fields[59] as String?,
      updPGID: fields[60] as String?,
      updTantCd: fields[61] as String,
      updTantNm: fields[62] as String?,
      updYMD: fields[63] as String,
      status: fields[66] as int?,
    )
      ..localKojiiraisyoFilePath = fields[64] as String?
      ..localSitamiiraisyoFilePath = fields[65] as String?
      ..originalKojiiraisyoFilePath = fields[67] as String?
      ..originalSitamiiraisyoFilePath = fields[68] as String?
      ..localCoCdFilePath = fields[69] as String?
      ..originalCoCdFilePath = fields[70] as String?;
  }

  @override
  void write(BinaryWriter writer, TKoji obj) {
    writer
      ..writeByte(71)
      ..writeByte(0)
      ..write(obj.jyucyuId)
      ..writeByte(1)
      ..write(obj.sitamiYMD)
      ..writeByte(2)
      ..write(obj.kojiYMD)
      ..writeByte(3)
      ..write(obj.homonTantCd1)
      ..writeByte(4)
      ..write(obj.homonTantName1)
      ..writeByte(5)
      ..write(obj.homonTantCd2)
      ..writeByte(6)
      ..write(obj.homonTantName2)
      ..writeByte(7)
      ..write(obj.homonTantCd3)
      ..writeByte(8)
      ..write(obj.homonTantName3)
      ..writeByte(9)
      ..write(obj.homonTantCd4)
      ..writeByte(10)
      ..write(obj.homonTantName4)
      ..writeByte(11)
      ..write(obj.setsakiName)
      ..writeByte(12)
      ..write(obj.setsakiAddress)
      ..writeByte(13)
      ..write(obj.kojiJinin)
      ..writeByte(14)
      ..write(obj.sitamiJinin)
      ..writeByte(15)
      ..write(obj.homonSbt)
      ..writeByte(16)
      ..write(obj.kojiSt)
      ..writeByte(17)
      ..write(obj.kojiItem)
      ..writeByte(18)
      ..write(obj.sitamiKansanPoint)
      ..writeByte(19)
      ..write(obj.kojiKansanPoint)
      ..writeByte(20)
      ..write(obj.sitamiJikan)
      ..writeByte(21)
      ..write(obj.kojiJikan)
      ..writeByte(22)
      ..write(obj.kojiKekka)
      ..writeByte(23)
      ..write(obj.tenpoCd)
      ..writeByte(24)
      ..write(obj.hojinFlg)
      ..writeByte(25)
      ..write(obj.mallCd)
      ..writeByte(26)
      ..write(obj.kojigyosyaCd)
      ..writeByte(27)
      ..write(obj.tagKbn)
      ..writeByte(28)
      ..write(obj.sitamiHomonJikan)
      ..writeByte(29)
      ..write(obj.sitamiHomonJikanEnd)
      ..writeByte(30)
      ..write(obj.kojiHomonJikan)
      ..writeByte(31)
      ..write(obj.kojiHomonJikanEnd)
      ..writeByte(32)
      ..write(obj.kojiiraisyoFilePath)
      ..writeByte(33)
      ..write(obj.sitamiiraisyoFilePath)
      ..writeByte(34)
      ..write(obj.cancelRiyu)
      ..writeByte(35)
      ..write(obj.sitamiapoKbn)
      ..writeByte(36)
      ..write(obj.kojiapoKbn)
      ..writeByte(37)
      ..write(obj.mtmoriYMD)
      ..writeByte(38)
      ..write(obj.memo)
      ..writeByte(39)
      ..write(obj.comment)
      ..writeByte(40)
      ..write(obj.readFlg)
      ..writeByte(41)
      ..write(obj.atobarai)
      ..writeByte(42)
      ..write(obj.biko)
      ..writeByte(43)
      ..write(obj.syuyakuJyucyuId)
      ..writeByte(44)
      ..write(obj.reportFlg)
      ..writeByte(45)
      ..write(obj.sitamiReport)
      ..writeByte(46)
      ..write(obj.allDayFlg)
      ..writeByte(47)
      ..write(obj.coCd)
      ..writeByte(48)
      ..write(obj.coName)
      ..writeByte(49)
      ..write(obj.coPostno)
      ..writeByte(50)
      ..write(obj.coAddress)
      ..writeByte(51)
      ..write(obj.sitItakuhi)
      ..writeByte(52)
      ..write(obj.kojiItakuhi)
      ..writeByte(53)
      ..write(obj.skjRenkeiYMD)
      ..writeByte(54)
      ..write(obj.kojiRenkeiYMD)
      ..writeByte(55)
      ..write(obj.delFlg)
      ..writeByte(56)
      ..write(obj.addPGID)
      ..writeByte(57)
      ..write(obj.addTantCd)
      ..writeByte(58)
      ..write(obj.addTantNm)
      ..writeByte(59)
      ..write(obj.addYMD)
      ..writeByte(60)
      ..write(obj.updPGID)
      ..writeByte(61)
      ..write(obj.updTantCd)
      ..writeByte(62)
      ..write(obj.updTantNm)
      ..writeByte(63)
      ..write(obj.updYMD)
      ..writeByte(64)
      ..write(obj.localKojiiraisyoFilePath)
      ..writeByte(65)
      ..write(obj.localSitamiiraisyoFilePath)
      ..writeByte(66)
      ..write(obj.status)
      ..writeByte(67)
      ..write(obj.originalKojiiraisyoFilePath)
      ..writeByte(68)
      ..write(obj.originalSitamiiraisyoFilePath)
      ..writeByte(69)
      ..write(obj.localCoCdFilePath)
      ..writeByte(70)
      ..write(obj.originalCoCdFilePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TKojiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TKoji _$TKojiFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['JYUCYU_ID', 'UPD_TANTCD', 'UPD_YMD'],
  );
  return TKoji(
    jyucyuId: json['JYUCYU_ID'] as String,
    sitamiYMD: json['SITAMI_YMD'] as String?,
    kojiYMD: json['KOJI_YMD'] as String?,
    homonTantCd1: json['HOMON_TANT_CD1'] as String?,
    homonTantName1: json['HOMON_TANT_NAME1'] as String?,
    homonTantCd2: json['HOMON_TANT_CD2'] as String?,
    homonTantName2: json['HOMON_TANT_NAME2'] as String?,
    homonTantCd3: json['HOMON_TANT_CD3'] as String?,
    homonTantName3: json['HOMON_TANT_NAME3'] as String?,
    homonTantCd4: json['HOMON_TANT_CD4'] as String?,
    homonTantName4: json['HOMON_TANT_NAME4'] as String?,
    setsakiName: json['SETSAKI_NAME'] as String?,
    setsakiAddress: json['SETSAKI_ADDRESS'] as String?,
    kojiJinin: json['KOJI_JININ'] as int?,
    sitamiJinin: json['SITAMI_JININ'] as int?,
    homonSbt: json['HOMON_SBT'] as String?,
    kojiSt: json['KOJI_ST'] as String?,
    kojiItem: json['KOJI_ITEM'] as String?,
    sitamiKansanPoint: (json['SITAMI_KANSAN_POINT'] as num?)?.toDouble(),
    kojiKansanPoint: (json['KOJI_KANSAN_POINT'] as num?)?.toDouble(),
    sitamiJikan: json['SITAMI_JIKAN'] as int?,
    kojiJikan: json['KOJI_JIKAN'] as int?,
    kojiKekka: json['KOJI_KEKKA'] as String?,
    tenpoCd: json['TENPO_CD'] as String?,
    hojinFlg: json['HOJIN_FLG'] as int?,
    mallCd: json['MALL_CD'] as String?,
    kojigyosyaCd: json['KOJIGYOSYA_CD'] as String?,
    tagKbn: json['TAG_KBN'] as String?,
    sitamiHomonJikan: json['SITAMIHOMONJIKAN'] as String?,
    sitamiHomonJikanEnd: json['SITAMIHOMONJIKAN_END'] as String?,
    kojiHomonJikan: json['KOJIHOMONJIKAN'] as String?,
    kojiHomonJikanEnd: json['KOJIHOMONJIKAN_END'] as String?,
    kojiiraisyoFilePath: json['KOJIIRAISYO_FILEPATH'] as String?,
    sitamiiraisyoFilePath: json['SITAMIIRAISYO_FILEPATH'] as String?,
    cancelRiyu: json['CANCEL_RIYU'] as String?,
    sitamiapoKbn: json['SITAMIAPO_KBN'] as String?,
    kojiapoKbn: json['KOJIAPO_KBN'] as String?,
    mtmoriYMD: json['MTMORI_YMD'] as String?,
    memo: json['MEMO'] as String?,
    comment: json['COMMENT'] as String?,
    readFlg: json['READ_FLG'] as int?,
    atobarai: json['ATOBARAI'] as String?,
    biko: json['BIKO'] as String?,
    syuyakuJyucyuId: json['SYUYAKU_JYUCYU_ID'] as String?,
    reportFlg: json['REPORT_FLG'] as int?,
    sitamiReport: json['SITAMI_REPORT'] as int?,
    allDayFlg: json['ALL_DAY_FLG'] as int?,
    coCd: json['CO_CD'] as String?,
    coName: json['CO_NAME'] as String?,
    coPostno: json['CO_POSTNO'] as String?,
    coAddress: json['CO_ADDRESS'] as String?,
    sitItakuhi: json['SIT_ITAKUHI'] as int?,
    kojiItakuhi: json['KOJI_ITAKUHI'] as int?,
    skjRenkeiYMD: json['SKJ_RENKEI_YMD'] as String?,
    kojiRenkeiYMD: json['KOJI_RENKEI_YMD'] as String?,
    delFlg: json['DEL_FLG'] as int?,
    addPGID: json['ADD_PGID'] as String?,
    addTantCd: json['ADD_TANTCD'] as String?,
    addTantNm: json['ADD_TANTNM'] as String?,
    addYMD: json['ADD_YMD'] as String?,
    updPGID: json['UPD_PGID'] as String?,
    updTantCd: json['UPD_TANTCD'] as String,
    updTantNm: json['UPD_TANTNM'] as String?,
    updYMD: json['UPD_YMD'] as String,
    status: json['status'] as int? ?? 0,
  )
    ..localKojiiraisyoFilePath = json['localKojiiraisyoFilePath'] as String?
    ..localSitamiiraisyoFilePath = json['localSitamiiraisyoFilePath'] as String?
    ..originalKojiiraisyoFilePath =
        json['originalKojiiraisyoFilePath'] as String?
    ..originalSitamiiraisyoFilePath =
        json['originalSitamiiraisyoFilePath'] as String?
    ..localCoCdFilePath = json['localCoCdFilePath'] as String?
    ..originalCoCdFilePath = json['originalCoCdFilePath'] as String?;
}

Map<String, dynamic> _$TKojiToJson(TKoji instance) => <String, dynamic>{
      'JYUCYU_ID': instance.jyucyuId,
      'SITAMI_YMD': instance.sitamiYMD,
      'KOJI_YMD': instance.kojiYMD,
      'HOMON_TANT_CD1': instance.homonTantCd1,
      'HOMON_TANT_NAME1': instance.homonTantName1,
      'HOMON_TANT_CD2': instance.homonTantCd2,
      'HOMON_TANT_NAME2': instance.homonTantName2,
      'HOMON_TANT_CD3': instance.homonTantCd3,
      'HOMON_TANT_NAME3': instance.homonTantName3,
      'HOMON_TANT_CD4': instance.homonTantCd4,
      'HOMON_TANT_NAME4': instance.homonTantName4,
      'SETSAKI_NAME': instance.setsakiName,
      'SETSAKI_ADDRESS': instance.setsakiAddress,
      'KOJI_JININ': instance.kojiJinin,
      'SITAMI_JININ': instance.sitamiJinin,
      'HOMON_SBT': instance.homonSbt,
      'KOJI_ST': instance.kojiSt,
      'KOJI_ITEM': instance.kojiItem,
      'SITAMI_KANSAN_POINT': instance.sitamiKansanPoint,
      'KOJI_KANSAN_POINT': instance.kojiKansanPoint,
      'SITAMI_JIKAN': instance.sitamiJikan,
      'KOJI_JIKAN': instance.kojiJikan,
      'KOJI_KEKKA': instance.kojiKekka,
      'TENPO_CD': instance.tenpoCd,
      'HOJIN_FLG': instance.hojinFlg,
      'MALL_CD': instance.mallCd,
      'KOJIGYOSYA_CD': instance.kojigyosyaCd,
      'TAG_KBN': instance.tagKbn,
      'SITAMIHOMONJIKAN': instance.sitamiHomonJikan,
      'SITAMIHOMONJIKAN_END': instance.sitamiHomonJikanEnd,
      'KOJIHOMONJIKAN': instance.kojiHomonJikan,
      'KOJIHOMONJIKAN_END': instance.kojiHomonJikanEnd,
      'KOJIIRAISYO_FILEPATH': instance.kojiiraisyoFilePath,
      'SITAMIIRAISYO_FILEPATH': instance.sitamiiraisyoFilePath,
      'CANCEL_RIYU': instance.cancelRiyu,
      'SITAMIAPO_KBN': instance.sitamiapoKbn,
      'KOJIAPO_KBN': instance.kojiapoKbn,
      'MTMORI_YMD': instance.mtmoriYMD,
      'MEMO': instance.memo,
      'COMMENT': instance.comment,
      'READ_FLG': instance.readFlg,
      'ATOBARAI': instance.atobarai,
      'BIKO': instance.biko,
      'SYUYAKU_JYUCYU_ID': instance.syuyakuJyucyuId,
      'REPORT_FLG': instance.reportFlg,
      'SITAMI_REPORT': instance.sitamiReport,
      'ALL_DAY_FLG': instance.allDayFlg,
      'CO_CD': instance.coCd,
      'CO_NAME': instance.coName,
      'CO_POSTNO': instance.coPostno,
      'CO_ADDRESS': instance.coAddress,
      'SIT_ITAKUHI': instance.sitItakuhi,
      'KOJI_ITAKUHI': instance.kojiItakuhi,
      'SKJ_RENKEI_YMD': instance.skjRenkeiYMD,
      'KOJI_RENKEI_YMD': instance.kojiRenkeiYMD,
      'DEL_FLG': instance.delFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_TANTNM': instance.addTantNm,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_TANTNM': instance.updTantNm,
      'UPD_YMD': instance.updYMD,
      'localKojiiraisyoFilePath': instance.localKojiiraisyoFilePath,
      'localSitamiiraisyoFilePath': instance.localSitamiiraisyoFilePath,
      'status': instance.status,
      'originalKojiiraisyoFilePath': instance.originalKojiiraisyoFilePath,
      'originalSitamiiraisyoFilePath': instance.originalSitamiiraisyoFilePath,
      'localCoCdFilePath': instance.localCoCdFilePath,
      'originalCoCdFilePath': instance.originalCoCdFilePath,
    };
