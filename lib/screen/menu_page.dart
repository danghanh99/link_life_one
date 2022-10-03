import 'package:flutter/material.dart';
import 'package:link_life_one/screen/page5/quan_ly_nhap_xuat_page.dart';
import 'package:link_life_one/screen/page6/quan_ly_thanh_vien_page.dart';
import 'package:link_life_one/screen/page7/quan_ly_lich_bieu_7_1_page.dart';
import 'package:link_life_one/screen/page7/so_tai_khoan_page.dart';
import 'package:link_life_one/screen/page4/xac_nhan_thanh_tich_page.dart';

import '../components/custom_text_field.dart';
import '../shared/assets.dart';
import '../shared/custom_button.dart';
import 'page3/bao_cao_hoan_thanh_cong_trinh_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> listNames = [
    '工事完了報告',
    'スケジュール管理',
    '実績確認',
    '入出庫管理',
    '部材管理',
    '出納帳',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Assets.LOGO_LINK,
                    width: 100,
                    height: 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ログアウト',
                      style: const TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.COMMENT_ICON,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '新着コメント',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                fillColor: const Color(0xFFD9D9D9),
                hint: '',
                type: TextInputType.emailAddress,
                onChanged: (text) {},
                maxLines: 3,
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.NEWS_ICON,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'お知らせ',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              CustomTextField(
                fillColor: const Color(0xFFD9D9D9),
                hint: '',
                type: TextInputType.emailAddress,
                onChanged: (text) {},
                maxLines: 5,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 247, 240, 240))),
                  width: 200,
                  child: CustomButton(
                    color: Colors.white70,
                    onClick: () {},
                    name: 'メニュー',
                    textStyle: const TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 2,
                children: listNames.map((name) {
                  return CustomButton(
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
    // '工事完了報告',
    // 'スケジュール管理',
    // '実績確認',
    // '入出庫管理',
    // '部材管理',
    // '出納帳',
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
            builder: (context) => const BaoCaoHoanThanhCongTrinhPage(),
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
            builder: (context) => const QuanLyThanhVienPage(),
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
