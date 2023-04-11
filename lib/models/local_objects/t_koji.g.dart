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
      sitamiYMD: fields[1] as DateTime,
      kojiYMD: fields[2] as DateTime,
      homonTantCd1: fields[3] as String,
      homonTantName1: fields[4] as String,
      homonTantCd2: fields[5] as String,
      homonTantName2: fields[6] as String,
      homonTantCd3: fields[7] as String,
      homonTantName3: fields[8] as String,
      homonTantCd4: fields[9] as String,
      homonTantName4: fields[10] as String,
      setsakiName: fields[11] as String,
      setsakiAddress: fields[12] as String,
      kojiJinin: fields[13] as int,
      sitamiJinin: fields[14] as int,
      homonSbt: fields[15] as String,
      kojiSt: fields[16] as String,
      kojiItem: fields[17] as String,
      sitamiKansanPoint: fields[18] as double,
      kojiKansanPoint: fields[19] as double,
      sitamiJikan: fields[20] as int,
      kojiJikan: fields[21] as int,
      kojiKekka: fields[22] as String,
      tenpoCd: fields[23] as String,
      hojinFlg: fields[24] as int,
      mallCd: fields[25] as String,
      kojigyosyaCd: fields[26] as String,
      tagKbn: fields[27] as String,
      sitamiHomonJikan: fields[28] as String,
      sitamiHomonJikanEnd: fields[29] as String,
      kojiHomonJikan: fields[30] as String,
      kojiHomonJikanEnd: fields[31] as String,
      kojiiraisyoFilePath: fields[32] as String,
      sitamiiraisyoFilePath: fields[33] as String,
      cancelRiyu: fields[34] as String,
      sitamiapoKbn: fields[35] as String,
      kojiapoKbn: fields[36] as String,
      mtmoriYMD: fields[37] as DateTime,
      memo: fields[38] as String,
      comment: fields[39] as String,
      readFlg: fields[40] as int,
      atobarai: fields[41] as String,
      biko: fields[42] as String,
      syuyakuJyucyuId: fields[43] as String,
      reportFlg: fields[44] as int,
      sitamiReport: fields[45] as int,
      allDayFlg: fields[46] as int,
      coCd: fields[47] as String,
      coName: fields[48] as String,
      coPostno: fields[49] as String,
      coAddress: fields[50] as String,
      sitItakuhi: fields[51] as int,
      kojiItakuhi: fields[52] as int,
      skjRenkeiYMD: fields[53] as DateTime,
      kojiRenkeiYMD: fields[54] as DateTime,
      delFlg: fields[55] as int,
      addPGID: fields[56] as String,
      addTantCd: fields[57] as String,
      addTantNm: fields[58] as String,
      addYMD: fields[59] as DateTime,
      updPGID: fields[60] as String,
      updTantCd: fields[61] as String,
      updTantNm: fields[62] as String,
      updYMD: fields[63] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TKoji obj) {
    writer
      ..writeByte(64)
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
      ..write(obj.updYMD);
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
