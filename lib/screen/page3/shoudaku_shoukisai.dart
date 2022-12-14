import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/shoudakusho.dart';
import 'package:link_life_one/shared/custom_button.dart';
import '../../api/shoudakusho/get_shoudakusho.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';

class ShoudakuShoukisai extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final String KOJI_ST;
  final String SINGLE_SUMMARIZE;

  const ShoudakuShoukisai({
    super.key,
    this.initialDate,
    required this.JYUCYU_ID,
    required this.SINGLE_SUMMARIZE,
    required this.KOJI_ST,
  });

  @override
  State<ShoudakuShoukisai> createState() => _ShoudakuShoukisaiState();
}

class _ShoudakuShoukisaiState extends State<ShoudakuShoukisai> {
  dynamic KOJI_DATA = {};
  List<dynamic> TABLE_DATA = [];
  @override
  void initState() {
    super.initState();
    callGetKojiHoukoku();
  }

  Future<dynamic> callGetKojiHoukoku() async {
    final dynamic result = await GetShoudakusho().getShoudakusho(
        JYUCYU_ID: widget.JYUCYU_ID,
        KOJI_ST: widget.KOJI_ST,
        onSuccess: (body) {
          print(body);
          if (body["KOJI_DATA"] != null) {
            setState(() {
              KOJI_DATA = body["KOJI_DATA"][0];
            });
          }

          if (body["TABLE_DATA"] != null) {
            setState(() {
              TABLE_DATA = body["TABLE_DATA"];
            });
          }
        },
        onFailed: () {
          CustomToast.show(context, message: "承諾書を取得出来ませんでした。");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 70,
                        child: TextLineDown(
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF042C5C),
                              fontWeight: FontWeight.w500),
                          text: '戻る',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 247, 240, 240))),
                        width: 200,
                        child: CustomButton(
                          color: Colors.white70,
                          onClick: () {},
                          name: '承諾書記載',
                          textStyle: const TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            '完了確認書　兼　追加請求明細書',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        title2(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '請求明細',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 400.h,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildRows(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '担当者情報',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        title3(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    children: const [
                                      Text(
                                        '備考欄',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Colors.black,
                                        thickness: 1.1,
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(''),
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              //                   <--- left side
                                              color: Colors.black,
                                              width: 1.2,
                                            ),
                                            right: BorderSide(
                                              //                   <--- left side
                                              color: Colors.black,
                                              width: 1.2,
                                            ),
                                            bottom: BorderSide(
                                              //                    <--- top side
                                              color: Colors.black,
                                              width: 1.2,
                                            ),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            '備考欄をリセット',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '株式会社ライフワン',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '〒OOO-OOOO',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '東京都OOXXOO',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget title2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildLastRowCells(6),
    );
  }

  List<Widget> _buildLastRowCells(int count) {
    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
                125.w,
              ]
            : [
                (size.width - 33) / 7,
                (size.width - 33) * 2 / 7 + -30,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
              ];

    return List.generate(count, (col) {
      String text = '';
      if (col == 0) {
        text = "受注ID";
      }
      if (col == 1) {
        text = KOJI_DATA["JYUCYU_ID"] ?? "";
      }
      if (col == 2) {
        text = "お客様名";
      }
      if (col == 3) {
        text = KOJI_DATA["SETSAKI_NAME"] ?? "";
      }
      if (col == 4) {
        text = "ご訪問日";
      }
      if (col == 5) {
        text = KOJI_DATA["KOJI_YMD"] ?? "";
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: colwidth[col],
        height: 40,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }

  List<Widget> _buildLastRowCells2(int? count) {
    count = 4;
    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                150.w,
                220.w,
                130.w,
                220.w,
              ]
            : [
                (size.width - 33) / 7,
                (size.width - 33) * 2 / 7 + -30,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
              ];

    return List.generate(count, (col) {
      String text = '';
      if (col == 0) {
        text = "担当営業所・担当店";
      }
      if (col == 1) {
        text = KOJI_DATA["KOJIGYOSYA_NAME"] ?? "";
      }
      if (col == 2) {
        text = "担当者名";
      }
      if (col == 3) {
        text = KOJI_DATA["HOMON_TANT_NAME1"] ?? "";
      }
      if (col == 4) {
        text = "ご訪問日";
      }
      if (col == 5) {
        text = KOJI_DATA["KOJI_YMD"] ?? "";
      }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: colwidth[col],
        height: 40,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }

  Widget title3() {
    // return Container(
    //   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Container(
    //         decoration: const BoxDecoration(
    //           border: Border(
    //             right: BorderSide(
    //               //                   <--- left side
    //               color: Colors.black,
    //               width: 1.2,
    //             ),
    //           ),
    //         ),
    //         child: const Padding(
    //           padding: EdgeInsets.only(left: 30, right: 30, top: 7, bottom: 7),
    //           child: Text(
    //             '担当営業所・担当店',
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         decoration: const BoxDecoration(
    //           border: Border(
    //             right: BorderSide(
    //               //                   <--- left side
    //               color: Colors.black,
    //               width: 1.2,
    //             ),
    //             left: BorderSide(
    //               //                   <--- left side
    //               color: Colors.black,
    //               width: 1.2,
    //             ),
    //           ),
    //         ),
    //         child: const Padding(
    //           padding: EdgeInsets.only(left: 30, right: 30, top: 7, bottom: 7),
    //           child: Text(
    //             '担当者名',
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         child: const Padding(
    //           padding: EdgeInsets.only(left: 30, right: 30, top: 7, bottom: 7),
    //           child: Text(
    //             '',
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildLastRowCells2(4),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(5, index),
      );
    });
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '内容',
      'コード',
      '数量',
      '単価（税込）',
      '小計（税込）',
    ];
    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                200,
                130,
                130,
                100,
                200,
              ]
            : [
                2 * (size.width - 33) / 6,
                (size.width - 33) / 6,
                (size.width - 33) / 6,
                (size.width - 33) / 6,
                (size.width - 33) / 6,
                (size.width - 33) / 6,
                (size.width - 33) / 6,
              ];

    return List.generate(count, (col) {
      if (row == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 30,
          child: Text(
            colNames[col],
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
        alignment: Alignment.center,
        width: colwidth[col],
        height: 30,
        child: contentTable(col: col, row: row),
      );
    });
  }

  Widget contentTable({required int col, required int row, String? initial}) {
    if (row <= TABLE_DATA.length) {
      List<String> list = [
        "TUIKA_SYOHIN_NAME",
        "TUIKA_JISYA_CD",
        "SURYO",
        "HANBAI_TANKA",
        "KINGAK",
      ];
      return Text(
        TABLE_DATA[row - 1][list[col]] ?? '',
        style: TextStyle(color: Colors.black),
      );
    }
    if (col == 1 || col == 2) {
      return TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(4),
        ],
        onChanged: (value) {
          // onChange.call(value);
        },
        initialValue: initial,
        minLines: 1,
        maxLines: 1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        cursorColor: Colors.black,
      );
    }
    return const Text(
      '',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
          onTap: () {
            // go to top
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoudakuSho(
                  DATA_TABLE: TABLE_DATA,
                  JYUCYU_ID: widget.JYUCYU_ID,
                  SINGLE_SUMMARIZE: widget.SINGLE_SUMMARIZE,
                  initialDate: widget.initialDate,
                ),
              ),
            );

            // go to bottom
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HoujinKanryousho(
            //       initialDate: widget.initialDate,
            //     ),
            //   ),
            // );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 150,
            child: const Center(
              child: Text(
                '次へ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textUnderline() {
    return const TextField(
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5, bottom: 5),
        isDense: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      cursorColor: Colors.black,
    );
  }

  Widget _dropDownButton(BuildContext context, String value) {
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
                "戶建て",
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
                "戶建て",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(5, 32),
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
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
      ),
    );
  }
}
