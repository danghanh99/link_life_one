import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/menu_page/menu_page.dart';
import 'package:link_life_one/screen/page3/page_3_1_yeu_cau_bieu_mau_page.dart';

import '../../../../components/text_line_down.dart';
import '../../../../shared/assets.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: GestureDetector(
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
        ),
        Column(
          children: [
            TextLineDown(
                text: 'ログアウト',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
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
}
