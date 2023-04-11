// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_tirasi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TTirasiAdapter extends TypeAdapter<TTirasi> {
  @override
  final int typeId = 13;

  @override
  TTirasi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TTirasi(
      tantCd: fields[0] as String,
      YMD: fields[1] as DateTime,
      kojiTirasisu: fields[2] as int,
      renkeiYMD: fields[3] as DateTime,
      delFlg: fields[4] as int,
      addPGID: fields[5] as String,
      addTantCd: fields[6] as String,
      addYMD: fields[7] as DateTime,
      updPGID: fields[8] as String,
      updTantCd: fields[9] as String,
      updYMD: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TTirasi obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.tantCd)
      ..writeByte(1)
      ..write(obj.YMD)
      ..writeByte(2)
      ..write(obj.kojiTirasisu)
      ..writeByte(3)
      ..write(obj.renkeiYMD)
      ..writeByte(4)
      ..write(obj.delFlg)
      ..writeByte(5)
      ..write(obj.addPGID)
      ..writeByte(6)
      ..write(obj.addTantCd)
      ..writeByte(7)
      ..write(obj.addYMD)
      ..writeByte(8)
      ..write(obj.updPGID)
      ..writeByte(9)
      ..write(obj.updTantCd)
      ..writeByte(10)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TTirasiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
