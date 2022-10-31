import 'package:check_points/check_point.dart';
import 'package:flutter/material.dart';

import '../../components/custom_text_field.dart';
import '../../shared/assets.dart';
import '../page6/danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

class Page724 extends StatefulWidget {
  const Page724({
    Key? key,
  }) : super(key: key);

  @override
  State<Page724> createState() => _Page724State();
}

class _Page724State extends State<Page724> {
  late bool checkedValue;
  late String memo;
  late String kaigiKara;
  late String kaigiMade;

  @override
  void initState() {
    memo = 'メモ';
    kaigiKara = '10：00';
    kaigiMade = '12：00';
    checkedValue = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              color: const Color(0xFFFFFA7A),
              height: 30,
            ),
            Container(
              height: 50,
              width: size.width,
              color: const Color(0xFFFFFA7A),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'メモ登録',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 16,
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
                      '概要',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _moreButton(context),
                      // const Spacer(),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       activeColor: Colors.blue,
                      //       checkColor: Colors.white,
                      //       value: checkedValue,
                      //       onChanged: (newValue) {
                      //         setState(() {
                      //           checkedValue = newValue ?? true;
                      //         });
                      //       },
                      //     ),
                      //     const Text(
                      //       'アポイント済み',
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '2022年01月19日(水)',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          _moreButton2(context),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            '~',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          _moreButton3(context),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue ?? true;
                              });
                            },
                          ),
                          const Text(
                            '終日',
                          ),
                        ],
                      ),
                    ],
                  ),
                  // CustomTextField(
                  //   fillColor: const Color(0xFFFFFFFF),
                  //   hint: '',
                  //   type: TextInputType.emailAddress,
                  //   onChanged: (text) {},
                  //   maxLines: 1,
                  // ),
                  const SizedBox(
                    height: 5,
                  ),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '内容',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFF5F6F8),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 6,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C8EDA),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const DanhSachDatHangVatLieu611Page(),
                      //   ),
                      // );
                    },
                    child: const Text(
                      '登録',
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
                  width: 10,
                ),
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF96265),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         const DanhSachDatHangVatLieu611Page(),
                      //   ),
                      // );

                      Navigator.pop(context);
                    },
                    child: const Text(
                      '削除',
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
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _moreButton(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {
          setState(() {
            memo = 'メモ';
          });
        }
        if (number == 2) {
          setState(() {
            memo = '追加STOP';
          });
        }
        if (number == 3) {
          setState(() {
            memo = '追加希望';
          });
        }
        if (number == 4) {
          setState(() {
            memo = '休み';
          });
        }
        if (number == 5) {
          setState(() {
            memo = '月次';
          });
        }
        if (number == 6) {
          setState(() {
            memo = '重要';
          });
        }
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
                "メモ",
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
                "追加STOP",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "追加希望",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "休み",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "月次",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "重要",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(0, 30),
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              memo,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 14,
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

  Widget _moreButton2(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {
          setState(() {
            kaigiKara = '9:00';
          });
        }
        if (number == 2) {
          setState(() {
            kaigiKara = '9:30';
          });
        }
        if (number == 3) {
          setState(() {
            kaigiKara = '10:00';
          });
        }
        if (number == 4) {
          setState(() {
            kaigiKara = '10:30';
          });
        }
        if (number == 5) {
          setState(() {
            kaigiKara = '11:00';
          });
        }
        if (number == 6) {
          setState(() {
            kaigiKara = '11:30';
          });
        }
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
                "9:00",
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
                "9:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 3,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 4,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 5,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 6,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:30",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(0, 30),
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              kaigiKara,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 14,
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

  Widget _moreButton3(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {
          setState(() {
            kaigiMade = '9:00';
          });
        }
        if (number == 2) {
          setState(() {
            kaigiMade = '9:30';
          });
        }
        if (number == 3) {
          setState(() {
            kaigiMade = '10:00';
          });
        }
        if (number == 4) {
          setState(() {
            kaigiMade = '10:30';
          });
        }
        if (number == 5) {
          setState(() {
            kaigiMade = '11:00';
          });
        }
        if (number == 6) {
          setState(() {
            kaigiMade = '11:30';
          });
        }
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
                "9:00",
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
                "9:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 3,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 4,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 5,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 6,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:30",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(0, 30),
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              kaigiMade,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 14,
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
