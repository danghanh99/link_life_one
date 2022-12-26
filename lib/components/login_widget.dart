import 'package:flutter/cupertino.dart';
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
          showDialog(
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: CupertinoAlertDialog(
                  title: const Text(
                    "ご確認",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "ログアウトします。\n よろしいですか？",
                      style: TextStyle(
                        color: Color.fromARGB(255, 24, 23, 23),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context); //close Dialog
                        },
                        child: const Text(
                          'キャンセル',
                          style: TextStyle(
                            color: Color(0xFFEB5757),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    TextButton(
                      onPressed: () {
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
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
