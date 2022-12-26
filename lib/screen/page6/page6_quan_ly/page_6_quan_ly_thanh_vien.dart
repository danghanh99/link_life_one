import 'package:flutter/material.dart';
import 'package:link_life_one/screen/page6/page6_quan_ly/components/menu_page6.dart';

import '../../../components/custom_header_widget.dart';
import '../../../components/login_widget.dart';
import '../../../components/text_line_down.dart';
import '../../../shared/assets.dart';
import '../../../shared/custom_button.dart';
import '../../menu_page/menu_page.dart';
import '../../login_page.dart';

class Page6QuanLyThanhVien extends StatefulWidget {
  const Page6QuanLyThanhVien({
    Key? key,
  }) : super(key: key);

  @override
  State<Page6QuanLyThanhVien> createState() => _Page6QuanLyThanhVienState();
}

class _Page6QuanLyThanhVienState extends State<Page6QuanLyThanhVien> {
  List<String> listNames = [
    '部材発注',
    '棚卸',
    '発注承認',
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
              MenuPage6(listNames: listNames)
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return const CustomHeaderWidget();
  }

  Widget title() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border:
                Border.all(color: const Color.fromARGB(255, 247, 240, 240))),
        width: 300,
        child: CustomButton(
          color: Colors.white70,
          onClick: () {},
          name: '部材発注・棚卸 メニュー',
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
