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
      passwordUpdYMD: fields[6] as String,
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
      addYMD: fields[17] as String,
      updPGID: fields[18] as String,
      updTantCd: fields[19] as String,
      updYMD: fields[20] as String,
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MTant _$MTantFromJson(Map<String, dynamic> json) {
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
  return MTant(
    tantCd: json['TANT_CD'] as String,
    tantName: json['TANT_NAME'] as String,
    tantKName: json['TANT_KNAME'] as String,
    buzaiHacokFlg: json['BUZAI_HACOK_FLG'] as int,
    syozokubusyoCd: json['SYOZOKUBUSYO_CD'] as String,
    password: json['PASSWORD'] as String,
    passwordUpdYMD: json['PASSWORD_UPD_YMD'] as String,
    menuPtncd: json['MENUPTN_CD'] as String,
    tantKbnCd: json['TANT_KBN_CD'] as String,
    syozokuCd: json['SYOZOKU_CD'] as String,
    kengenCd: json['KENGEN_CD'] as String,
    daylySales: json['DAYLY_SALES'] as int,
    monthlySales: json['MONTHLY_SALES'] as int,
    kaisyuRuikei: json['KAISYU_RUIKEI'] as int,
    delFlg: json['DEL_FLG'] as int,
    addPGID: json['ADD_PGID'] as String,
    addTantCd: json['ADD_TANTCD'] as String,
    addYMD: json['ADD_YMD'] as String,
    updPGID: json['UPD_PGID'] as String,
    updTantCd: json['UPD_TANTCD'] as String,
    updYMD: json['UPD_YMD'] as String,
  );
}

Map<String, dynamic> _$MTantToJson(MTant instance) => <String, dynamic>{
      'TANT_CD': instance.tantCd,
      'TANT_NAME': instance.tantName,
      'TANT_KNAME': instance.tantKName,
      'BUZAI_HACOK_FLG': instance.buzaiHacokFlg,
      'SYOZOKUBUSYO_CD': instance.syozokubusyoCd,
      'PASSWORD': instance.password,
      'PASSWORD_UPD_YMD': instance.passwordUpdYMD,
      'MENUPTN_CD': instance.menuPtncd,
      'TANT_KBN_CD': instance.tantKbnCd,
      'SYOZOKU_CD': instance.syozokuCd,
      'KENGEN_CD': instance.kengenCd,
      'DAYLY_SALES': instance.daylySales,
      'MONTHLY_SALES': instance.monthlySales,
      'KAISYU_RUIKEI': instance.kaisyuRuikei,
      'DEL_FLG': instance.delFlg,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
    };
