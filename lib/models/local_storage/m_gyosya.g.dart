// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_gyosya.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MGyosyaAdapter extends TypeAdapter<MGyosya> {
  @override
  final int typeId = 6;

  @override
  MGyosya read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MGyosya(
      kojiGyosyaCd: fields[0] as String,
      gyosyaKBNCd: fields[1] as String,
      kojiGyosyaName: fields[2] as String?,
      jisyaLikeFlg: fields[3] as String?,
      delFlg: fields[4] as String?,
      addPGID: fields[5] as String,
      addTantCd: fields[6] as String?,
      addYMD: fields[7] as String?,
      updPGID: fields[8] as String?,
      updTantCd: fields[9] as String?,
      updYMD: fields[10] as String?,
      status: fields[11] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MGyosya obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.kojiGyosyaCd)
      ..writeByte(1)
      ..write(obj.gyosyaKBNCd)
      ..writeByte(2)
      ..write(obj.kojiGyosyaName)
      ..writeByte(3)
      ..write(obj.jisyaLikeFlg)
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
      other is MGyosyaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MGyosya _$MGyosyaFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['KOJIGYOSYA_CD', 'GYOSYA_KBN_CD', 'ADD_PGID'],
  );
  return MGyosya(
    kojiGyosyaCd: json['KOJIGYOSYA_CD'] as String,
    gyosyaKBNCd: json['GYOSYA_KBN_CD'] as String,
    kojiGyosyaName: json['KOJIGYOSYA_NAME'] as String?,
    jisyaLikeFlg: json['JISYA_LIKE_FLG'] as String?,
    delFlg: json['DEL_FLG'] as String?,
    addPGID: json['ADD_PGID'] as String,
    addTantCd: json['ADD_TANTCD'] as String?,
    addYMD: json['ADD_YMD'] as String?,
    updPGID: json['UPD_PGID'] as String?,
    updTantCd: json['UPD_TANTCD'] as String?,
    updYMD: json['UPD_YMD'] as String?,
    status: json['status'] as int? ?? 0,
  );
}

Map<String, dynamic> _$MGyosyaToJson(MGyosya instance) => <String, dynamic>{
      'KOJIGYOSYA_CD': instance.kojiGyosyaCd,
      'GYOSYA_KBN_CD': instance.gyosyaKBNCd,
      'KOJIGYOSYA_NAME': instance.kojiGyosyaName,
      'JISYA_LIKE_FLG': instance.jisyaLikeFlg,
      'DEL_FLG': instance.delFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
      'status': instance.status,
    };
