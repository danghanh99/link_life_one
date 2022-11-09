import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/models/lich_trinh.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/page7/page_7_2_1.dart';
import 'package:link_life_one/screen/page7/page_7_2_3.dart';
import 'package:link_life_one/screen/page7/page_7_2_4.dart';
import 'package:link_life_one/services/lich_trinh_service.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';
import 'component/dialog.dart';
import 'component/popup_hien_thi.dart';

class QuanLyLichBieu71Page extends StatefulWidget {
  const QuanLyLichBieu71Page({
    Key? key,
  }) : super(key: key);

  @override
  State<QuanLyLichBieu71Page> createState() => _QuanLyLichBieu71PageState();
}

class _QuanLyLichBieu71PageState extends State<QuanLyLichBieu71Page> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];
  List<LichTrinh> lichTrinh = [];
  String value = 'グループ';
  late bool show721;
  DateTime date = DateTime.now();

  @override
  void initState() {
    show721 = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    ScrollController scrollController2 = ScrollController();
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 16,
          right: 16,
          left: 16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backToMenu(),
                Column(
                  children: [
                    logout(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextLineDown(
                        text: '戻る',
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ],
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 247, 240, 240))),
                width: 200,
                child: CustomButton(
                  color: Colors.white70,
                  onClick: () {},
                  name: 'スケジュール管理',
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
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  '協力店名 / 営業所名',
                  style: TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      // CustomDialog.showCustomDialog(
                      //   context: context,
                      //   title: '',
                      //   body: const PopupHienThi(),
                      // );
                    },
                    child: const Text(
                      '表示',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          value = 'グループ';
                        });
                      },
                      child: Text(
                        'グループ',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: value == 'グループ'
                                  ? <Color>[
                                      const Color(0xFF6F86D6),
                                      const Color(0xFF48C6EF)
                                    ]
                                  : <Color>[
                                      const Color(0xFF042C5C),
                                      const Color(0xFF042C5C)
                                    ],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: value == 'グループ'
                              ? [
                                  const Color(0xFF6F86D6),
                                  const Color(0xFF48C6EF)
                                ]
                              : [
                                  const Color(0xFFDFE0E3),
                                  const Color(0xFFDFE0E3)
                                ],
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          value = '個人';
                        });
                      },
                      child: Text(
                        '個人',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: value == '個人'
                                  ? <Color>[
                                      const Color(0xFF6F86D6),
                                      const Color(0xFF48C6EF)
                                    ]
                                  : <Color>[
                                      const Color(0xFF042C5C),
                                      const Color(0xFF042C5C)
                                    ],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: value == '個人'
                              ? [
                                  const Color(0xFF6F86D6),
                                  const Color(0xFF48C6EF)
                                ]
                              : [
                                  const Color(0xFFDFE0E3),
                                  const Color(0xFFDFE0E3)
                                ],
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            value == '個人'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _moreButton2(context),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 120,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C8EDA),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () {
                            CustomDialog.showCustomDialog(
                              context: context,
                              title: '',
                              body: const PopupHienThi(),
                            );
                          },
                          child: const Text(
                            '休日確認',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        leftNextButton('先週'),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                            right: 8,
                            left: 8,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime(2100));
                              if (picked != null && picked != date) {
                                setState(() {
                                  date = picked;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.icCalendar,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  DateFormat('yyyy /MM / dd (E)', 'ja')
                                      .format(date)
                                      .toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF77869E),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        rightNextButton('翌週'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            print('scrolling.... ${scrollInfo.metrics.pixels}');
                            scrollController.jumpTo(scrollInfo.metrics.pixels);
                            return false;
                          },
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _buildRows(10, scrollController2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildLastRows2(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget leftNextButton(String text) {
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
          child: GestureDetector(
            onTap: () {
              setState(() {
                date = date.add(const Duration(days: -7));
              });
            },
            child: Row(
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

  Widget rightNextButton(String text) {
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
          child: GestureDetector(
            onTap: () {
              setState(() {
                date = date.add(const Duration(days: 7));
              });
            },
            child: Row(
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
        if (number == 1) {}
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
                "営業所を選択",
                style: TextStyle(color: Color(0xFF999999)),
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
                "営業所を選択",
                style: TextStyle(color: Color(0xFF999999)),
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(-35, -90),
      child: Container(
        width: 130,
        height: 37,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "営業所を選択",
              style: TextStyle(
                color: Color(0xFF999999),
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

  Widget _moreButton2(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {}
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
                "営業所を選択",
                style: TextStyle(color: Color(0xFF999999)),
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
                style: TextStyle(color: Color(0xFF999999)),
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(-35, -90),
      child: Container(
        width: 200,
        height: 37,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "愛知営業所　テスト 太郎",
              style: TextStyle(
                color: Color(0xFF999999),
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

  // TABLE begin
  List<Widget> _buildRows(int count, ScrollController scrollController2) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(8, index, scrollController2),
      );
    });
  }

  List<Widget> _buildLastRows2(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildLastRowCells(8, index),
      );
    });
  }

  List<String> listDayOfWeek() {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(8, (index) => index).map((value) {
      if (value == 0) {
        return '';
      }
      return DateFormat(('dd  (E)'), 'ja').format(
        firstDayOfWeek.add(Duration(days: value - 1)),
      );
    }).toList();
  }

  List<double> colWidth() {
    return List<double>.generate(10, (int index) {
      if (index == 0) return 200;
      return 150.0;
    }, growable: true);
  }

  void getList() async {
    final list = await LichTrinhService.danhSachLichTrinh();
    setState(() {
      lichTrinh = list;
    });
  }

  List<Widget> _buildCells2(
      int count, int row, ScrollController scrollController2) {
    return List.generate(count, (col) {
      if (row == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFFA5A7A9),
          ),
          alignment: Alignment.center,
          width: colWidth()[col],
          height: 30,
          child: Text(
            listDayOfWeek()[col],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }

      if (row != 0) {
        if (col == 0) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.white,
            ),
            alignment: Alignment.topLeft,
            width: colWidth()[col],
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 5),
                  child: Row(
                    children: [
                      Image.network(
                        'https://znews-stc.zdn.vn/static/topic/person/trump.jpg',
                        width: 40,
                        height: 40,
                      ),
                      const Text(
                        'データ 1',
                        style: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.black,
                      size: 40.0,
                    ),
                    Text(
                      'データ 2',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          String value = '追加希望 追加希望 追加希望 追加希望 追加希望';
          String firstPart = value.split(' ').toList()[0];
          String secondPart = value.substring(firstPart.length, value.length);

          String value2 = 'ネット工事 ネット工事 ネット工事 ネット工事 ネット工事';
          String firstPart2 = value2.split(' ').toList()[0];
          String secondPart2 =
              value2.substring(firstPart2.length, value2.length);
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.white,
            ),
            alignment: Alignment.topLeft,
            width: colWidth()[col],
            height: 400,
            child: GestureDetector(
              onTap: () {
                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: const Page721(),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: colWidth()[col],
                    color: const Color.fromARGB(255, 198, 221, 231),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '9:00-10:00',
                            style: TextStyle(fontSize: 10),
                          ),
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      color: const Color.fromARGB(
                                          255, 23, 137, 229),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          firstPart,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: secondPart,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: colWidth()[col],
                    color: const Color.fromARGB(255, 191, 222, 209),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '10:30-12:30',
                            style: TextStyle(fontSize: 10),
                          ),
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      color: const Color.fromARGB(
                                          255, 22, 176, 60),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          firstPart2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: secondPart2,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: colWidth()[col],
                    color: const Color.fromARGB(255, 241, 241, 224),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '10:30-12:30',
                            style: TextStyle(fontSize: 10),
                          ),
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      color: const Color.fromARGB(
                                          255, 224, 195, 88),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          firstPart2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: secondPart2,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: colWidth()[col],
                    color: const Color.fromARGB(255, 242, 223, 222),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '10:30-12:30',
                            style: TextStyle(fontSize: 10),
                          ),
                          RichText(
                            text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      color: Colors.red,
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 2,
                                        ),
                                        child: Text(
                                          '!! 重要 !!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: secondPart2,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            CustomDialog.showCustomDialog(
                              context: context,
                              title: '',
                              body: const Page723(),
                            );
                          },
                          child: const Icon(
                            Icons.add_circle,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            CustomDialog.showCustomDialog(
                              context: context,
                              title: '',
                              body: const Page724(),
                            );
                          },
                          child: const Icon(Icons.insert_drive_file_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
        ),
        alignment: Alignment.topLeft,
        width: colWidth()[col],
        height: 400,
        child: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      );
    });
  }

  List<Widget> _buildLastRowCells(int count, int row) {
    return List.generate(count, (col) {
      if (row == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFFA5A7A9),
          ),
          alignment: Alignment.center,
          width: colWidth()[col],
          height: 30,
          child: Text(
            listDayOfWeek()[col],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
        ),
        alignment: Alignment.topLeft,
        width: colWidth()[col],
        height: 200,
        child: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      );
    });
  }

  Widget backToMenu() {
    return GestureDetector(
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
    );
  }

  Widget logout() {
    return TextLineDown(
        text: 'ログアウト',
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        });
  }
}
