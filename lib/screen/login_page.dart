import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_life_one/api/Login/login_api.dart';
import 'package:link_life_one/screen/menu_page/menu_page.dart';
import '../components/custom_text_field.dart';
import '../components/toast.dart';
import '../shared/assets.dart';
import '../shared/custom_button.dart';
import '../shared/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isLoginEnabled = ValueNotifier(true);
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFA7A),
      body: SingleChildScrollView(
        // reverse: true,
        child: Padding(
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
                  width: 200.w,
                  height: 200.h,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: _formKey,
                child: Center(
                  child: SizedBox(
                    width: 400,
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
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState?.validate() == true) {
                                onTapLoginButton();
                              }
                            },
                            child: SizedBox(
                              height: 37,
                              child: CustomButton(
                                color: const Color(0xFF6D8FDB),
                                onClick: () {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    onTapLoginButton();
                                  }
                                },
                                name: 'ログイン',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapLoginButton() {
    LoginApi().login(
        id: emailController.text,
        password: passwordController.text,
        onSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuPage(),
            ),
          );
        },
        onFailed: () {
          CustomToast.show(context, message: "担当者コードまたはパスワードが正しくありません");
        });
  }

  String? _validateEmail(String? input) {
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return '担当者コードは必須入力です';
    }
  }

  String? _validatePassword(String? input) {
    if (Validator.password(input!)) {
      return null;
    } else {
      return 'パスワードは必須入力です';
    }
  }
}
