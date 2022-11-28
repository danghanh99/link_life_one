import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/screen/page7/page_7_2_2_edit_item/page_7_2_2.dart';

import '../../../api/sukejuuru_page_api/show_anken/get_anken.dart';
import '../../../components/custom_text_field.dart';
import '../../../shared/assets.dart';
import '../../page6/danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

class Page721 extends StatefulWidget {
  final String JYUCYU_ID;
  final String KBNMSAI_NAME;
  final Function onSuccessUpdate;
  const Page721({
    Key? key,
    required this.JYUCYU_ID,
    required this.KBNMSAI_NAME,
    required this.onSuccessUpdate,
  }) : super(key: key);

  @override
  State<Page721> createState() => _Page721State();
}

class _Page721State extends State<Page721> {
  late bool showUpdatePage;

  late bool checkedValue;
  late bool checkedValueAllDay;
  String titleDateTime1 = '';
  String titleDateTime2 = '';
  String titleDateTime3 = '';
  String jinninNumber = '';
  String jikanNumber = '';
  String comment = '';
  String jikanKara = '';
  String jikanMade = '';
  DateTime datetime = DateTime.now();

  String KBNMSAI_NAME = '';

  Future? getLichTrinhDetail;

  dynamic responseShitami;
  dynamic responseKoji;
  List<dynamic> listPulldown = [];

  String TAG_KBN = '';

  String SITAMIHOMONJIKAN = '';
  String SITAMIHOMONJIKAN_END = '';
  String SITAMI_JININ = '';
  String SITAMI_JIKAN = '';
  String SITAMIAPO_KBN = '';
  String SITAMI_KANSAN_POINT = '';

  String UPD_TANTNM = '';
  String UPD_YMD = '';
  String JYUCYU_ID = '';
  String MEMO = '';
  String COMMENT = '';

  String KOJIHOMONJIKAN = '';
  String KOJIHOMONJIKAN_END = '';
  String KOJI_JININ = '';
  String KOJI_JIKAN = '';
  String KOJIAPO_KBN = '';
  String KOJI_KANSAN_POINT = '';

  @override
  void initState() {
    showUpdatePage = false;

    checkedValue = false;
    checkedValueAllDay = false;
    KBNMSAI_NAME = widget.KBNMSAI_NAME;

    getLichTrinhDetail = callGetAnken(JYUCYU_ID: widget.JYUCYU_ID);

    super.initState();
  }

  bool isShitami(String type) {
    if (type.contains("下見")) return true;
    return false;
  }

  Future<dynamic> callGetAnken(
      {required String JYUCYU_ID, Function? onsuccess}) async {
    final dynamic result = await GetAnken().getAnken(
        JYUCYU_ID: JYUCYU_ID,
        onSuccess: (response) {
          setState(() {
            responseShitami = response["SITAMI"][0];
            responseKoji = response["KOJI"][0];
            listPulldown = response["PULLDOWN"];

            if (isShitami(KBNMSAI_NAME)) {
              if (responseShitami["SITAMIHOMONJIKAN"].split(" ").length >= 2) {
                jikanKara = responseShitami["SITAMIHOMONJIKAN"].split(" ")[1];
              }
              if (responseShitami["SITAMIHOMONJIKAN_END"].split(" ").length >=
                  2) {
                jikanMade =
                    responseShitami["SITAMIHOMONJIKAN_END"].split(" ")[1];
              }

              checkedValue = responseShitami["SITAMIAPO_KBN"] == "1"
                  ? true
                  : false; // checkbox appoint
              checkedValueAllDay = responseShitami["SITAMI_KANSAN_POINT"] == "1"
                  ? true
                  : false; // checkbox all day
              titleDateTime1 = responseShitami["UPD_TANTNM"] +
                  " " +
                  responseShitami["SITAMIHOMONJIKAN"]; // title + datetime
              titleDateTime2 = responseShitami["UPD_TANTNM"] +
                  " " +
                  responseShitami["SITAMIHOMONJIKAN_END"]; // title + datetime
              jinninNumber =
                  responseShitami["SITAMI_JININ"] ?? ''; //jinninNumber
              jikanNumber = responseShitami["SITAMI_JIKAN"] ?? ''; //jikanNumber
              comment = responseShitami["COMMENT"] ?? ''; //comment
              datetime = convertDateTime(responseShitami["UPD_YMD"]); //datetime
              titleDateTime3 = DateFormat('yyyy年MM月dd日(E)', 'ja')
                      .format(datetime)
                      .toString() +
                  "   " +
                  jikanKara +
                  "  〜  " +
                  jikanMade;

              TAG_KBN = responseShitami["TAG_KBN"];

              SITAMIHOMONJIKAN = responseShitami["SITAMIHOMONJIKAN"];
              SITAMIHOMONJIKAN_END = responseShitami["SITAMIHOMONJIKAN_END"];
              SITAMI_JININ = responseShitami["SITAMI_JININ"] ?? '';
              SITAMI_JIKAN = responseShitami["SITAMI_JIKAN"] ?? '';
              SITAMIAPO_KBN = responseShitami["SITAMIAPO_KBN"] ?? '';
              SITAMI_KANSAN_POINT =
                  responseShitami["SITAMI_KANSAN_POINT"].toString() ?? '';

              UPD_TANTNM = responseShitami["UPD_TANTNM"] ?? '';
              UPD_YMD = responseShitami["UPD_YMD"] ?? '';
              JYUCYU_ID = responseShitami["JYUCYU_ID"] ?? '';
              MEMO = responseShitami["MEMO"] ?? '';
              COMMENT = responseShitami["COMMENT"] ?? '';
            } else {
              if (responseShitami["KOJIHOMONJIKAN"].split(" ").length >= 2) {
                jikanKara = responseShitami["KOJIHOMONJIKAN"].split(" ")[1];
              }
              if (responseShitami["KOJIHOMONJIKAN_END"].split(" ").length >=
                  2) {
                jikanMade = responseShitami["KOJIHOMONJIKAN_END"].split(" ")[1];
              }
              checkedValue = responseKoji["KOJIAPO_KBN"] == "1"
                  ? true
                  : false; // checkbox appoint
              checkedValueAllDay = responseKoji["KOJI_KANSAN_POINT"] == "1"
                  ? true
                  : false; // checkbox all day
              titleDateTime1 = responseKoji["UPD_TANTNM"] +
                  " " +
                  responseKoji["KOJIHOMONJIKAN"]; // title + datetime
              titleDateTime2 = responseKoji["UPD_TANTNM"] +
                  " " +
                  responseKoji["KOJIHOMONJIKAN_END"]; // title + datetime

              jinninNumber = responseKoji["KOJI_JININ"]; //jinninNumber
              jikanNumber = responseKoji["KOJI_JIKAN"]; //jikanNumber
              comment = responseKoji["COMMENT"]; //comment
              datetime = convertDateTime(responseKoji["UPD_YMD"]); //datetime
              titleDateTime3 = DateFormat('yyyy年MM月dd日(E)', 'ja')
                      .format(datetime)
                      .toString() +
                  "   " +
                  jikanKara +
                  "  〜  " +
                  jikanMade;

              TAG_KBN = responseKoji["TAG_KBN"];

              KOJIHOMONJIKAN = responseKoji["KOJIHOMONJIKAN"];
              KOJIHOMONJIKAN_END = responseKoji["KOJIHOMONJIKAN_END"];
              KOJI_JININ = responseKoji["KOJI_JININ"];
              KOJI_JIKAN = responseKoji["KOJI_JIKAN"];
              KOJIAPO_KBN = responseKoji["KOJIAPO_KBN"];
              KOJI_KANSAN_POINT = responseKoji["KOJI_KANSAN_POINT"].toString();

              UPD_TANTNM = responseKoji["UPD_TANTNM"];
              UPD_YMD = responseKoji["UPD_YMD"];
              JYUCYU_ID = responseKoji["JYUCYU_ID"];
              MEMO = responseKoji["MEMO"];
              COMMENT = responseKoji["COMMENT"];
            }
          });
        });

    return result;
  }

  DateTime convertDateTime(String date) {
    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return showUpdatePage
        ? Page722(
            onSuccessUpdate: () {
              widget.onSuccessUpdate.call();
            },
            JYUCYU_ID: widget.JYUCYU_ID,
            KBNMSAI_NAME: widget.KBNMSAI_NAME,
            title: titleDateTime2,
            listPullDown: listPulldown,
            checkAppoint: checkedValue,
            datetime: datetime,
            jikanKara: jikanKara,
            jikanMade: jikanMade,
            checkAllDay: checkedValueAllDay,
            jinNumber: jinninNumber == '' ? 0 : int.parse(jinninNumber),
            jikanNumber: jikanNumber == '' ? 0 : int.parse(jikanNumber),
            comment: comment,
          )
        : Column(
            children: [
              Container(
                height: 50,
                color: const Color.fromARGB(255, 96, 186, 234),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ネット工事(アポ済み)",
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
                height: 70,
                // width: size.width,
                color: Color.fromARGB(255, 175, 215, 237),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '登録情報: ${titleDateTime1}',
                          style: const TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '更新情報：${titleDateTime2}',
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
                            titleDateTime3,
                            style: const TextStyle(
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
                                  showUpdatePage = !showUpdatePage;
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
                            KBNMSAI_NAME,
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
                                  showUpdatePage = !showUpdatePage;
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
                                    jinninNumber,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '人',
                                    style: TextStyle(
                                      color: Color(0xFF042C5C),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('/'),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    jikanNumber,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('時間')
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
                                  showUpdatePage = !showUpdatePage;
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
                            MEMO,
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
                                  showUpdatePage = !showUpdatePage;
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
                            COMMENT,
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
