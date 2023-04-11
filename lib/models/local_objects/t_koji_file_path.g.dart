// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_koji_file_path.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TKojiFilePathAdapter extends TypeAdapter<TKojiFilePath> {
  @override
  final int typeId = 12;

  @override
  TKojiFilePath read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TKojiFilePath(
      filePathId: fields[0] as String,
      id: fields[1] as String,
      filePath: fields[2] as String,
      fileKbnCd: fields[3] as String,
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
  void write(BinaryWriter writer, TKojiFilePath obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.filePathId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.fileKbnCd)
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
      other is TKojiFilePathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
