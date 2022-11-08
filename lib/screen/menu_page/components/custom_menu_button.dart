import 'package:flutter/material.dart';

import '../../../shared/custom_button.dart';
import '../../page3/page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import '../../page4/xac_nhan_thanh_tich_page.dart';
import '../../page5/quan_ly_nhap_xuat_page.dart';
import '../../page6/page_6_quan_ly_thanh_vien.dart';
import '../../page7/page_7_so_tai_khoan_page.dart';
import '../../page7/quan_ly_lich_bieu_7_1_page.dart';

class CustomMenuButton extends StatefulWidget {
  final String name;
  final double? width;
  final double? height;
  const CustomMenuButton({
    required this.name,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomMenuButton> createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(widget.name);
      },
      child: SizedBox(
        width: widget.width ?? widget.width,
        height: widget.height ?? widget.height,
        child: CustomButton(
          color: const Color(0xFFFFFA7A),
          onClick: () {
            navigateTo(widget.name);
          },
          name: widget.name,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void navigateTo(String name) {
    switch (name) {
      case ('スケジュール管理'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuanLyLichBieu71Page(),
          ),
        );
        break;
      case ('出納帳'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SoTaiKhoanPage(),
          ),
        );
        break;
      case ('工事完了報告'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page3BaoCaoHoanThanhCongTrinh(),
          ),
        );
        break;

      case ('実績確認'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const XacNhanThanhTichPage(),
          ),
        );
        break;

      case ('部材管理'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page6QuanLyThanhVien(),
          ),
        );
        break;

      case ('入出庫管理'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuanLyNhapXuatPage(),
          ),
        );
        break;

      default:
        {}
    }
  }
}
