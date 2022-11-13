import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/menu_page/menu_page.dart';
import 'package:link_life_one/screen/page3/page_3_1_yeu_cau_bieu_mau_page.dart';

import '../../../../components/text_line_down.dart';
import '../../../../shared/assets.dart';
import '../../../../shared/custom_button.dart';

class TitleWidget extends StatefulWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 247, 240, 240))),
        width: 200,
        child: CustomButton(
          color: Colors.white70,
          onClick: () {},
          name: '工事一覧',
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
