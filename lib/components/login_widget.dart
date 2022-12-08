import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/models/user.dart';

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
          final userBox = Hive.box<User>('userBox');
          userBox.deleteAll(userBox.keys);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        });
  }
}
