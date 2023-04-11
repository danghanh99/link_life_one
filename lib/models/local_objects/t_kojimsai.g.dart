// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_kojimsai.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TKojimsaiAdapter extends TypeAdapter<TKojimsai> {
  @override
  final int typeId = 10;

  @override
  TKojimsai read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TKojimsai(
      jyucyuId: fields[0] as String,
      jyucyumsaiId: fields[1] as String,
      jyucyumsaiIdKikan: fields[2] as String,
      hinban: fields[3] as String,
      makerCd: fields[4] as String,
      ctgotyCd: fields[5] as String,
      suryo: fields[6] as int,
      hanbaiTanka: fields[7] as String,
      kingak: fields[8] as String,
      kisetuHinban: fields[9] as String,
      kisetuMaker: fields[10] as String,
      kensetuKeitai: fields[11] as String,
      befSekoPhotoFilePath: fields[12] as String,
      aftSekoPhotoFilePath: fields[13] as String,
      otherPhotoFolderPath: fields[14] as String,
      tuikaJisyaCd: fields[15] as String,
      tuikaSyohinName: fields[16] as String,
      kojijituikaFlg: fields[17] as String,
      delFlg: fields[18] as int,
      renkeiYMD: fields[19] as DateTime,
      addPGID: fields[20] as String,
      addTantCd: fields[21] as String,
      addYMD: fields[22] as DateTime,
      updPGID: fields[23] as String,
      updTantCd: fields[24] as String,
      updYMD: fields[25] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TKojimsai obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.jyucyuId)
      ..writeByte(1)
      ..write(obj.jyucyumsaiId)
      ..writeByte(2)
      ..write(obj.jyucyumsaiIdKikan)
      ..writeByte(3)
      ..write(obj.hinban)
      ..writeByte(4)
      ..write(obj.makerCd)
      ..writeByte(5)
      ..write(obj.ctgotyCd)
      ..writeByte(6)
      ..write(obj.suryo)
      ..writeByte(7)
      ..write(obj.hanbaiTanka)
      ..writeByte(8)
      ..write(obj.kingak)
      ..writeByte(9)
      ..write(obj.kisetuHinban)
      ..writeByte(10)
      ..write(obj.kisetuMaker)
      ..writeByte(11)
      ..write(obj.kensetuKeitai)
      ..writeByte(12)
      ..write(obj.befSekoPhotoFilePath)
      ..writeByte(13)
      ..write(obj.aftSekoPhotoFilePath)
      ..writeByte(14)
      ..write(obj.otherPhotoFolderPath)
      ..writeByte(15)
      ..write(obj.tuikaJisyaCd)
      ..writeByte(16)
      ..write(obj.tuikaSyohinName)
      ..writeByte(17)
      ..write(obj.kojijituikaFlg)
      ..writeByte(18)
      ..write(obj.delFlg)
      ..writeByte(19)
      ..write(obj.renkeiYMD)
      ..writeByte(20)
      ..write(obj.addPGID)
      ..writeByte(21)
      ..write(obj.addTantCd)
      ..writeByte(22)
      ..write(obj.addYMD)
      ..writeByte(23)
      ..write(obj.updPGID)
      ..writeByte(24)
      ..write(obj.updTantCd)
      ..writeByte(25)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TKojimsaiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
