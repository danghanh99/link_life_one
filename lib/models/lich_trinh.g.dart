// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lich_trinh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LichTrinh _$LichTrinhFromJson(Map<String, dynamic> json) => LichTrinh(
      id: json['id'] as int,
      gio: json['gio'] as String,
      ghiChu: json['ghiChu'] as String?,
      trangThai: json['trangThai'] as String,
    );

Map<String, dynamic> _$LichTrinhToJson(LichTrinh instance) => <String, dynamic>{
      'id': instance.id,
      'gio': instance.gio,
      'trangThai': instance.trangThai,
      'ghiChu': instance.ghiChu,
    };
