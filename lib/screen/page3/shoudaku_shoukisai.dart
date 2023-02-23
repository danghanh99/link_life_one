import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/shoudakusho.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tuple/tuple.dart';
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
  List<dynamic> KOJI_KAKAKU = [];
  Map<int, Map<String, String>> NEW_TABLE_DATA = {};
  Map<int, Tuple2<TextEditingController?, FocusNode?>> codeCtrls = {};
  Map<int, Tuple2<TextEditingController?, FocusNode?>> quantityCtrls = {};
  TextEditingController remarkCtrl = TextEditingController();

  late AutoScrollController _scrollController;
  int _firstVisibleItemIndex = 0;
  @override
  void initState() {
    super.initState();
    initScroll();
    callGetKojiHoukoku();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void initScroll() {
    _scrollController = AutoScrollController(
        axis: Axis.vertical,

        //this given value will bring the scroll offset to the nearest position in fixed row height case.
        //for variable row height case, you can still set the average height, it will try to get to the relatively closer offset
        //and then start searching.
        suggestedRowHeight: 30.h);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _firstVisibleItemIndex =
          (_scrollController.position.pixels / 30.h).floor();
    });
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

          if (body["KOJI_KAKAKU"] != null) {
            setState(() {
              KOJI_KAKAKU = body["KOJI_KAKAKU"];
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
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 30.h,
                                    child: Row(children: _buildTitle(5))),
                                NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    if (scrollNotification
                                        is ScrollEndNotification) {
                                      if (_firstVisibleItemIndex >= 0) {
                                        _scrollController.scrollToIndex(
                                            _firstVisibleItemIndex);
                                      }
                                    }
                                    return true;
                                  },
                                  child: SizedBox(
                                    height: 370.h,
                                    width: MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? 760
                                        : MediaQuery.of(context).size.width -
                                            33,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      controller: _scrollController,
                                      itemCount: max(
                                          TABLE_DATA.length +
                                              NEW_TABLE_DATA.length +
                                              5,
                                          20),
                                      itemBuilder: (context, index) {
                                        return AutoScrollTag(
                                          key: ValueKey(index),
                                          index: index,
                                          controller: _scrollController,
                                          child: SizedBox(
                                            height: 30.h,
                                            child: Row(
                                              children: _buildCells2(5, index),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
                                    children: [
                                      const Text(
                                        '備考欄',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextFormField(
                                          controller: remarkCtrl,
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            isDense: true,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          cursorColor: Colors.black,
                                        ),
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
                                        child: GestureDetector(
                                          onTap: () {
                                            remarkCtrl.text = '';
                                          },
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  KOJI_DATA['CO_NAME'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  postFormat(KOJI_DATA['CO_POSTNO']),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  KOJI_DATA['CO_ADDRESS'] ?? '',
                                  style: const TextStyle(
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

  String postFormat(String? postNo) {
    if (postNo == null || postNo.isEmpty || postNo.length != 7) {
      return '';
    }
    return '〒${postNo.substring(0, 3)}-${postNo.substring(3, 7)}';
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
        text = widget.JYUCYU_ID;
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
                (size.width - 33) * 2 / 7 + -30,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
              ];

    return List.generate(count, (col) {
      String text = '';
      switch (col) {
        case 0:
          text = "担当営業所・担当店";
          break;
        case 1:
          text = KOJI_DATA["KOJIGYOSYA_NAME"] ?? "";
          break;
        case 2:
          text = "担当者名";
          break;
        case 3:
          text = [
            KOJI_DATA["HOMON_TANT_NAME1"] ?? "",
            KOJI_DATA["HOMON_TANT_NAME2"] ?? "",
            KOJI_DATA["HOMON_TANT_NAME3"] ?? ""
          ].where((s) => s != null && s.isNotEmpty).join(', ');
          break;
        case 4:
          text = "ご訪問日";
          break;
        case 5:
          text = KOJI_DATA["KOJI_YMD"] ?? "";
          break;
        default:
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
      return SizedBox(
        height: 30.h,
        child: AutoScrollTag(
          key: ValueKey(index),
          index: index,
          controller: _scrollController,
          child: Row(
            children: _buildCells2(5, index),
          ),
        ),
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
      // if (row == 0) {
      //   return Container(
      //     decoration: BoxDecoration(
      //       border: Border.all(width: 0.5),
      //       color: Colors.white,
      //     ),
      //     alignment: Alignment.center,
      //     width: colwidth[col],
      //     height: 30,
      //     child: Text(
      //       colNames[col],
      //       style: const TextStyle(
      //         color: Colors.black,
      //         fontSize: 15,
      //         fontWeight: FontWeight.w700,
      //       ),
      //     ),
      //   );
      // }

      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: colwidth[col],
        height: 30,
        child: contentTable(col: col, row: row + 1),
      );
    });
  }

  List<Widget> _buildTitle(int count) {
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
    });
  }

  Widget contentTable({required int col, required int row, String? initial}) {
    if (TABLE_DATA.isNotEmpty && row <= TABLE_DATA.length) {
      List<String> list = [
        "TUIKA_SYOHIN_NAME",
        "TUIKA_JISYA_CD",
        "SURYO",
        "HANBAI_TANKA",
        "KINGAK",
      ];
      var item = TABLE_DATA.elementAt(row - 1);
      String text = '';
      if (item is Map) {
        text = TABLE_DATA[row - 1][list[col]] ?? '';
      }
      return Text(
        text,
        style: const TextStyle(color: Colors.black),
      );
    }

    // if (NEW_TABLE_DATA.isNotEmpty && row <= NEW_TABLE_DATA.length) {
    //   List<String> list = [
    //     "TUIKA_SYOHIN_NAME",
    //     "TUIKA_JISYA_CD",
    //     "SURYO",
    //     "HANBAI_TANKA",
    //     "KINGAK",
    //   ];
    //   var item = NEW_TABLE_DATA.elementAt(row - 1);
    //   String text = '';
    //   if (item is Map) {
    //     text = NEW_TABLE_DATA[row - 1][list[col]] ?? '';
    //   }

    //   if (col == 1 || col == 2) {
    //     return TextFormField(
    //       inputFormatters: [],
    //       onChanged: (value) {
    //         onChange(value, row, col);
    //       },
    //       initialValue: text,
    //       minLines: 1,
    //       maxLines: 1,
    //       decoration: const InputDecoration(
    //         contentPadding: EdgeInsets.only(top: 5, bottom: 5),
    //         isDense: true,
    //         enabledBorder: UnderlineInputBorder(
    //           borderSide: BorderSide(color: Colors.black),
    //         ),
    //         focusedBorder: UnderlineInputBorder(
    //           borderSide: BorderSide(color: Colors.black),
    //         ),
    //       ),
    //       cursorColor: Colors.black,
    //     );
    //   }
    //   return Text(
    //     text,
    //     style: const TextStyle(color: Colors.black),
    //   );
    // }

    Map<String, String>? data = NEW_TABLE_DATA[row];

    String textValue = initial ?? '';
    if (data != null) {
      switch (col) {
        case 0:
          textValue = data['TUIKA_SYOHIN_NAME'] ?? '';
          break;
        case 1:
          textValue = data['TUIKA_JISYA_CD'] ?? '';
          break;
        case 2:
          textValue = data['SURYO'] ?? '';
          break;
        case 3:
          textValue = data['HANBAI_TANKA'] ?? '';
          break;
        case 4:
          textValue = data['KINGAK'] ?? '';
          break;
        default:
          break;
      }
      if (col == 1) {
        textValue = data['TUIKA_JISYA_CD'] ?? '';
      }
      if (col == 2) {
        textValue = data['SURYO'] ?? '';
      }
    }

    if (col == 1 || col == 2) {
      TextEditingController? ctrl;
      FocusNode? focusNode;
      if (col == 1) {
        ctrl = codeCtrls[row]?.item1;
        if (ctrl == null) {
          ctrl = TextEditingController(text: textValue);
          focusNode = FocusNode();
          codeCtrls[row] = Tuple2(ctrl, focusNode);
        }
      } else {
        ctrl = quantityCtrls[row]?.item1;
        if (ctrl == null) {
          ctrl = TextEditingController(text: textValue);
          focusNode = FocusNode();
          quantityCtrls[row] = Tuple2(ctrl, focusNode);
        }
      }

      return TextFormField(
        inputFormatters: [
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          // for version 2 and greater youcan also use this
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(col == 1 ? 4 : 100)
        ],
        onChanged: (value) {
          onChange(value, row, col);
        },
        controller: ctrl,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        minLines: 1,
        maxLines: 1,
        textAlign: TextAlign.center,
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
    return Text(
      textValue,
      style: const TextStyle(color: Colors.black),
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

  void onChange(String value, int row, int col) {
    String jisyaCode = 'KOJ-$value';
    if (col == 1) {
      // code
      var item = KOJI_KAKAKU
          .firstWhere((element) => (element['JISYA_CD'] as String) == jisyaCode,
              orElse: () {
        return null;
      });

      if (item != null) {
        Map<String, String>? data = NEW_TABLE_DATA[row];
        int quantity = 0;
        if (data != null) {
          String quantityStr = data['SURYO'] ?? '';
          quantity = quantityStr.isNotEmpty ? int.parse(quantityStr) : 0;
        }

        String unitPriceStr = item['HANBAI_TANKA'] ?? '';
        int unitPrice = unitPriceStr.isNotEmpty ? int.parse(unitPriceStr) : 0;
        Map<String, String> newData = {
          'TUIKA_SYOHIN_NAME': item['SYOHIN_NAME'] ?? '',
          'TUIKA_JISYA_CD': value,
          'SURYO': quantity > 0 ? '$quantity' : '',
          'HANBAI_TANKA': item['HANBAI_TANKA'] ?? '',
          'KINGAK': (quantity > 0) && (unitPrice) > 0
              ? '${quantity * unitPrice}'
              : '',
        };
        setDataNew(newData, row, col);
      } else {
        setState(() {
          quantityCtrls[row]?.item1!.text = '';
          NEW_TABLE_DATA.remove(row);
        });
      }
    } else {
      // quantity
      Map? data = NEW_TABLE_DATA[row];
      if (data != null) {
        int quantity = value.isNotEmpty ? int.parse(value) : 0;
        String unitPriceStr = data['HANBAI_TANKA'] ?? '';
        int unitPrice = unitPriceStr.isNotEmpty ? int.parse(unitPriceStr) : 0;

        Map<String, String> newData = {
          'TUIKA_SYOHIN_NAME': data['TUIKA_SYOHIN_NAME'] ?? '',
          'TUIKA_JISYA_CD': data['TUIKA_JISYA_CD'] ?? '',
          'SURYO': quantity.toString(),
          'HANBAI_TANKA': data['HANBAI_TANKA'] ?? '',
          'KINGAK': (quantity > 0) && (unitPrice) > 0
              ? '${quantity * unitPrice}'
              : '',
        };

        setDataNew(newData, row, col);
      }
    }
  }

  void setDataNew(Map<String, String> data, int row, int col) {
    setState(() {
      NEW_TABLE_DATA[row] = data;
    });
  }
}
