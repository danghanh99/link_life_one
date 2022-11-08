import 'package:flutter/material.dart';
import 'package:link_life_one/screen/page5/page5_quan_ly/components/menu_page5.dart';

import '../../../components/text_line_down.dart';
import '../../../shared/assets.dart';
import '../../../shared/custom_button.dart';
import '../../menu_page/menu_page.dart';
import '../../login_page.dart';

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
              const SizedBox(
                height: 20,
              ),
              MenuPage5(listNames: listNames),
            ],
          ),
        ),
      ),
    );
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
