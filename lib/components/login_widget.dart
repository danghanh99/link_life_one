import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:link_life_one/components/text_line_down.dart';

import '../screen/login_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return TextLineDown(
        text: 'ログアウト',
        onTap: () {
          final box = Hive.box<String>('user');
          box.deleteAll(box.keys);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        });
  }
}
