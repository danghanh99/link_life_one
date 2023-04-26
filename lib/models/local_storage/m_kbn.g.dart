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
      kbnBiko: fields[2] as String?,
      kbnmsaiCd: fields[3] as String,
      kbnmsaiName: fields[4] as String,
      kbnmsaiBiko: fields[5] as String?,
      yobikomoku1: fields[6] as String?,
      yobikomoku2: fields[7] as String?,
      yobikomoku3: fields[8] as String?,
      yobikomoku4: fields[9] as String?,
      yobikomoku5: fields[10] as String?,
      delFlg: fields[11] as String?,
      addPGID: fields[12] as String?,
      addTantCd: fields[13] as String?,
      addYMD: fields[14] as String?,
      updPGID: fields[15] as String?,
      updTantCd: fields[16] as String,
      updYMD: fields[17] as String,
      status: fields[18] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MKBN obj) {
    writer
      ..writeByte(19)
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
      ..write(obj.updYMD)
      ..writeByte(18)
      ..write(obj.status);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MKBN _$MKBNFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'KBN_CD',
      'KBN_NAME',
      'KBNMSAI_CD',
      'KBNMSAI_NAME',
      'UPD_TANTCD',
      'UPD_YMD'
    ],
  );
  return MKBN(
    kbnCd: json['KBN_CD'] as String,
    kbnName: json['KBN_NAME'] as String,
    kbnBiko: json['KBN_BIKO'] as String?,
    kbnmsaiCd: json['KBNMSAI_CD'] as String,
    kbnmsaiName: json['KBNMSAI_NAME'] as String,
    kbnmsaiBiko: json['KBNMSAI_BIKO'] as String?,
    yobikomoku1: json['YOBIKOMOKU1'] as String?,
    yobikomoku2: json['YOBIKOMOKU2'] as String?,
    yobikomoku3: json['YOBIKOMOKU3'] as String?,
    yobikomoku4: json['YOBIKOMOKU4'] as String?,
    yobikomoku5: json['YOBIKOMOKU5'] as String?,
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

Map<String, dynamic> _$MKBNToJson(MKBN instance) => <String, dynamic>{
      'KBN_CD': instance.kbnCd,
      'KBN_NAME': instance.kbnName,
      'KBN_BIKO': instance.kbnBiko,
      'KBNMSAI_CD': instance.kbnmsaiCd,
      'KBNMSAI_NAME': instance.kbnmsaiName,
      'KBNMSAI_BIKO': instance.kbnmsaiBiko,
      'YOBIKOMOKU1': instance.yobikomoku1,
      'YOBIKOMOKU2': instance.yobikomoku2,
      'YOBIKOMOKU3': instance.yobikomoku3,
      'YOBIKOMOKU4': instance.yobikomoku4,
      'YOBIKOMOKU5': instance.yobikomoku5,
      'DEL_FLG': instance.delFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
      'status': instance.status,
    };
