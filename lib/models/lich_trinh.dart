import 'package:json_annotation/json_annotation.dart';
part 'lich_trinh.g.dart';

@JsonSerializable()
class LichTrinh {
  final int id;
  final String gio;
  final String trangThai;
  final String? ghiChu;

  LichTrinh(
      {required this.id,
      required this.gio,
      this.ghiChu,
      required this.trangThai});
}
