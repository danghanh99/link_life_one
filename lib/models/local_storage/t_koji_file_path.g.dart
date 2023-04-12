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
      addYMD: fields[7] as String,
      updPGID: fields[8] as String,
      updTantCd: fields[9] as String,
      updYMD: fields[10] as String,
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TKojiFilePath _$TKojiFilePathFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'FILEPATH_ID',
      'ID',
      'FILEPATH',
      'FILE_KBN_CD',
      'DEL_FLG',
      'ADD_PGID',
      'ADD_TANTCD',
      'ADD_YMD',
      'UPD_PGID',
      'UPD_TANTCD',
      'UPD_YMD'
    ],
  );
  return TKojiFilePath(
    filePathId: json['FILEPATH_ID'] as String,
    id: json['ID'] as String,
    filePath: json['FILEPATH'] as String,
    fileKbnCd: json['FILE_KBN_CD'] as String,
    delFlg: json['DEL_FLG'] as int,
    addPGID: json['ADD_PGID'] as String,
    addTantCd: json['ADD_TANTCD'] as String,
    addYMD: json['ADD_YMD'] as String,
    updPGID: json['UPD_PGID'] as String,
    updTantCd: json['UPD_TANTCD'] as String,
    updYMD: json['UPD_YMD'] as String,
  );
}

Map<String, dynamic> _$TKojiFilePathToJson(TKojiFilePath instance) =>
    <String, dynamic>{
      'FILEPATH_ID': instance.filePathId,
      'ID': instance.id,
      'FILEPATH': instance.filePath,
      'FILE_KBN_CD': instance.fileKbnCd,
      'DEL_FLG': instance.delFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
    };
