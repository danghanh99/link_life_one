import 'package:flutter/material.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/page3/yeu_cau_bieu_mau_page.dart';

import '../../components/custom_text_field.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';

class BaoCaoHoanThanhCongTrinhPage extends StatefulWidget {
  const BaoCaoHoanThanhCongTrinhPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BaoCaoHoanThanhCongTrinhPage> createState() =>
      _BaoCaoHoanThanhCongTrinhPageState();
}

class _BaoCaoHoanThanhCongTrinhPageState
    extends State<BaoCaoHoanThanhCongTrinhPage> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
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
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  Assets.LOGO_LINK,
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    textLineDown('ログアウト', () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    }),
                    textLineDown('戻る', () {
                      Navigator.pop(context);
                    }),
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
                  name: '工事一覧',
                  textStyle: const TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 5,
                ),
                leftNextButton(2, '先週'),
                const SizedBox(width: 8),
                leftNextButton(1, '前日'),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    right: 8,
                    left: 8,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icCalendar,
                      ),
                      const SizedBox(width: 3),
                      const Text(
                        "2022 / 08 / 23 (火)",
                        style: TextStyle(
                          color: Color(0xFF77869E),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                rightNextButton(1, '翌日'),
                const SizedBox(width: 8),
                rightNextButton(2, '翌週'),
              ],
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
              child: ListView.separated(
                shrinkWrap: true,
                reverse: true,
                padding: const EdgeInsets.only(right: 15, left: 15),
                itemCount: listNames.length,
                itemBuilder: (ctx, i) {
                  return CustomTextField(
                    fillColor: const Color(0xFFD9D9D9),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 5,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 5,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 120,
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFF4F4F4F),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '続きを見る',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                const Text(
                  '続きを見る',
                  style: TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: _moreButton(context),
                ),
                Container(
                  width: 70,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const YeuCauBieuMauPage(),
                        ),
                      );
                    },
                    child: const Text(
                      '更新',
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
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget textLineDown(String text, Function() onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap.call();
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF042C5C),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
