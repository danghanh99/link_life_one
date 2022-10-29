import 'package:flutter/material.dart';
import 'package:link_life_one/screen/page7/page_7_2_2.dart';

import '../../components/custom_text_field.dart';
import '../../shared/assets.dart';
import '../page6/danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

class Page721 extends StatefulWidget {
  const Page721({
    Key? key,
  }) : super(key: key);

  @override
  State<Page721> createState() => _Page721State();
}

class _Page721State extends State<Page721> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(
          // top: 20,
          bottom: 16,
          // right: 16,
          // left: 16,
        ),
        child: Column(
          children: [
            Container(
              color: const Color(0xFF6F86D6),
              height: 30,
            ),
            Container(
              height: 50,
              width: size.width,
              color: const Color(0xFF6F86D6),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ネット工事(アポ済み)',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '戻る',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              width: size.width,
              color: const Color(0xFF91B1F9),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '登録情報：神奈川営業所事務　テキスト氏名\n2022/01/19(水) HH:MM',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '更新情報：神奈川営業所事務　テキスト氏名\n2022/01/19(水) HH:MM',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '日時',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '予定',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '人数・所用時間',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'メモ',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '参加者',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '添付ファイル',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'コメント',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFFFFFFF),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 120,
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFFA0A0A0),
                borderRadius: BorderRadius.circular(26),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Page722(),
                    ),
                  );
                },
                child: const Text(
                  '閉じる',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
