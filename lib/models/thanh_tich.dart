import 'package:json_annotation/json_annotation.dart';
part 'thanh_tich.g.dart';

@JsonSerializable()
class ThanhTich {
  final DateTime ngayThang;
  final int? chiPhiKyGuiChuaXacNhan;
  final int? chiPhiKyGuiDaXacNhan;
  final int? soLuongCongTrinh;
  final int? soLuongXemTruoc;
  final int? soLuongBoSung;
  final int? soLuongBanHang;

  ThanhTich({
    required this.ngayThang,
    this.chiPhiKyGuiChuaXacNhan,
    this.chiPhiKyGuiDaXacNhan,
    this.soLuongCongTrinh,
    this.soLuongXemTruoc,
    this.soLuongBoSung,
    this.soLuongBanHang,
  });

  factory ThanhTich.fromJson(Map<String, dynamic> json) {
    return ThanhTich(
      ngayThang: json["ngayThang"],
      chiPhiKyGuiChuaXacNhan: json["chiPhiKyGuiChuaXacNhan"],
      chiPhiKyGuiDaXacNhan: json["chiPhiKyGuiDaXacNhan"],
      soLuongCongTrinh: json["soLuongCongTrinh"],
      soLuongXemTruoc: json["soLuongXemTruoc"],
      soLuongBoSung: json["soLuongBoSung"],
      soLuongBanHang: json["soLuongBanHang"],
    );
  }
}
