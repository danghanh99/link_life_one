import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../api/sukejuuru_page_api/netto_koji/show_anken/get_lich_trinh_item_edit_page.dart';
import '../../../../api/sukejuuru_page_api/netto_koji/update_anken/update_lich_trinh.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../components/toast.dart';
import '../../../../shared/assets.dart';
import '../../../../shared/validator.dart';

class Page722 extends StatefulWidget {
  final String JYUCYU_ID;
  final String HOMON_SBT;
  final String KBNMSAI_NAME;

  final Function onSuccessUpdate;
  const Page722({
    required this.JYUCYU_ID,
    required this.HOMON_SBT,
    required this.KBNMSAI_NAME,
    required this.onSuccessUpdate,
    Key? key,
  }) : super(key: key);

  @override
  State<Page722> createState() => _Page722State();
}

class _Page722State extends State<Page722> {
  List<dynamic> listDateTime1 = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "00:00",
  ];
  List<dynamic> listDateTime2 = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "00:00",
  ];
  final GlobalKey<FormState> _formKey = GlobalKey();

  late String titleEditPage;
  late List<dynamic> listPullDownEditPage;
  late bool checkAppointEditPage;
  late DateTime datetimeEditPage;
  late String jikanKaraEditPage;
  late String jikanMadeEditPage;
  late bool checkAllDayEditPage;
  late String jinNumberEditPage;
  late String jikanNumberEditPage;
  late String commentEditPage;
  int selectedPullDownIndex = 0;

  late String KBNMSAI_NAME;

  bool validKaraMade = true;

  String TAG_KBN = '';
  String HOMONJIKAN = '00:00';
  String HOMONJIKAN_END = '00:00';
  String JININ = '';
  String JIKAN = '';
  String KOJIAPO_KBN = '';
  String UPD_TANTNM = '';
  String UPD_YMD = '';
  String KOJI_KANSAN_POINT = '';
  String JYUCYU_ID = '';
  String HOMON_SBT = '';
  String COMMENT = '';
  String MEMO = '';
  String ALL_DAY_FLG = '';

  @override
  void initState() {
    KBNMSAI_NAME = widget.KBNMSAI_NAME;

    titleEditPage = UPD_TANTNM + "  " + UPD_YMD;
    listPullDownEditPage = [];
    checkAppointEditPage = false;
    datetimeEditPage = DateTime.now();
    jikanKaraEditPage = "00:00";
    jikanMadeEditPage = "00:00";
    checkAllDayEditPage = false;
    jinNumberEditPage = "0";
    jikanNumberEditPage = "0";
    commentEditPage = "";

    callGetLichTrinhItemEditPage();
    super.initState();
  }

  Future<dynamic> callGetLichTrinhItemEditPage() async {
    final dynamic result =
        await GetLichTrinhItemEditPage().getLichTrinhItemEditPage(
            JYUCYU_ID: widget.JYUCYU_ID,
            HOMON_SBT: widget.HOMON_SBT,
            onSuccess: (data) {
              if (data["PULLDOWN"] != null) {
                setState(() {
                  listPullDownEditPage = data["PULLDOWN"];
                });
              }
              if (data["DATA"] != null) {
                setState(() {
                  if (data["DATA"][0]["TAG_KBN"] != null)
                    TAG_KBN = data["DATA"][0]["TAG_KBN"];

                  if (data["DATA"][0]["HOMONJIKAN"] != null) {
                    if (data["DATA"][0]["HOMONJIKAN"]
                            .toString()
                            .split(" ")
                            .length >=
                        2) {
                      HOMONJIKAN = data["DATA"][0]["HOMONJIKAN"];
                      final String tmp1 = HOMONJIKAN.split(" ")[1];
                      jikanKaraEditPage = tmp1.split(":")[0] + ":00";
                    }
                  }
                  if (data["DATA"][0]["HOMONJIKAN_END"] != null) {
                    if (data["DATA"][0]["HOMONJIKAN_END"]
                            .toString()
                            .split(" ")
                            .length >=
                        2) {
                      HOMONJIKAN_END = data["DATA"][0]["HOMONJIKAN_END"];
                      final String tmp2 = HOMONJIKAN_END.split(" ")[1];
                      jikanMadeEditPage = tmp2.split(":")[0] + ":00";
                    }
                  }

                  if (data["DATA"][0]["JININ"] != null)
                    JININ = data["DATA"][0]["JININ"];
                  if (data["DATA"][0]["JIKAN"] != null)
                    JIKAN = data["DATA"][0]["JIKAN"];
                  if (data["DATA"][0]["KOJIAPO_KBN"] != null)
                    KOJIAPO_KBN = data["DATA"][0]["KOJIAPO_KBN"];
                  if (data["DATA"][0]["UPD_TANTNM"] != null)
                    UPD_TANTNM = data["DATA"][0]["UPD_TANTNM"];

                  if (data["DATA"][0]["UPD_YMD"] != null)
                    UPD_YMD = data["DATA"][0]["UPD_YMD"];

                  if (data["DATA"][0]["KOJI_KANSAN_POINT"] != null)
                    KOJI_KANSAN_POINT =
                        data["DATA"][0]["KOJI_KANSAN_POINT"].toString();

                  if (data["DATA"][0]["JYUCYU_ID"] != null)
                    JYUCYU_ID = data["DATA"][0]["JYUCYU_ID"];
                  if (data["DATA"][0]["HOMON_SBT"] != null)
                    HOMON_SBT = data["DATA"][0]["HOMON_SBT"];

                  if (data["DATA"][0]["COMMENT"] != null)
                    COMMENT = data["DATA"][0]["COMMENT"];
                  if (data["DATA"][0]["MEMO"] != null)
                    MEMO = data["DATA"][0]["MEMO"];

                  if (data["DATA"][0]["ALL_DAY_FLG"] != null)
                    ALL_DAY_FLG = data["DATA"][0]["ALL_DAY_FLG"];

                  titleEditPage = UPD_TANTNM + "  " + UPD_YMD;
                  checkAppointEditPage = KOJIAPO_KBN == "01" ? true : false;
                  checkAllDayEditPage = ALL_DAY_FLG == "1" ? true : false;
                  jinNumberEditPage = JININ;
                  jikanNumberEditPage = JIKAN;
                  commentEditPage = COMMENT;
                  datetimeEditPage = DateFormat("yyyy-MM-dd")
                      .parse(data["DATA"][0]["KOJI_YMD"]);
                });
              }
            });

    return result;
  }

  DateTime convertDateTime(String date) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: 650,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 50,
              color: const Color(0xFF6F86D6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Align(
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
                  ],
                ),
              ),
            ),
            Container(
              height: 40,
              color: const Color(0xFF91B1F9),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '更新情報： ${titleEditPage}',
                        style: const TextStyle(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      // const Spacer(),
                      const SizedBox(
                        width: 160,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                            value: checkAppointEditPage,
                            onChanged: (newValue) {
                              setState(() {
                                checkAppointEditPage = newValue ?? true;
                              });
                            },
                          ),
                          const Text(
                            'アポイント済み',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Align(
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
                              .format(datetimeEditPage)
                              .toString(),
                          style: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              _moreButton2(context),
                              validKaraMade
                                  ? Container()
                                  : const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "未選択",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                value: checkAllDayEditPage,
                                onChanged: (newValue) {
                                  if (newValue == true) {
                                    setState(() {
                                      checkAllDayEditPage = true;

                                      jikanKaraEditPage = "08:00";
                                      jikanMadeEditPage = "19:00";
                                    });
                                  } else {
                                    setState(() {
                                      checkAllDayEditPage =
                                          newValue ?? checkAllDayEditPage;
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
                      Column(
                        children: [
                          _moreButton3(context),
                          validKaraMade
                              ? Container()
                              : const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "未選択",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                        ],
                      ),
                    ],
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
                              initValue: jinNumberEditPage.toString(),
                              validator: _validateNumber,
                              fillColor: const Color(0xFFF5F6F8),
                              // hint: jinNumberEditPage.toString(),
                              type: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  jinNumberEditPage = text;
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
                              initValue: jikanNumberEditPage.toString(),
                              validator: _validateNumber2,
                              fillColor: const Color(0xFFF5F6F8),
                              // hint: jikanNumberEditPage.toString(),
                              type: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  jikanNumberEditPage = text;
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
                    height: 10,
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
                    fillColor: const Color(0xFFF5F6F8),
                    hint: commentEditPage,
                    type: TextInputType.emailAddress,
                    onChanged: (text) {
                      setState(() {
                        commentEditPage = text;
                      });
                    },
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
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
                      if (jikanKaraEditPage == null ||
                          jikanMadeEditPage == null) {
                        setState(() {
                          validKaraMade = false;
                        });
                      }
                      if (int.parse(jikanKaraEditPage.split(":")[0]) >=
                          int.parse(jikanMadeEditPage.split(":")[0])) {
                        setState(() {
                          validKaraMade = false;
                        });
                      } else {
                        setState(() {
                          validKaraMade = true;
                        });
                      }
                      if (_formKey.currentState?.validate() == true &&
                          validKaraMade) {
                        UpdateLichTrinh().updateLichTrinh(
                            onFailed: () {
                              CustomToast.show(context, message: "変更出来ませんでした。");
                            },
                            KBN_CD: listPullDownEditPage[selectedPullDownIndex]
                                ["KBN_CD"],
                            KBNMSAI_CD:
                                listPullDownEditPage[selectedPullDownIndex]
                                    ["KBNMSAI_CD"],
                            HOMON_SBT: widget.HOMON_SBT,
                            JYUCYU_ID: widget.JYUCYU_ID,
                            TAG_KBN: '0' + selectedPullDownIndex.toString(),
                            KBN: checkAppointEditPage ? "1" : "0",
                            JIKAN_START: DateFormat(('yyyy-MM-dd'))
                                    .format(datetimeEditPage)
                                    .toString() +
                                " " +
                                jikanKaraEditPage +
                                ":00",
                            JIKAN_END: DateFormat(('yyyy-MM-dd'))
                                    .format(datetimeEditPage)
                                    .toString() +
                                " " +
                                jikanMadeEditPage +
                                ":00",
                            JININ: jinNumberEditPage,
                            JIKAN: jikanNumberEditPage,
                            KANSAN_POINT: '',
                            ALL_DAY_FLG: checkAllDayEditPage ? "1" : "0",
                            MEMO: commentEditPage,
                            onSuccess: () {
                              Navigator.pop(context);
                              CustomToast.show(context,
                                  message: "変更出来ました。",
                                  backGround: Colors.green);
                              widget.onSuccessUpdate.call();
                            });
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
      itemBuilder: (context) => listPullDownEditPage.map((item) {
        int index = listPullDownEditPage.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            setState(() {
              KBNMSAI_NAME = listPullDownEditPage[index]["KBNMSAI_NAME"];
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
              KBNMSAI_NAME,
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
      enabled: !checkAllDayEditPage,
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
              jikanKaraEditPage = listDateTime1[index];
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
              jikanKaraEditPage,
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
      enabled: !checkAllDayEditPage,
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
              jikanMadeEditPage = listDateTime2[index];
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
              jikanMadeEditPage,
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
    if (input == null || input == '') {
      return 'Required';
    }
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return '整数のみ';
    }
  }

  String? _validateNumber2(String? input) {
    if (input == null || input == '') {
      return 'Required';
    }
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return '整数のみ';
    }
  }
}
