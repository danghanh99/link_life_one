// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_syohin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MSyohinAdapter extends TypeAdapter<MSyohin> {
  @override
  final int typeId = 7;

  @override
  MSyohin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MSyohin(
      jisyaCd: fields[0] as String,
      syohinName: fields[1] as String,
      hinban: fields[2] as String,
      syohinSybetCd: fields[3] as String,
      makerCd: fields[4] as String,
      ctgoryCd: fields[5] as String,
      hanbaiTanka: fields[6] as String,
      changeFlg: fields[7] as int,
      addPGID: fields[8] as String,
      addTantCd: fields[9] as String,
      addYMD: fields[10] as DateTime,
      updPGID: fields[11] as String,
      updTantCd: fields[12] as String,
      updYMD: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MSyohin obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.jisyaCd)
      ..writeByte(1)
      ..write(obj.syohinName)
      ..writeByte(2)
      ..write(obj.hinban)
      ..writeByte(3)
      ..write(obj.syohinSybetCd)
      ..writeByte(4)
      ..write(obj.makerCd)
      ..writeByte(5)
      ..write(obj.ctgoryCd)
      ..writeByte(6)
      ..write(obj.hanbaiTanka)
      ..writeByte(7)
      ..write(obj.changeFlg)
      ..writeByte(8)
      ..write(obj.addPGID)
      ..writeByte(9)
      ..write(obj.addTantCd)
      ..writeByte(10)
      ..write(obj.addYMD)
      ..writeByte(11)
      ..write(obj.updPGID)
      ..writeByte(12)
      ..write(obj.updTantCd)
      ..writeByte(13)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MSyohinAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
