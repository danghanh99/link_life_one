import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/sukejuuru_page_api/get_list_sukejuuru.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/page7/page_7_2_1.dart';
import 'package:link_life_one/screen/page7/page_7_2_3.dart';
import 'package:link_life_one/screen/page7/page_7_2_4.dart';
import '../../api/sukejuuru_page_api/get_anken_cua_mot_phong_ban.dart';
import '../../api/sukejuuru_page_api/get_du_lieu_cua_mot_nhan_vien_trong_phong_ban.dart';
import '../../api/sukejuuru_page_api/get_list_nhan_vien_cua_phong_ban.dart';
import '../../api/sukejuuru_page_api/get_list_phong_ban.dart';
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

  List<dynamic> listNhanVien = [];

  List<dynamic> listAnkenPhongBan = [];

  List<dynamic> sukejuuru = [];

  dynamic sukejuuruPhongBan;

  List<dynamic> listPhongBan = [];

  String nhanVien = '';

  String value1nguoi = 'グループ';
  DateTime date = DateTime.parse('2022-11-11');

  String phongBanName = '';
  String phongBanId = '';

  @override
  void initState() {
    callGetListSukejuuru(date);

    callGetListPhongBan();

    super.initState();
  }

  Future<List<dynamic>> callGetListPhongBan() async {
    final result = await GetListPhongBan().getListPhongBan(onSuccess: (list) {
      setState(() {
        listPhongBan = list;
      });

      if (listPhongBan[0]["KOJIGYOSYA_CD"] != null &&
          listPhongBan[0]["KOJIGYOSYA_CD"] != "") {
        callGetAnkenCuaMotPhongBan(
            kojiGyoSyaCd: listPhongBan[0]["KOJIGYOSYA_CD"], date: date);
        setState(() {
          phongBanId = listPhongBan[0]["KOJIGYOSYA_CD"];
          phongBanName = listPhongBan[0]["KOJIGYOSYA_NAME"];
        });
      }
    });

    return result;
  }

  Future<List<dynamic>> callGetListNhanVienCuaPhongBan(
      {required String kojiGyoSyaCd}) async {
    final result = await GetListNhanVienCuaPhongBan()
        .getListNhanVienCuaPhongBan("11009", (response) {
      print(response);
      setState(() {
        listNhanVien = response;
        nhanVien = listNhanVien.first["TANT_NAME"];
      });
    });

    return result;
  }

  Future<dynamic> callGetAnkenCuaMotPhongBan(
      {required String kojiGyoSyaCd,
      required DateTime date,
      Function? onsuccess}) async {
    final dynamic result = await GetAnkenCuaMotPhongBan()
        .getAnkenCuaMotPhongBan(kojiGyoSyaCd, date, (response) {
      setState(() {
        sukejuuru = response["PERSON"][0];
        sukejuuruPhongBan = response["OFFICE"];

        // print(response);
      });
      onsuccess?.call();
    });

    // if (result["PERSON"] != null) {
    //   callGetListNhanVienCuaPhongBan(kojiGyoSyaCd: kojiGyoSyaCd);
    // }

    return result;
  }

  Future<List<dynamic>> callGetDuLieuCuaMotNhanVienTrongPhongBan(
      {required String kojiGyoSyaCd,
      required DateTime date,
      Function? onsuccess}) async {
    final List<dynamic> result = await GetDuLieuCuaMotNhanVienTrongPhongBan()
        .getDuLieuCuaMotNhanVienTrongPhongBan(kojiGyoSyaCd, date, (body) {
      // setState(() {
      //   sukejuuru = [];

      //   sukejuuru = body;
      // });
    });

    // if (result["PERSON"] != null) {
    //   callGetListNhanVienCuaPhongBan(kojiGyoSyaCd: kojiGyoSyaCd);
    // }

    return result;
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
                          value1nguoi = 'グループ';
                        });
                      },
                      child: Text(
                        'グループ',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: value1nguoi == 'グループ'
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
                          colors: value1nguoi == 'グループ'
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
                          value1nguoi = '個人';
                        });

                        callGetListNhanVienCuaPhongBan(
                            kojiGyoSyaCd: phongBanId);
                      },
                      child: Text(
                        '個人',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: value1nguoi == '個人'
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
                          colors: value1nguoi == '個人'
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
            value1nguoi == '個人'
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
                                // callGetListSukejuuru(date);
                                callGetAnkenCuaMotPhongBan(
                                  kojiGyoSyaCd: phongBanId,
                                  date: date,
                                );
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
                            child: FutureBuilder<dynamic>(
                                future: callGetAnkenCuaMotPhongBan(
                                    kojiGyoSyaCd: phongBanId, date: date),
                                builder: (context, response) {
                                  return response.data == null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              _buildRows(0, scrollController2),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: _buildRows(
                                              sukejuuru.length + 2,
                                              scrollController2),
                                        );
                                }),
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
                // callGetListSukejuuru(date);
                callGetAnkenCuaMotPhongBan(
                  kojiGyoSyaCd: phongBanId,
                  date: date,
                );
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
              // callGetListSukejuuru(date);
              callGetAnkenCuaMotPhongBan(
                kojiGyoSyaCd: phongBanId,
                date: date,
              );
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
    List<String> list = [
      "営業所を選択 1",
      "営業所を選択 2",
      "営業所を選択 3",
      "営業所を選択 4",
      "営業所を選択 5",
      "営業所を選択 6",
      "営業所を選択 3",
      "営業所を選択 2"
    ];
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      constraints: BoxConstraints(
        minWidth: 250,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      itemBuilder: (context) => listPhongBan.map((item) {
        return PopupMenuItem(
          onTap: () {
            int index = listPhongBan.indexOf(item);
            callGetAnkenCuaMotPhongBan(
                kojiGyoSyaCd: listPhongBan[index]["KOJIGYOSYA_CD"],
                date: date,
                onsuccess: () {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     try {
//                       Future.delayed(const Duration(milliseconds: 2000), () {
// // Here you can write your code

//                         callGetListNhanVienCuaPhongBan(
//                             kojiGyoSyaCd: listPhongBan[index]["KOJIGYOSYA_CD"]);
//                       });
//                     } catch (_) {}
//                   });
                });
            setState(() {
              phongBanName = listPhongBan[index]["KOJIGYOSYA_NAME"];
              phongBanId = listPhongBan[index]["KOJIGYOSYA_CD"];
            });
          },
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      item["KOJIGYOSYA_NAME"].toString(),
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        );
      }).toList(),
      offset: const Offset(-35, 35),
      child: Container(
        width: 160,
        height: 37,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                phongBanName,
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
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
      itemBuilder: (context) => listNhanVien.map((item) {
        int index = listNhanVien.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            // int index = listNhanVien.indexOf(item);
            // callGetDuLieuCuaMotNhanVienTrongPhongBan(
            //     kojiGyoSyaCd: listNhanVien[index]["TANT_CD"], date: date);

            // setState(() {
            //   nhanVien = listNhanVien[index]["TANT_NAME"];
            // });
          },
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      item["TANT_NAME"].toString(),
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        );
      }).toList(),
      offset: const Offset(0, 40),
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
            Text(
              nhanVien,
              style: const TextStyle(
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

  List<String> _listDay() {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => index).map((value) {
      return DateFormat(('yyyy-MM-dd')).format(
        firstDayOfWeek.add(Duration(days: value)),
      );
    }).toList();
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
        if (row == 1) {
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
                        Text(
                          phongBanName,
                          style: const TextStyle(
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
                    ],
                  ),
                ],
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
                children: kojiItemsPhongBan(row - 1, col),
                // children: [Text("phong ban")],
              ),
            ),
          );
        }
        if (col == 0) {
          // bool emptyName = sukejuuru.isEmpty;
          // // if (sukejuuru.isNotEmpty) {
          // //   emptyName = sukejuuru[row - 1]["TANT_NAME"] == null ||
          // //           sukejuuru[row - 1]["TANT_NAME"].toString() == ''
          // //       ? true
          // //       : false;
          // // }
          // emptyName = true;
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
                      // Image.network(
                      //   'https://znews-stc.zdn.vn/static/topic/person/trump.jpg',
                      //   width: 40,
                      //   height: 40,
                      // ),
                      Expanded(
                        child: SizedBox(
                          width: colWidth()[col],
                          child: Text(
                            sukejuuru[row - 2]["TANT_NAME"],
                            style: const TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
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
                    // Text(
                    //   'データ 2',
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.w600),
                    // )
                  ],
                ),
              ],
            ),
          );
        } else {
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
                children: kojiItems(row - 1, col),
                // children: [Text("nhan vien")],
              ),
            ),
          );
        }
      }

      // don't use
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

  List<Widget> kojiItems(int row, int col) {
    List<Widget> xxx = [];
    _listDay().forEach(
      (element) {
        if (sukejuuru.isNotEmpty &&
            sukejuuru[row - 1] != null &&
            sukejuuru[row - 1][element] != null &&
            sukejuuru[row - 1][element].isNotEmpty &&
            element.split('-').last == listDayOfWeek()[col].split(' ').first) {
          sukejuuru[row - 1][element].forEach(
            (e) => xxx.addAll([kojiItemWithType(row - 1, col, e)]),
          );
        }
      },
    );
    xxx.add(insert());
    return xxx;
  }

  List<Widget> kojiItemsPhongBan(int row, int col) {
    List<Widget> xxx = [];

    _listDay().forEach(
      (element) {
        if (sukejuuruPhongBan != null &&
            sukejuuruPhongBan[element] != null &&
            sukejuuruPhongBan[element].isNotEmpty &&
            element.split('-').last == listDayOfWeek()[col].split(' ').first) {
          sukejuuruPhongBan[element].forEach(
            (e) => xxx.addAll([kojiItemWithType(row, col, e)]),
          );
        }
      },
    );
    xxx.add(insert());
    return xxx;
  }

  Color kojiColorWithType(e) {
    switch (e['TYPE']) {
      case 1:
        return const Color.fromARGB(255, 242, 223, 222);
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.yellow;
      case 5:
        return Colors.blue;
      case 6:
        return Colors.pinkAccent;
      case 7:
        return Colors.white;
      case 8:
        return Colors.teal;
      default:
        return const Color.fromARGB(255, 242, 223, 222);
    }
  }

  Color backgroundKojiItem(e) {
    switch (e['TYPE']) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.teal;
      case 3:
        return Colors.indigoAccent;
      case 4:
        return Colors.lightBlue;
      case 5:
        return Colors.brown;
      case 6:
        return Colors.white;
      case 7:
        return Colors.blue;
      case 8:
        return Colors.yellow;
      default:
        return const Color.fromARGB(255, 195, 161, 172);
    }
  }

  Color getColorByText({required String text}) {
    switch (text) {
      case '!! 重要 !!':
        return Colors.red;
      case 'ネット工事':
        return Color.fromARGB(255, 46, 196, 51);
      case '工事打診':
        return Color.fromARGB(255, 84, 218, 22);
      case '営業下見':
        return Colors.purple;
      case '営業工事':
        return Color.fromARGB(255, 176, 39, 73);
      case '日予実':
        return Colors.blue;
      case '計予実':
        return Colors.yellow;
      case 'ネット下見 ':
        return Colors.red;
      case '下見打診':
        return Color.fromARGB(255, 232, 105, 147);
      default:
        return Colors.white;
        ;
    }
  }

  Color getBackgroundColorByText({required String text}) {
    switch (text) {
      case '!! 重要 !!':
        return Color.fromARGB(255, 229, 165, 160);
      case 'ネット工事':
        return Color.fromARGB(255, 174, 224, 177);
      case '工事打診':
        return Color.fromARGB(255, 173, 228, 144);
      case '営業下見':
        return Color.fromARGB(255, 174, 133, 181);
      case '営業工事':
        return Color.fromARGB(255, 182, 140, 150);
      case '日予実':
        return Color.fromARGB(255, 145, 184, 215);
      case '計予実':
        return Color.fromARGB(255, 233, 225, 153);
      case 'ネット下見 ':
        return Color.fromARGB(255, 229, 165, 160);
      case '下見打診':
        return Color.fromARGB(255, 224, 192, 203);
      default:
        return Colors.white;
    }
  }

  String textKojiItem(e) {
    switch (e['TYPE']) {
      case 1:
        return "1";
      case 2:
        return "2";
      case 3:
        return "3";
      case 4:
        return "4";
      case 5:
        return "5";
      case 6:
        return "6";
      case 7:
        return "7";
      case 8:
        return "8";
      default:
        return "";
    }
  }

  Widget kojiItemWithType(int row, int col, e) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        width: colWidth()[col],
        // color: kojiColorWithType(e),
        color: getBackgroundColorByText(
          text: e["KBNMSAI_NAME"],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              e['SITAMIHOMONJIKAN'] != '' &&
                      e['SITAMIHOMONJIKAN_END'] != '' &&
                      e['SITAMIHOMONJIKAN'] != null &&
                      e['SITAMIHOMONJIKAN_END'] != null
                  ? Text(
                      "${e['SITAMIHOMONJIKAN']} - ${e['SITAMIHOMONJIKAN_END']}",
                      style: const TextStyle(fontSize: 10),
                    )
                  : (e['START_TIME'] != null && e['END_TIME'] != null)
                      ? Text(
                          "${e['START_TIME']} - ${e['END_TIME']}",
                          style: const TextStyle(fontSize: 10),
                        )
                      : Container(),
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black),
                    children: [
                      WidgetSpan(
                        child: Container(
                          // color: backgroundKojiItem(e),
                          color: getColorByText(
                            text: e["KBNMSAI_NAME"],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 2,
                            ),
                            child: Text(
                              e['KBNMSAI_NAME'],
                              style: TextStyle(
                                // color: kojiColorWithType(e),
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: e['SETSAKI_ADDRESS'],
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget insert() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              CustomDialog.showCustomDialog(
                context: context,
                title: '',
                body: Page723(
                  initialDate: date,
                ),
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
                body: Page724(
                  initialDate: date,
                ),
              );
            },
            child: const Icon(Icons.insert_drive_file_outlined),
          ),
        ],
      ),
    );
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

  Future<List<dynamic>> callGetListSukejuuru(DateTime date) async {
    final result = await GetListSukejuuru().getListSukejuuru(date);
    setState(() {
      sukejuuru = result;
    });

    return result;
  }

  Future<List<dynamic>> callGetListSukejuuruWithoutState(DateTime date) async {
    return await GetListSukejuuru().getListSukejuuru(date);
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
