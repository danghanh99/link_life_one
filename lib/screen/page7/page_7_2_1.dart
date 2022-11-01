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
  late bool show722;

  @override
  void initState() {
    show722 = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return show722
        ? Page722()
        : Column(
            children: [
              Container(
                height: 50,
                color: const Color.fromARGB(255, 96, 186, 234),
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
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //   },
                      //   child: const Text(
                      //     '戻る',
                      //     style: TextStyle(
                      //       color: Color(0xFF042C5C),
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 70,
                // width: size.width,
                color: Color.fromARGB(255, 175, 215, 237),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Column(
                    children: const [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '登録情報：神奈川営業所事務　テキスト氏名 2022/01/19(水) HH:MM',
                          style: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 15,
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
                          '更新情報：神奈川営業所事務　テキスト氏名 2022/01/19(水) HH:MM',
                          style: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 15,
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
                child: Container(
                  // height: 400,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Text(
                              '日時',
                              style: TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '2022年01月19日(水) 10：00  〜  12：00',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 100,
                            height: 37,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 237, 189, 116),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  show722 = !show722;
                                });
                              },
                              child: const Text(
                                '時間変更',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Align(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'ネット工事(アポ済み)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 100,
                            height: 37,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 237, 189, 116),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  show722 = !show722;
                                });
                              },
                              child: const Text(
                                'タグ変更',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Align(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    '人',
                                    style: TextStyle(
                                      color: Color(0xFF042C5C),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('時間')
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: 160,
                            height: 37,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 237, 189, 116),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  show722 = !show722;
                                });
                              },
                              child: const Text(
                                '人数・所用時間変更',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Align(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 120,
                            height: 37,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 237, 189, 116),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  show722 = !show722;
                                });
                              },
                              child: const Text(
                                'メモ内容変更',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Align(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'テキスト太郎',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Align(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 130,
                            child: Align(
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '',
                            maxLines: 5,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Expanded(child: Container()),
              Container(
                width: 120,
                height: 37,
                decoration: BoxDecoration(
                  color: const Color(0xFFA0A0A0),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const Page722(),
                    //   ),
                    // );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '閉じる',
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
                height: 10,
              ),
            ],
          );
  }
}
