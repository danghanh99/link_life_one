import 'package:flutter/material.dart';
import 'package:link_life_one/screen/page4/xac_nhan_thanh_tich_page.dart';
import 'package:link_life_one/screen/page5/page_5_1_lich_kiem_ke.dart';

import '../../components/custom_text_field.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../../shared/validator.dart';
import '../menu_page/menu_page.dart';
import '../page3/page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import '../login_page.dart';
import 'page_5_2_danh_sach_nguyen_lieu.dart';
import 'page_5_3_danh_sach_nhan_lai_vat_lieu.dart';

class QuanLyNhapXuatPage extends StatefulWidget {
  const QuanLyNhapXuatPage({
    Key? key,
  }) : super(key: key);

  @override
  State<QuanLyNhapXuatPage> createState() => _QuanLyNhapXuatPageState();
}

class _QuanLyNhapXuatPageState extends State<QuanLyNhapXuatPage> {
  List<String> listNames = [
    '入庫予定表',
    '部材持ち出し 登録',
    '部材持ち戻り 登録',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 16,
          right: 16,
          left: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header(),
              title(),
              GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 2,
                children: listNames.map((name) {
                  return GestureDetector(
                    onTap: () {
                      navigateTo(name);
                    },
                    child: CustomButton(
                      color: const Color(0xFFFFFA7A),
                      onClick: () {
                        navigateTo(name);
                      },
                      name: name,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(String name) {
    //  '入庫予定表',
    // '部材持ち出し 登録',
    // '部材持ち戻り 登録',
    switch (name) {
      case ('入庫予定表'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page51LichKiemKe(),
          ),
        );
        break;

      case ('部材持ち出し 登録'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page52DanhSachNguyenLieu(),
          ),
        );
        break;

      case ('部材持ち戻り 登録'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page53DanhSachNhanLaiVatLieu(),
          ),
        );
        break;

      default:
        {}
    }
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuPage(),
              ),
            );
          },
          child: Image.asset(
            Assets.LOGO_LINK,
            width: 100,
            height: 100,
          ),
        ),
        Column(
          children: [
            TextLineDown(
                text: 'ログアウト',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }),
            const SizedBox(
              height: 10,
            ),
            TextLineDown(
                text: '戻る',
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ],
    );
  }

  Widget title() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: const Color.fromARGB(255, 247, 240, 240))),
        width: 240,
        child: CustomButton(
          color: Colors.white70,
          onClick: () {},
          name: '入出庫メニュー',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
