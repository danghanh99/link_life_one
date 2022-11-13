import 'package:flutter/material.dart';
import 'package:link_life_one/screen/page5/page5_quan_ly/quan_ly_nhap_xuat_page.dart';
import 'package:link_life_one/screen/page6/page6_quan_ly/page_6_quan_ly_thanh_vien.dart';
import 'package:link_life_one/screen/page7/quan_ly_lich_bieu_7_1_page.dart';
import 'package:link_life_one/screen/page7/page_7_so_tai_khoan_page.dart';
import 'package:link_life_one/screen/page4/xac_nhan_thanh_tich_page.dart';

import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../page3/page_3/page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import 'components/list_comment.dart';
import 'components/list_thong_bao.dart';
import 'components/menu.dart';

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

  List<String> listComments = [
    '2022 / 11 / 11　工事のテスト様に新着コメントがあります。',
  ];

  List<String> listThongBao = [
    '未処理の入庫が 10 件あります。',
    '未処理の完了報告が 5 件あります。',
    '未処理の下見が 3 件あります。',
    '未処理の部材発注申請が 5 件あります。',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFDFE0E3),
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ログアウト',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
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
                  const Spacer(),
                  const Text(
                    '既読にする',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const ListComment(),
              const SizedBox(
                height: 5,
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
              const SizedBox(
                height: 5,
              ),
              const ListThongBao(),
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
              const SizedBox(
                height: 20,
              ),
              Menu(
                listNames: listNames,
              )
              // GridView.count(
              //   crossAxisCount: 2,
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   mainAxisSpacing: 10,
              //   crossAxisSpacing: 20,navigateTo
              //   childAspectRatio: 2,
              //   children: listNames.map((name) {
              //     return GestureDetector(
              //       onTap: () {
              //         navigateTo(name);
              //       },
              //       child: CustomButton(
              //         color: const Color(0xFFFFFA7A),
              //         onClick: () {
              //           navigateTo(name);
              //         },
              //         name: name,
              //         textStyle: const TextStyle(
              //           color: Colors.black,
              //           fontSize: 18,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),
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
