// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_kbn.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MKBNAdapter extends TypeAdapter<MKBN> {
  @override
  final int typeId = 14;

  @override
  MKBN read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MKBN(
      kbnCd: fields[0] as String,
      kbnName: fields[1] as String,
      kbnBiko: fields[2] as String,
      kbnmsaiCd: fields[3] as String,
      kbnmsaiName: fields[4] as String,
      kbnmsaiBiko: fields[5] as String,
      yobikomoku1: fields[6] as String,
      yobikomoku2: fields[7] as String,
      yobikomoku3: fields[8] as String,
      yobikomoku4: fields[9] as String,
      yobikomoku5: fields[10] as String,
      delFlg: fields[11] as int,
      addPGID: fields[12] as String,
      addTantCd: fields[13] as String,
      addYMD: fields[14] as DateTime,
      updPGID: fields[15] as String,
      updTantCd: fields[16] as String,
      updYMD: fields[17] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MKBN obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.kbnCd)
      ..writeByte(1)
      ..write(obj.kbnName)
      ..writeByte(2)
      ..write(obj.kbnBiko)
      ..writeByte(3)
      ..write(obj.kbnmsaiCd)
      ..writeByte(4)
      ..write(obj.kbnmsaiName)
      ..writeByte(5)
      ..write(obj.kbnmsaiBiko)
      ..writeByte(6)
      ..write(obj.yobikomoku1)
      ..writeByte(7)
      ..write(obj.yobikomoku2)
      ..writeByte(8)
      ..write(obj.yobikomoku3)
      ..writeByte(9)
      ..write(obj.yobikomoku4)
      ..writeByte(10)
      ..write(obj.yobikomoku5)
      ..writeByte(11)
      ..write(obj.delFlg)
      ..writeByte(12)
      ..write(obj.addPGID)
      ..writeByte(13)
      ..write(obj.addTantCd)
      ..writeByte(14)
      ..write(obj.addYMD)
      ..writeByte(15)
      ..write(obj.updPGID)
      ..writeByte(16)
      ..write(obj.updTantCd)
      ..writeByte(17)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MKBNAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
