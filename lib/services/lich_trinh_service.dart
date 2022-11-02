import 'package:link_life_one/models/lich_trinh.dart';

class LichTrinhService {
  static Future<List<LichTrinh>> danhSachLichTrinh() async {
    try {
      List<LichTrinh> list = [];
      await Future.delayed(const Duration(milliseconds: 100), () {
        list.addAll([
          LichTrinh(
              id: 1, gio: '09:00 - 10:00', ghiChu: 'メモ', trangThai: 'ネット工事'),
          LichTrinh(
              id: 1, gio: '09:00 - 10:00', ghiChu: 'メモ', trangThai: 'ネット工事'),
          LichTrinh(
              id: 1, gio: '09:00 - 10:00', ghiChu: 'メモ', trangThai: 'ネット工事')
        ]);
      });
      return list;
    } catch (e) {
      return [];
    }
  }
}
