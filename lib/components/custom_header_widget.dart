import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/models/user.dart';

import '../screen/login_page.dart';
import '../screen/menu_page/menu_page.dart';
import '../shared/assets.dart';
import 'login_widget.dart';

class CustomHeaderWidget extends StatefulWidget {
  const CustomHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomHeaderWidget> createState() => _CustomHeaderWidgetState();
}

class _CustomHeaderWidgetState extends State<CustomHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextLineDown(
            text: '戻る',
            onTap: () {
              Navigator.pop(context);
            }),
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
          children: const [
            LoginWidget(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
