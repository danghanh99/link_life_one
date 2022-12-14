import 'package:check_points/check_point.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/sukejuuru_page_api/eigyo_anken/create_eigyo_anken_api/create_eigyo_anken.dart';
import 'package:link_life_one/api/sukejuuru_page_api/eigyo_anken/delete_eigyo_anken.dart';
import 'package:link_life_one/api/sukejuuru_page_api/eigyo_anken/update_anken_middle/update_anken_middle.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page7/page_7_2_4_create_memo/create/page_7_2_4_create.dart';

import '../../../api/sukejuuru_page_api/eigyo_anken/details_vs_pull_down_eigyo_anken/get_sales_construction_sales_preview_contents.dart';
import '../../../api/sukejuuru_page_api/eigyo_anken/show_eigyo_anken/get_anken_detail.dart';
import '../../../components/custom_text_field.dart';
import '../../../shared/assets.dart';
import '../../../shared/validator.dart';
import '../../page6/saibuhachuulist_danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

class Page723EditShowAnken extends StatefulWidget {
  final DateTime initialDate;
  final String TANT_CD;
  final bool isPhongBan;
  final String TAN_EIG_ID;
  final Function onUpdateAnkenSuccessfull;
  final String KBNMSAI_NAME;
  const Page723EditShowAnken({
    required this.initialDate,
    required this.TANT_CD,
    required this.isPhongBan,
    required this.onUpdateAnkenSuccessfull,
    required this.TAN_EIG_ID,
    required this.KBNMSAI_NAME,
    Key? key,
  }) : super(key: key);

  @override
  State<Page723EditShowAnken> createState() => _Page723EditShowAnkenState();
}

class _Page723EditShowAnkenState extends State<Page723EditShowAnken> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController textEditingControllerJikan = TextEditingController();
  TextEditingController textEditingControllerNin = TextEditingController();

  TextEditingController textEditingControllerKhachHang =
      TextEditingController();
  TextEditingController textEditingControllerNguoiThamGia1 =
      TextEditingController();
  TextEditingController textEditingControllerNguoiThamGia2 =
      TextEditingController();
  TextEditingController textEditingControllerNguoiThamGia3 =
      TextEditingController();

  bool validKaraMade = true;

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

  String TAG_KBN = '';

  String currentPullDownValue = '';

  DateTime? time;

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
  @override
  void initState() {
    widget.TAN_EIG_ID;
    checkAllDayCreateAnkenPage = false;
    jikanKaraCreateAnkenPage = listDateTime1[listDateTime1.length - 1];
    jikanMadeCreateAnkenPage = listDateTime2[listDateTime1.length - 1];
    callGetAnkenDetail();
    super.initState();
  }

  Future<dynamic> callGetAnkenDetail({Function? onsuccess}) async {
    final dynamic result = GetAnkenDetail().getAnkenDetail(
      onSuccess: (response) {
        setState(() {
          listPullDownCreateAnkenPage = response["PULLDOWN"];
          for (var element in listPullDownCreateAnkenPage) {
            if (element["KBNMSAI_NAME"] == widget.KBNMSAI_NAME) {
              selectedPullDownIndex =
                  listPullDownCreateAnkenPage.indexOf(element);
              currentPullDownValue = element["KBNMSAI_NAME"];
            }
          }

          TAG_KBN = response["EIGYO_ANKEN"][0]["TAG_KBN"];
          time =
              DateFormat("yyyy-MM-dd").parse(response["EIGYO_ANKEN"][0]["YMD"]);
          datetimeCreateAnkenPage =
              DateFormat("yyyy-MM-dd").parse(response["EIGYO_ANKEN"][0]["YMD"]);
          jikanKaraCreateAnkenPage = response["EIGYO_ANKEN"][0]["START_TIME"]
                  .toString()
                  .split(":")[0] +
              ":" +
              response["EIGYO_ANKEN"][0]["START_TIME"].toString().split(":")[1];
          jikanMadeCreateAnkenPage = response["EIGYO_ANKEN"][0]["END_TIME"]
                  .toString()
                  .split(":")[0] +
              ":" +
              response["EIGYO_ANKEN"][0]["END_TIME"].toString().split(":")[1];
          jinNumberCreateAnkenPage = response["EIGYO_ANKEN"][0]["JININ"];
          textEditingControllerNin.text =
              int.parse(response["EIGYO_ANKEN"][0]["JININ"]).toString();
          jikanNumberCreateAnkenPage = response["EIGYO_ANKEN"][0]["JIKAN"];

////////////////////////////////////////////////////////////
          ///
          String xxxx = response["EIGYO_ANKEN"][0]["JIKAN"];
          int phannguyen = int.parse(xxxx.split(".")[0]);
          int phanthapphan = int.parse(xxxx.split(".")[1]) >= 5 ? 1 : 0;
          int tong = phannguyen + phanthapphan;

          textEditingControllerJikan.text = tong.toString();
////////////////////////////////////////////////////
          okyakuSamaCreateAnkenPage = response["EIGYO_ANKEN"][0]["GUEST_NAME"];
          sankasha1CreateAnkenPage = response["EIGYO_ANKEN"][0]["ATTEND_NAME1"];
          sankasha2CreateAnkenPage = response["EIGYO_ANKEN"][0]["ATTEND_NAME2"];
          sankasha3CreateAnkenPage = response["EIGYO_ANKEN"][0]["ATTEND_NAME3"];
          textEditingControllerKhachHang.text =
              response["EIGYO_ANKEN"][0]["GUEST_NAME"];
          textEditingControllerNguoiThamGia1.text =
              response["EIGYO_ANKEN"][0]["ATTEND_NAME1"];
          textEditingControllerNguoiThamGia2.text =
              response["EIGYO_ANKEN"][0]["ATTEND_NAME2"];
          textEditingControllerNguoiThamGia3.text =
              response["EIGYO_ANKEN"][0]["ATTEND_NAME3"];

          checkAllDayCreateAnkenPage =
              response["EIGYO_ANKEN"][0]["ALL_DAY_FLG"] == 1 ? true : false;
        });
      },
      TAN_EIG_ID: widget.TAN_EIG_ID,
    );

    return result;
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
                          time == null
                              ? ''
                              : DateFormat('yyyy年MM月dd日(E)', 'ja')
                                  .format(time!)
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                            "Invalid",
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
                                    value: checkAllDayCreateAnkenPage,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkAllDayCreateAnkenPage = newValue ??
                                            checkAllDayCreateAnkenPage;
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
                                        "Invalid",
                                        style: TextStyle(color: Colors.red),
                                      ),
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
                              controller: textEditingControllerNin,
                              validator: _validateNumber,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: jinNumberCreateAnkenPage.toString(),
                              type: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  textEditingControllerNin.text = text;
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
                              controller: textEditingControllerJikan,
                              validator: _validateNumber2,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: jikanNumberCreateAnkenPage.toString(),
                              type: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  textEditingControllerJikan.text = text;
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
                          controller: textEditingControllerKhachHang,
                          fillColor: const Color(0xFFF5F6F8),
                          hint: '',
                          type: TextInputType.emailAddress,
                          onChanged: (text) {
                            setState(() {
                              okyakuSamaCreateAnkenPage = text;

                              textEditingControllerKhachHang.text = text;
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
                              controller: textEditingControllerNguoiThamGia1,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  sankasha1CreateAnkenPage = text;

                                  textEditingControllerNguoiThamGia1.text =
                                      text;
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
                              controller: textEditingControllerNguoiThamGia2,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  sankasha2CreateAnkenPage = text;
                                  textEditingControllerNguoiThamGia2.text =
                                      text;
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
                              controller: textEditingControllerNguoiThamGia3,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  sankasha3CreateAnkenPage = text;
                                  textEditingControllerNguoiThamGia3.text =
                                      text;
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
                      if (jikanKaraCreateAnkenPage == null ||
                          jikanMadeCreateAnkenPage == null) {
                        setState(() {
                          validKaraMade = false;
                        });
                      }
                      if (int.parse(jikanKaraCreateAnkenPage.split(":")[0]) >=
                          int.parse(jikanMadeCreateAnkenPage.split(":")[0])) {
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
                        UpdateAnkenMiddle().updateAnkenMiddle(
                          YMD: DateFormat(('yyyy-MM-dd'))
                              .format(widget.initialDate),
                          JYOKEN_CD: widget.TANT_CD,
                          JYOKEN_SYBET_FLG: widget.isPhongBan ? '1' : '0',
                          TAG_KBN: TAG_KBN,
                          START_TIME: jikanKaraCreateAnkenPage + ":00",
                          END_TIME: jikanMadeCreateAnkenPage + ":00",
                          JININ: jinNumberCreateAnkenPage,
                          JIKAN: jikanNumberCreateAnkenPage,
                          GUEST_NAME: okyakuSamaCreateAnkenPage,
                          ATTEND_NAME1: sankasha1CreateAnkenPage,
                          ATTEND_NAME2: sankasha2CreateAnkenPage,
                          ATTEND_NAME3: sankasha3CreateAnkenPage,
                          ALL_DAY_FLG: checkAllDayCreateAnkenPage ? "1" : "0",
                          TAN_EIG_ID: widget.TAN_EIG_ID,
                          KBNMSAI_CD:
                              listPullDownCreateAnkenPage[selectedPullDownIndex]
                                  ["KBNMSAI_CD"],
                          KBN_CD:
                              listPullDownCreateAnkenPage[selectedPullDownIndex]
                                  ["KBN_CD"],
                          onSuccess: () {
                            Navigator.pop(context);
                            CustomToast.show(context,
                                message: "営業案件を変更できました。",
                                backGround: Colors.green);
                            widget.onUpdateAnkenSuccessfull.call();
                          },
                          onFailed: () {
                            CustomToast.show(context,
                                message: "営業案件を変更出来ませんでした。",
                                backGround: Colors.green);
                            widget.onUpdateAnkenSuccessfull.call();
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
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      DeleteEigyoAnken().deleteEigyoAnken(
                          onSuccess: () {
                            Navigator.pop(context);
                            widget.onUpdateAnkenSuccessfull.call();
                            CustomToast.show(context,
                                message: "削除出来ました。", backGround: Colors.green);
                          },
                          onFailed: () {
                            CustomToast.show(context, message: "削除出来ませんでした。");
                          },
                          TAN_EIG_ID: widget.TAN_EIG_ID);
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
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return 'Only number';
    }
  }

  String? _validateNumber2(String? input) {
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return 'Only number';
    }
  }
}
