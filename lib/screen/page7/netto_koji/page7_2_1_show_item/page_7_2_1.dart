import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/models/schedules.dart';
import 'package:link_life_one/screen/page7/netto_koji/page_7_2_2_edit_item/page_7_2_2.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../api/sukejuuru_page_api/netto_koji/show_anken/get_lich_trinh_item.dart';
import '../../../../components/toast.dart';
import '../../component/dialog.dart';

class Page721 extends StatefulWidget {
  final String JYUCYU_ID;
  // final String KBNMSAI_NAME;
  final String HOMON_SBT;

  final Function onSuccessUpdate;
  const Page721({
    Key? key,
    required this.JYUCYU_ID,
    // required this.KBNMSAI_NAME,
    required this.HOMON_SBT,
    required this.onSuccessUpdate,
  }) : super(key: key);

  @override
  State<Page721> createState() => _Page721State();
}

class _Page721State extends State<Page721> {
  late bool showUpdatePage;

  // late bool checkedValue;
  // late bool checkedValueAllDay;
  String titleDateTimeADD_YMD = '';
  String titleDateTimeUPD_YMD = '';
  String titleDateTime3 = '';
  // String jinninNumber = '';
  // String jikanNumber = '';
  // String comment = '';
  String jikanKara = '';
  String jikanMade = '';
  String datetime = '';
  // DateTime datetime = DateTime.now();

  // String KBNMSAI_NAME = '';

  Future? getLichTrinhDetail;

  // dynamic responseShitami;
  // dynamic responseKoji;
  // List<dynamic> listPulldown = [];

  String JININ = '';
  String JIKAN = '';
  String HOMONJIKAN = '00:00';
  String HOMONJIKAN_END = '00:00';
  String SETSAKI_ADDRESS = '';
  String KOJI_ITEM = '';
  String SETSAKI_NAME = '';
  String HOMON_TANT_NAME1 = '';
  String HOMON_TANT_NAME2 = '';
  String HOMON_TANT_NAME3 = '';
  String HOMON_TANT_NAME4 = '';
  String ADD_TANTNM = '';
  String ADD_YMD = '';
  String UPD_TANTNM = '';
  String UPD_YMD = '';
  String fileName = '';
  String filePath = '';
  String MEMO = '';
  String HOMON_SBT = '';
  String KBNMSAI_NAME = '';
  String COMMENT = '';
  List<dynamic> FILEPATH = [];
  String tantName = '';

  ScheduleItem? schedule;

  DateTime? time;

  @override
  void initState() {
    showUpdatePage = false;

    // checkedValue = false;
    // checkedValueAllDay = false;
    // KBNMSAI_NAME = widget.KBNMSAI_NAME;

    getLichTrinhDetail = callGetLichTrinhItem();

    super.initState();
  }

  bool isShitami(String type) {
    if (type.contains("下見")) return true;
    return false;
  }

  Future<dynamic> callGetLichTrinhItem() async {
    final dynamic result = await GetLichTrinhItem().getLichTrinhItem(
        JYUCYU_ID: widget.JYUCYU_ID,
        HOMON_SBT: widget.HOMON_SBT,
        onSuccess: (data) {
          if (data is List && data.isNotEmpty) {
            ScheduleItem schedule = ScheduleItem.fromJson(data.first);
            this.schedule = schedule;
            bool isShitami = widget.HOMON_SBT == '01';
            setState(() {
              String YMD_api =
                  isShitami ? schedule.ymd ?? '' : schedule.kojiYmd ?? '';
              time = DateFormat("yyyy-MM-dd").parse(YMD_api);
              JININ =
                  isShitami ? schedule.jinin ?? '' : schedule.kojiJinin ?? '';
              JIKAN =
                  isShitami ? schedule.jikan ?? '' : schedule.kojiJikan ?? '';
              jikanKara = schedule.homonjikan ?? '';
              jikanMade = schedule.homonjikanEnd ?? '';
              SETSAKI_ADDRESS = schedule.setsakiAddress ?? '';
              KOJI_ITEM = schedule.kojiItem ?? '';
              SETSAKI_NAME = schedule.setsakiName ?? '';
              if (!isShitami) {
                tantName = schedule.tantName4 ?? '';
              } else {
                tantName = [
                  schedule.tantName1,
                  schedule.tantName2,
                  schedule.tantName3
                ].where((s) => s != null && s.isNotEmpty).join(', ');
              }

              ADD_TANTNM = schedule.addTantnm ?? '';
              ADD_YMD = schedule.addYmd ?? '';
              UPD_TANTNM = schedule.updTantnm ?? '';
              UPD_YMD = schedule.updYmd ?? '';
              fileName = isShitami
                  ? schedule.sitamiiraisyoFilepath?.split('/').last ?? ''
                  : schedule.kojiiraisyoFilepath?.split('/').last ?? '';
              filePath = isShitami
                  ? schedule.sitamiiraisyoFilepath ?? ''
                  : schedule.kojiiraisyoFilepath ?? '';
              MEMO = schedule.memo ?? '';
              HOMON_SBT = schedule.homonSbt ?? '';
              KBNMSAI_NAME = schedule.kbnmsaiName ?? '';
              COMMENT = schedule.comment ?? '';
              FILEPATH = schedule.filepath ?? [];

              titleDateTimeADD_YMD =
                  "$ADD_TANTNM   ${DateFormat('yyyy/MM/dd(日) hh:mm', 'ja').format(convertDateTime(ADD_YMD))}";
              titleDateTimeUPD_YMD =
                  "$UPD_TANTNM   ${DateFormat('yyyy/MM/dd(日) hh:mm', 'ja').format(convertDateTime(UPD_YMD))}";
              titleDateTime3 = time == null
                  ? ''
                  : "${DateFormat('yyyy年MM月dd日(E)', 'ja').format(time!)} $jikanKara 〜 $jikanMade";
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

    return showUpdatePage
        ? NettoKojiPage722(
            KBNMSAI_NAME: KBNMSAI_NAME,
            onSuccessUpdate: () {
              widget.onSuccessUpdate.call();
            },
            JYUCYU_ID: widget.JYUCYU_ID,
            HOMON_SBT: HOMON_SBT,
            jinin: JININ,
            jikan: JIKAN,
            memo: MEMO,
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
                          '登録情報: ${titleDateTimeADD_YMD}',
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
                          '更新情報：${titleDateTimeUPD_YMD}',
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
                                    JININ,
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
                                    JIKAN,
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            MEMO,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 120,
                            height: 37,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 237, 189, 116),
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
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                Size size = MediaQuery.of(context).size;
                                CustomDialog.showCustomDialog(
                                    context: context,
                                    title: '',
                                    body: Container(
                                      // width: size.width * 2 / 3,
                                      // height: size.height * 2 / 3,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(''),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 40,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      border: Border.all(
                                                          color: Colors.red)),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: size.width * 4 / 5,
                                            height: size.height * 4 / 5,
                                            child: SfPdfViewer.network(
                                              filePath,
                                              key: GlobalKey(),
                                              onDocumentLoaded: (details) {},
                                              onDocumentLoadFailed: (detail) {
                                                CustomToast.show(context,
                                                    message: "PDFを取得出来ませんでした。");
                                                // message: detail.description);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ));
                              },
                              child: Text(
                                fileName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ),
                          // const Spacer(),
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
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            tantName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const Spacer(),
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
