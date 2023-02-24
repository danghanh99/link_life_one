import 'package:check_points/check_point.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/sukejuuru_page_api/eigyo_anken/create_eigyo_anken_api/create_eigyo_anken.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page7/memo/page_7_2_4_create.dart';

import '../../../../api/sukejuuru_page_api/eigyo_anken/details_vs_pull_down_eigyo_anken/get_sales_construction_sales_preview_contents.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../shared/assets.dart';
import '../../../../shared/validator.dart';
import '../../../page6/saibuhachuulist_danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

class Page723 extends StatefulWidget {
  final DateTime initialDate;
  final String TANT_CD;
  final bool isPhongBan;
  final Function onCreateAnkenSuccessfull;
  const Page723({
    required this.initialDate,
    required this.TANT_CD,
    required this.isPhongBan,
    required this.onCreateAnkenSuccessfull,
    Key? key,
  }) : super(key: key);

  @override
  State<Page723> createState() => _Page723State();
}

class _Page723State extends State<Page723> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  // late bool checkedValue;
  // late String nettoKoJi;
  // late String kaigiKara;
  // late String kaigiMade;
  bool validJikanKara = true;
  bool validJikanMade = true;

  late List<dynamic> listPullDownCreateAnkenPage = [
    {"KBNMSAI_NAME": "営業工事"},
    {"KBNMSAI_NAME": "営業下見"}
  ];
  late DateTime datetimeCreateAnkenPage = DateTime.now();
  late String jikanKaraCreateAnkenPage = '';
  late String jikanMadeCreateAnkenPage = '';
  late bool checkAllDayCreateAnkenPage = false;
  late String jinNumberCreateAnkenPage = '0';
  late String jikanNumberCreateAnkenPage = '0';
  late String okyakuSamaCreateAnkenPage = '';
  late String sankasha1CreateAnkenPage = '';
  late String sankasha2CreateAnkenPage = '';
  late String sankasha3CreateAnkenPage = '';
  int selectedPullDownIndex = 0;

  String currentPullDownValue = '';

  List<dynamic> listDateTime1 = [
    "00:00",
    "00:30",
    "01:00",
    "01:30",
    "02:00",
    "02:30",
    "03:00",
    "03:30",
    "04:00",
    "04:30",
    "05:00",
    "05:30",
    "06:00",
    "06:30",
    "07:00",
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "20:30",
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30",
  ];
  List<dynamic> listDateTime2 = [
    "00:00",
    "00:30",
    "01:00",
    "01:30",
    "02:00",
    "02:30",
    "03:00",
    "03:30",
    "04:00",
    "04:30",
    "05:00",
    "05:30",
    "06:00",
    "06:30",
    "07:00",
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "20:30",
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30",
  ];
  @override
  void initState() {
    checkAllDayCreateAnkenPage = false;
    jikanKaraCreateAnkenPage = listDateTime1[0];
    jikanMadeCreateAnkenPage = listDateTime2[0];
    callGetPullDownAnken();
    super.initState();
  }

  Future<dynamic> callGetPullDownAnken({Function? onsuccess}) async {
    final dynamic result =
        GetPullDownAnken().getSalesConstructionSalesPreviewContents(
      onSuccess: (result) {
        setState(() {
          listPullDownCreateAnkenPage = result["PULLDOWN"];
          currentPullDownValue = listPullDownCreateAnkenPage[0]["KBNMSAI_NAME"];
          selectedPullDownIndex = 0;
        });
        print(result);
      },
      onFailed: () {
        CustomToast.show(context, message: "データを取得出来ませんでした。");
      },
    );

    return result;
  }

  bool checkDate() {
    DateTime fromDate =
        DateTime.parse("2023-01-01 $jikanKaraCreateAnkenPage:00");
    DateTime toDate = DateTime.parse("2023-01-01 $jikanMadeCreateAnkenPage:00");
    return !checkAllDayCreateAnkenPage && fromDate.compareTo(toDate) >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 650,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 50,
              color: const Color.fromARGB(255, 229, 164, 68),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '営業案件登録',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'タグ',
                            style: TextStyle(
                              color: Color(0xFF042C5C),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      _moreButton(context),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 130,
                        child: const Align(
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
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('yyyy年MM月dd日(E)', 'ja')
                              .format(widget.initialDate)
                              .toString(),
                          style: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: checkAllDayCreateAnkenPage
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  checkAllDayCreateAnkenPage
                                      ? Text("-")
                                      : Column(
                                          children: [
                                            _moreButton2(context),
                                            validJikanKara
                                                ? Container()
                                                : const Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "未選択",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                ],
                              ),
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
                              checkAllDayCreateAnkenPage
                                  ? Text("-")
                                  : Column(
                                      children: [
                                        _moreButton3(context),
                                        validJikanMade
                                            ? Container()
                                            : const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "未選択",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                      ],
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Visibility(
                              visible: checkDate(),
                              child: const Text('開始時間より遅い終了時間を選択くだだい。',
                                  style: TextStyle(color: Colors.red))),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                value: checkAllDayCreateAnkenPage,
                                onChanged: (newValue) {
                                  if (newValue == true) {
                                    setState(() {
                                      checkAllDayCreateAnkenPage = true;

                                      jikanKaraCreateAnkenPage = "08:00";
                                      jikanMadeCreateAnkenPage = "19:00";
                                    });
                                  } else {
                                    setState(() {
                                      checkAllDayCreateAnkenPage = newValue ??
                                          checkAllDayCreateAnkenPage;
                                    });
                                  }
                                },
                              ),
                              const Text(
                                '終日',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: SizedBox(
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
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: size.width / 2 - 80,
                            width: 80,
                            child: CustomTextField(
                              maxLength: 2,
                              validator: _validateNumber,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: jinNumberCreateAnkenPage.toString(),
                              type: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  jinNumberCreateAnkenPage = text;
                                });
                              },
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '人',
                              style: TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      ),
                      // const Spacer(),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: size.width / 2 - 80,
                            width: 80,
                            child: CustomTextField(
                              maxLength: 10,
                              validator: _validateNumber2,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: jikanNumberCreateAnkenPage.toString(),
                              type: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  jikanNumberCreateAnkenPage = text;
                                });
                              },
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '時間',
                              style: TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 130,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'お客様名',
                            style: TextStyle(
                              color: Color(0xFF042C5C),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 420,
                        child: CustomTextField(
                          fillColor: const Color(0xFFF5F6F8),
                          hint: '',
                          type: TextInputType.emailAddress,
                          onChanged: (text) {
                            setState(() {
                              okyakuSamaCreateAnkenPage = text;
                            });
                          },
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 130,
                        child: const Align(
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
                      Column(
                        children: [
                          Container(
                            width: 420,
                            child: CustomTextField(
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  sankasha1CreateAnkenPage = text;
                                });
                              },
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 420,
                            child: CustomTextField(
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  sankasha2CreateAnkenPage = text;
                                });
                              },
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 420,
                            child: CustomTextField(
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  sankasha3CreateAnkenPage = text;
                                });
                              },
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded(child: Container()),
            SizedBox(
              height: 10,
            ),
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
                      if (checkDate()) {
                        return;
                      }
                      // if (jikanKaraCreateAnkenPage == null ||
                      //     jikanMadeCreateAnkenPage == null) {
                      //   setState(() {
                      //     validJikanKara = false;
                      //   });
                      // }
                      // if (jikanKaraCreateAnkenPage == null ||
                      //     jikanMadeCreateAnkenPage == null) {
                      //   setState(() {
                      //     validJikanKara = false;
                      //   });
                      // }
                      if (int.parse(jikanKaraCreateAnkenPage.split(":")[0]) >=
                          int.parse(jikanMadeCreateAnkenPage.split(":")[0])) {
                        setState(() {
                          validJikanKara = false;
                          validJikanMade = false;
                        });
                        CustomToast.show(context, message: "開始時間＜終了時間として下さい。");
                      } else {
                        setState(() {
                          validJikanKara = true;
                          validJikanMade = true;
                        });
                      }
                      if (_formKey.currentState?.validate() == true &&
                          validJikanKara &&
                          validJikanMade) {
                        CreateAnken().createAnken(
                          YMD: widget.initialDate,
                          JYOKEN_CD: widget.TANT_CD, // user login id
                          JYOKEN_SYBET_FLG:
                              widget.isPhongBan ? '1' : '0', //????
                          TAG_KBN:
                              listPullDownCreateAnkenPage[selectedPullDownIndex]
                                      ["KBN_CD"] ??
                                  '', // ??
                          START_TIME: jikanKaraCreateAnkenPage + ":00",
                          END_TIME: jikanMadeCreateAnkenPage + ":00",
                          JININ: jinNumberCreateAnkenPage,
                          JIKAN: jikanNumberCreateAnkenPage,
                          GUEST_NAME: okyakuSamaCreateAnkenPage,
                          ATTEND_NAME1: sankasha1CreateAnkenPage,
                          ATTEND_NAME2: sankasha2CreateAnkenPage,
                          ATTEND_NAME3: sankasha3CreateAnkenPage,
                          ALL_DAY_FLG: checkAllDayCreateAnkenPage ? "1" : "0",
                          KBNMSAI_CD:
                              listPullDownCreateAnkenPage[selectedPullDownIndex]
                                      ["KBNMSAI_CD"] ??
                                  '',
                          KBN_CD:
                              listPullDownCreateAnkenPage[selectedPullDownIndex]
                                      ["KBN_CD"] ??
                                  '',
                          onSuccess: () {
                            Navigator.pop(context);
                            CustomToast.show(context,
                                message: "営業案件を登録できました。",
                                backGround: Colors.green);
                            widget.onCreateAnkenSuccessfull.call();
                          },
                          onFailed: () {
                            CustomToast.show(context,
                                message: "営業案件を登録出来ませんでした。",
                                backGround: Colors.red);
                            widget.onCreateAnkenSuccessfull.call();
                          },
                        );
                      }
                    },
                    child: const Text(
                      '更新',
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
                    color: const Color(0xFFA0A0A0),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'キャンセル',
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
              height: 10,
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
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listPullDownCreateAnkenPage.map((item) {
        int index = listPullDownCreateAnkenPage.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            setState(() {
              currentPullDownValue =
                  listPullDownCreateAnkenPage[index]["KBNMSAI_NAME"];
              selectedPullDownIndex = index;
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
                      item["KBNMSAI_NAME"].toString(),
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
              currentPullDownValue,
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
      enabled: !checkAllDayCreateAnkenPage,
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listDateTime1.map((item) {
        int index = listDateTime1.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            setState(() {
              jikanKaraCreateAnkenPage = listDateTime1[index];
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
                      item.toString(),
                      style: const TextStyle(color: Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        );
      }).toList(),
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
              jikanKaraCreateAnkenPage,
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
      enabled: !checkAllDayCreateAnkenPage,
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listDateTime2.map((item) {
        int index = listDateTime2.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            setState(() {
              jikanMadeCreateAnkenPage = listDateTime2[index];
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
                      item.toString(),
                      style: const TextStyle(color: Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        );
      }).toList(),
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
              jikanMadeCreateAnkenPage,
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

  String? _validateNumber(String? input) {
    if (input == '' || input == null) {
      return '未入力';
    } else {
      if (Validator.onlyNumber(input)) {
        return null;
      } else {
        return '整数のみ';
      }
    }
  }

  String? _validateNumber2(String? input) {
    if (input == '' || input == null) {
      return '未入力';
    } else {
      if (Validator.onlyDouble(input)) {
        return null;
      } else {
        return '整数のみ';
      }
    }
  }
}
