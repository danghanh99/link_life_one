import 'package:flutter/material.dart';
import 'package:link_life_one/screen/xac_nhan_thanh_tich_page.dart';

import '../components/custom_text_field.dart';
import '../shared/assets.dart';
import '../shared/custom_button.dart';
import '../shared/validator.dart';
import 'bao_cao_hoan_thanh_cong_trinh_page.dart';
import 'login_page.dart';

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
      default:
        {}
    }
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          Assets.LOGO_LINK,
          width: 100,
          height: 100,
        ),
        Column(
          children: [
            textLineDown('ログアウト', () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            }),
            textLineDown('戻る', () {
              Navigator.pop(context);
            }),
          ],
        ),
      ],
    );
  }

  Widget textLineDown(String text, Function() onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap.call();
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF042C5C),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
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
