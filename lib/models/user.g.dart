// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      TANT_CD: fields[1] as String,
      TANT_NAME: fields[2] as String,
      TANT_KNAME: fields[3] as String,
      BUZAI_HACOK_FLG: fields[4] as String,
      SYOZOKUBUSYO_CD: fields[5] as String,
      PASSWORD: fields[6] as String,
      PASSWORD_UPD_YMD: fields[7] as String,
      MENUPTN_CD: fields[8] as String,
      TANT_KBN_CD: fields[9] as String,
      SYOZOKU_CD: fields[10] as String,
      KENGEN_CD: fields[11] as String,
      DAYLY_SALES: fields[12] as String,
      MONTHLY_SALES: fields[13] as String,
      KAISYU_RUIKEI: fields[14] as String,
      DEL_FLG: fields[15] as String,
      ADD_PGID: fields[16] as String,
      ADD_TANTCD: fields[17] as String,
      ADD_YMD: fields[18] as String,
      UPD_PGID: fields[19] as String,
      UPD_TANTCD: fields[20] as String,
      UPD_YMD: fields[21] as String,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(21)
      ..writeByte(1)
      ..write(obj.TANT_CD)
      ..writeByte(2)
      ..write(obj.TANT_NAME)
      ..writeByte(3)
      ..write(obj.TANT_KNAME)
      ..writeByte(4)
      ..write(obj.BUZAI_HACOK_FLG)
      ..writeByte(5)
      ..write(obj.SYOZOKUBUSYO_CD)
      ..writeByte(6)
      ..write(obj.PASSWORD)
      ..writeByte(7)
      ..write(obj.PASSWORD_UPD_YMD)
      ..writeByte(8)
      ..write(obj.MENUPTN_CD)
      ..writeByte(9)
      ..write(obj.TANT_KBN_CD)
      ..writeByte(10)
      ..write(obj.SYOZOKU_CD)
      ..writeByte(11)
      ..write(obj.KENGEN_CD)
      ..writeByte(12)
      ..write(obj.DAYLY_SALES)
      ..writeByte(13)
      ..write(obj.MONTHLY_SALES)
      ..writeByte(14)
      ..write(obj.KAISYU_RUIKEI)
      ..writeByte(15)
      ..write(obj.DEL_FLG)
      ..writeByte(16)
      ..write(obj.ADD_PGID)
      ..writeByte(17)
      ..write(obj.ADD_TANTCD)
      ..writeByte(18)
      ..write(obj.ADD_YMD)
      ..writeByte(19)
      ..write(obj.UPD_PGID)
      ..writeByte(20)
      ..write(obj.UPD_TANTCD)
      ..writeByte(21)
      ..write(obj.UPD_YMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'TANT_CD',
      'TANT_NAME',
      'TANT_KNAME',
      'BUZAI_HACOK_FLG',
      'SYOZOKUBUSYO_CD',
      'PASSWORD',
      'PASSWORD_UPD_YMD',
      'MENUPTN_CD',
      'TANT_KBN_CD',
      'SYOZOKU_CD',
      'KENGEN_CD',
      'DAYLY_SALES',
      'MONTHLY_SALES',
      'KAISYU_RUIKEI',
      'DEL_FLG',
      'ADD_PGID',
      'ADD_TANTCD',
      'ADD_YMD',
      'UPD_PGID',
      'UPD_TANTCD',
      'UPD_YMD'
    ],
  );
  return User(
    TANT_CD: json['TANT_CD'] as String,
    TANT_NAME: json['TANT_NAME'] as String,
    TANT_KNAME: json['TANT_KNAME'] as String,
    BUZAI_HACOK_FLG: json['BUZAI_HACOK_FLG'] as String,
    SYOZOKUBUSYO_CD: json['SYOZOKUBUSYO_CD'] as String,
    PASSWORD: json['PASSWORD'] as String,
    PASSWORD_UPD_YMD: json['PASSWORD_UPD_YMD'] as String,
    MENUPTN_CD: json['MENUPTN_CD'] as String,
    TANT_KBN_CD: json['TANT_KBN_CD'] as String,
    SYOZOKU_CD: json['SYOZOKU_CD'] as String,
    KENGEN_CD: json['KENGEN_CD'] as String,
    DAYLY_SALES: json['DAYLY_SALES'] as String,
    MONTHLY_SALES: json['MONTHLY_SALES'] as String,
    KAISYU_RUIKEI: json['KAISYU_RUIKEI'] as String,
    DEL_FLG: json['DEL_FLG'] as String,
    ADD_PGID: json['ADD_PGID'] as String,
    ADD_TANTCD: json['ADD_TANTCD'] as String,
    ADD_YMD: json['ADD_YMD'] as String,
    UPD_PGID: json['UPD_PGID'] as String,
    UPD_TANTCD: json['UPD_TANTCD'] as String,
    UPD_YMD: json['UPD_YMD'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'TANT_CD': instance.TANT_CD,
      'TANT_NAME': instance.TANT_NAME,
      'TANT_KNAME': instance.TANT_KNAME,
      'BUZAI_HACOK_FLG': instance.BUZAI_HACOK_FLG,
      'SYOZOKUBUSYO_CD': instance.SYOZOKUBUSYO_CD,
      'PASSWORD': instance.PASSWORD,
      'PASSWORD_UPD_YMD': instance.PASSWORD_UPD_YMD,
      'MENUPTN_CD': instance.MENUPTN_CD,
      'TANT_KBN_CD': instance.TANT_KBN_CD,
      'SYOZOKU_CD': instance.SYOZOKU_CD,
      'KENGEN_CD': instance.KENGEN_CD,
      'DAYLY_SALES': instance.DAYLY_SALES,
      'MONTHLY_SALES': instance.MONTHLY_SALES,
      'KAISYU_RUIKEI': instance.KAISYU_RUIKEI,
      'DEL_FLG': instance.DEL_FLG,
      'ADD_PGID': instance.ADD_PGID,
      'ADD_TANTCD': instance.ADD_TANTCD,
      'ADD_YMD': instance.ADD_YMD,
      'UPD_PGID': instance.UPD_PGID,
      'UPD_TANTCD': instance.UPD_TANTCD,
      'UPD_YMD': instance.UPD_YMD,
    };
