import 'package:intl/intl.dart';

class ThanhTich {
  final DateTime ngayThang;
  final int? chiPhiKyGuiChuaXacNhan;
  final int? chiPhiKyGuiDaXacNhan;
  final int? soLuongCongTrinh;
  final int? soLuongXemTruoc;
  final int? soLuongBoSung;
  final int? soLuongBanHang;
  final String? tantoCd;

  ThanhTich(
      {required this.ngayThang,
      this.chiPhiKyGuiChuaXacNhan,
      this.chiPhiKyGuiDaXacNhan,
      this.soLuongCongTrinh,
      this.soLuongXemTruoc,
      this.soLuongBoSung,
      this.soLuongBanHang,
      this.tantoCd});

  factory ThanhTich.fromJson(Map<String, dynamic> json) {
    return ThanhTich(
      ngayThang: DateFormat("yyyy-MM-dd").parse(json["JISEKI_YMD"]),
      chiPhiKyGuiChuaXacNhan: int.parse(json["ITAKUHI_MIKAKUTEI"]),
      chiPhiKyGuiDaXacNhan: int.parse(json["ITAKUHI_KAKUTEI"]),
      soLuongCongTrinh: int.parse(json["KOJI_COUNT"]),
      soLuongXemTruoc: int.parse(json["SITAMI_COUNT"]),
      soLuongBoSung: int.parse(json["ADD_KOJI_COUNT"]),
      soLuongBanHang: int.parse(json["SALES_COUNT"]),
    );
  }
}
