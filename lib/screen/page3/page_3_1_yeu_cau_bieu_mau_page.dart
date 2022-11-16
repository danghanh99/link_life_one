import 'package:flutter/material.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/page3/page_3_2_nop_anh.dart';
import 'package:flutter/cupertino.dart';

import '../../components/custom_text_field.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';

class Page31YeuCauBieuMauPage extends StatefulWidget {
  const Page31YeuCauBieuMauPage({
    Key? key,
  }) : super(key: key);

  @override
  State<Page31YeuCauBieuMauPage> createState() =>
      _Page31YeuCauBieuMauPageState();
}

class _Page31YeuCauBieuMauPageState extends State<Page31YeuCauBieuMauPage> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 16,
          right: 16,
          left: 16,
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
                              builder: (context) => LoginPage(),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 247, 240, 240))),
                width: 200,
                child: CustomButton(
                  color: Colors.white70,
                  onClick: () {},
                  name: '依頼書',
                  textStyle: const TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                TextLineDown(
                    text: '戻る',
                    onTap: () {
                      Navigator.pop(context);
                    }),
                Spacer(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  fillColor: const Color(0xFFD9D9D9),
                  hint: '',
                  type: TextInputType.emailAddress,
                  onChanged: (text) {},
                  maxLines: 25,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA6366),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              child: CupertinoAlertDialog(
                                title: const Text(
                                  "この工事を設置不可で登録を行います。\n(元に戻せません)",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                content: const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(
                                    "操作は必ず本部へ電話報告後に行ってください。\nまたサイボウズの設置不可アプリ登録は必ず行ってください。",
                                    style: TextStyle(
                                      color: Colors.black,
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
                                        '戻る',
                                        style: TextStyle(
                                          color: Color(0xFFEB5757),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); //close Dialog
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Page32NopAnh(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'はい',
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
                          });
                    },
                    child: const Text(
                      '設置不可',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: 100,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      '写真確認',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: 140,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      '工事・下見報告',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget leftNextButton(int number, String text) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 32,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.rectangle),
              fit: BoxFit.cover,
            ),
          ),
          child: number == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.polygonLeft,
                      width: 13,
                      height: 13,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.polygonLeft,
                      width: 13,
                      height: 13,
                    ),
                    Image.asset(
                      Assets.polygonLeft,
                      width: 13,
                      height: 13,
                    ),
                  ],
                ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget rightNextButton(int number, String text) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 32,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.rectangle),
              fit: BoxFit.cover,
            ),
          ),
          child: number == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.polygonRight,
                      width: 13,
                      height: 13,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.polygonRight,
                      width: 13,
                      height: 13,
                    ),
                    Image.asset(
                      Assets.polygonRight,
                      width: 13,
                      height: 13,
                    ),
                  ],
                ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget _moreButton(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => EditThemePage(
          //           index: index,
          //           meditationThemeDTO: meditationThemeDTO,
          //         )));
        }
        if (number == 2) {}
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 1,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "投函数を選択",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "投函数を選択",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(-35, -90),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "投函数を選択",
              style: TextStyle(
                color: Color(0xFF042C5C),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset(
              Assets.icDown,
              width: 13,
              height: 13,
            ),
          ],
        ),
      ),
    );
  }
}
