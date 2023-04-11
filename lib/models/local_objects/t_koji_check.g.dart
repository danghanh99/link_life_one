// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_koji_check.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TKojiCheckAdapter extends TypeAdapter<TKojiCheck> {
  @override
  final int typeId = 11;

  @override
  TKojiCheck read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TKojiCheck(
      jyucyuId: fields[0] as String,
      checkFlg1: fields[1] as int,
      checkFlg2: fields[2] as int,
      checkFlg3: fields[3] as int,
      checkFlg4: fields[4] as int,
      checkFlg5: fields[5] as int,
      checkFlg6: fields[6] as int,
      checkFlg7: fields[7] as int,
      delFlg: fields[8] as int,
      addPGID: fields[9] as String,
      addTantCd: fields[10] as String,
      addYMD: fields[11] as DateTime,
      updPGID: fields[12] as String,
      updTantCd: fields[13] as String,
      updYMD: fields[14] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TKojiCheck obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.jyucyuId)
      ..writeByte(1)
      ..write(obj.checkFlg1)
      ..writeByte(2)
      ..write(obj.checkFlg2)
      ..writeByte(3)
      ..write(obj.checkFlg3)
      ..writeByte(4)
      ..write(obj.checkFlg4)
      ..writeByte(5)
      ..write(obj.checkFlg5)
      ..writeByte(6)
      ..write(obj.checkFlg6)
      ..writeByte(7)
      ..write(obj.checkFlg7)
      ..writeByte(8)
      ..write(obj.delFlg)
      ..writeByte(9)
      ..write(obj.addPGID)
      ..writeByte(10)
      ..write(obj.addTantCd)
      ..writeByte(11)
      ..write(obj.addYMD)
      ..writeByte(12)
      ..write(obj.updPGID)
      ..writeByte(13)
      ..write(obj.updTantCd)
      ..writeByte(14)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TKojiCheckAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
