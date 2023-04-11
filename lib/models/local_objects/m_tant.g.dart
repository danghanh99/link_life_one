// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_tant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MTantAdapter extends TypeAdapter<MTant> {
  @override
  final int typeId = 8;

  @override
  MTant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MTant(
      tantCd: fields[0] as String,
      tantName: fields[1] as String,
      tantKName: fields[2] as String,
      buzaiHacokFlg: fields[3] as int,
      syozokubusyoCd: fields[4] as String,
      password: fields[5] as String,
      passwordUpdYMD: fields[6] as DateTime,
      menuPtncd: fields[7] as String,
      tantKbnCd: fields[8] as String,
      syozokuCd: fields[9] as String,
      kengenCd: fields[10] as String,
      daylySales: fields[11] as int,
      monthlySales: fields[12] as int,
      kaisyuRuikei: fields[13] as int,
      delFlg: fields[14] as int,
      addPGID: fields[15] as String,
      addTantCd: fields[16] as String,
      addYMD: fields[17] as DateTime,
      updPGID: fields[18] as String,
      updTantCd: fields[19] as String,
      updYMD: fields[20] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MTant obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.tantCd)
      ..writeByte(1)
      ..write(obj.tantName)
      ..writeByte(2)
      ..write(obj.tantKName)
      ..writeByte(3)
      ..write(obj.buzaiHacokFlg)
      ..writeByte(4)
      ..write(obj.syozokubusyoCd)
      ..writeByte(5)
      ..write(obj.password)
      ..writeByte(6)
      ..write(obj.passwordUpdYMD)
      ..writeByte(7)
      ..write(obj.menuPtncd)
      ..writeByte(8)
      ..write(obj.tantKbnCd)
      ..writeByte(9)
      ..write(obj.syozokuCd)
      ..writeByte(10)
      ..write(obj.kengenCd)
      ..writeByte(11)
      ..write(obj.daylySales)
      ..writeByte(12)
      ..write(obj.monthlySales)
      ..writeByte(13)
      ..write(obj.kaisyuRuikei)
      ..writeByte(14)
      ..write(obj.delFlg)
      ..writeByte(15)
      ..write(obj.addPGID)
      ..writeByte(16)
      ..write(obj.addTantCd)
      ..writeByte(17)
      ..write(obj.addYMD)
      ..writeByte(18)
      ..write(obj.updPGID)
      ..writeByte(19)
      ..write(obj.updTantCd)
      ..writeByte(20)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MTantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
