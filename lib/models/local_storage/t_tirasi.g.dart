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
      YMD: fields[1] as String,
      kojiTirasisu: fields[2] as String?,
      renkeiYMD: fields[3] as String?,
      delFlg: fields[4] as String?,
      addPGID: fields[5] as String?,
      addTantCd: fields[6] as String?,
      addYMD: fields[7] as String?,
      updPGID: fields[8] as String?,
      updTantCd: fields[9] as String,
      updYMD: fields[10] as String,
      status: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TTirasi obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.updYMD)
      ..writeByte(11)
      ..write(obj.status);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TTirasi _$TTirasiFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['TANT_CD', 'YMD', 'UPD_TANTCD', 'UPD_YMD'],
  );
  return TTirasi(
    tantCd: json['TANT_CD'] as String,
    YMD: json['YMD'] as String,
    kojiTirasisu: json['KOJI_TIRASISU'] as String?,
    renkeiYMD: json['RENKEI_YMD'] as String?,
    delFlg: json['DEL_FLG'] as String?,
    addPGID: json['ADD_PGID'] as String?,
    addTantCd: json['ADD_TANTCD'] as String?,
    addYMD: json['ADD_YMD'] as String?,
    updPGID: json['UPD_PGID'] as String?,
    updTantCd: json['UPD_TANTCD'] as String,
    updYMD: json['UPD_YMD'] as String,
    status: json['status'] as int? ?? 0,
  );
}

Map<String, dynamic> _$TTirasiToJson(TTirasi instance) => <String, dynamic>{
      'TANT_CD': instance.tantCd,
      'YMD': instance.YMD,
      'KOJI_TIRASISU': instance.kojiTirasisu,
      'RENKEI_YMD': instance.renkeiYMD,
      'DEL_FLG': instance.delFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
      'status': instance.status,
    };
