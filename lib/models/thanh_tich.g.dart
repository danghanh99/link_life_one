// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thanh_tich.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThanhTich _$ThanhTichFromJson(Map<String, dynamic> json) => ThanhTich(
      ngayThang: DateTime.parse(json['ngayThang'] as String),
      chiPhiKyGuiChuaXacNhan: json['chiPhiKyGuiChuaXacNhan'] as int?,
      chiPhiKyGuiDaXacNhan: json['chiPhiKyGuiDaXacNhan'] as int?,
      soLuongCongTrinh: json['soLuongCongTrinh'] as int?,
      soLuongXemTruoc: json['soLuongXemTruoc'] as int?,
      soLuongBoSung: json['soLuongBoSung'] as int?,
      soLuongBanHang: json['soLuongBanHang'] as int?,
    );

Map<String, dynamic> _$ThanhTichToJson(ThanhTich instance) => <String, dynamic>{
      'ngayThang': instance.ngayThang.toIso8601String(),
      'chiPhiKyGuiChuaXacNhan': instance.chiPhiKyGuiChuaXacNhan,
      'chiPhiKyGuiDaXacNhan': instance.chiPhiKyGuiDaXacNhan,
      'soLuongCongTrinh': instance.soLuongCongTrinh,
      'soLuongXemTruoc': instance.soLuongXemTruoc,
      'soLuongBoSung': instance.soLuongBoSung,
      'soLuongBanHang': instance.soLuongBanHang,
    };
