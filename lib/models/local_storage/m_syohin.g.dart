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
      syohinSybetCd: fields[3] as String?,
      makerCd: fields[4] as String?,
      ctgoryCd: fields[5] as String?,
      hanbaiTanka: fields[6] as String?,
      changeFlg: fields[7] as String?,
      addPGID: fields[8] as String?,
      addTantCd: fields[9] as String?,
      addYMD: fields[10] as String,
      updPGID: fields[11] as String?,
      updTantCd: fields[12] as String,
      updYMD: fields[13] as String,
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MSyohin _$MSyohinFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'JISYA_CD',
      'SYOHIN_NAME',
      'HINBAN',
      'ADD_YMD',
      'UPD_TANTCD',
      'UPD_YMD'
    ],
  );
  return MSyohin(
    jisyaCd: json['JISYA_CD'] as String,
    syohinName: json['SYOHIN_NAME'] as String,
    hinban: json['HINBAN'] as String,
    syohinSybetCd: json['SYOHIN_SYBET_CD'] as String?,
    makerCd: json['MAKER_CD'] as String?,
    ctgoryCd: json['CTGORY_CD'] as String?,
    hanbaiTanka: json['HANBAI_TANKA'] as String?,
    changeFlg: json['CHANGE_FLG'] as String?,
    addPGID: json['ADD_PGID'] as String?,
    addTantCd: json['ADD_TANTCD'] as String?,
    addYMD: json['ADD_YMD'] as String,
    updPGID: json['UPD_PGID'] as String?,
    updTantCd: json['UPD_TANTCD'] as String,
    updYMD: json['UPD_YMD'] as String,
  );
}

Map<String, dynamic> _$MSyohinToJson(MSyohin instance) => <String, dynamic>{
      'JISYA_CD': instance.jisyaCd,
      'SYOHIN_NAME': instance.syohinName,
      'HINBAN': instance.hinban,
      'SYOHIN_SYBET_CD': instance.syohinSybetCd,
      'MAKER_CD': instance.makerCd,
      'CTGORY_CD': instance.ctgoryCd,
      'HANBAI_TANKA': instance.hanbaiTanka,
      'CHANGE_FLG': instance.changeFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
    };
