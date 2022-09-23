import 'package:flutter/material.dart';
import 'package:link_life_one/screen/menu_page.dart';
import '../components/custom_text_field.dart';
import '../shared/assets.dart';
import '../shared/custom_button.dart';
import '../shared/validator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoginEnabled = ValueNotifier(true);
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFA7A),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 16,
          right: 16,
          left: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                Assets.LOGO_LINK,
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("担当者コード"),
                  CustomTextField(
                    hint: '例) 123456789',
                    type: TextInputType.phone,
                    validator: _validateEmail,
                    controller: emailController,
                    onChanged: (text) {
                      isLoginEnabled.value = true;
                    },
                  ),
                  const Text("パスワード"),
                  CustomTextField(
                    hint: '',
                    type: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    validator: _validatePassword,
                    onChanged: (text) {
                      isLoginEnabled.value = true;
                    },
                    controller: passwordController,
                    isPassword: true,
                  ),
                  SizedBox(
                    width: size.width - 30,
                    child: CustomButton(
                      color: const Color(0xFFFFA800),
                      onClick: () {
                        if (_formKey.currentState?.validate() == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuPage(),
                            ),
                          );
                        }
                      },
                      name: 'ログイン',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateEmail(String? input) {
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return '~が存在しません。正しいコードを入九してください。';
    }
  }

  String? _validatePassword(String? input) {
    if (Validator.password(input!)) {
      return null;
    } else {
      return 'パスワードが正しくあしません。';
    }
  }
}
