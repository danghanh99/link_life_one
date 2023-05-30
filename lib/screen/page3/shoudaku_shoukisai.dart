import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/models/koji_houkoku_model.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/screen/page3/shoudakusho.dart';
import 'package:link_life_one/shared/cache_notifier.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:link_life_one/shared/number_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tuple/tuple.dart';
import '../../api/shoudakusho/get_shoudakusho.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';
import '../../shared/extension.dart';

class ShoudakuShoukisai extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final String KOJI_ST;
  final String SINGLE_SUMMARIZE;
  final List<KojiHoukokuModel> kojiHoukoku;

  const ShoudakuShoukisai(
      {super.key,
      this.initialDate,
      required this.JYUCYU_ID,
      required this.SINGLE_SUMMARIZE,
      required this.KOJI_ST,
      required this.kojiHoukoku});

  @override
  State<ShoudakuShoukisai> createState() => _ShoudakuShoukisaiState();
}

class _ShoudakuShoukisaiState extends State<ShoudakuShoukisai>
    with AutomaticKeepAliveClientMixin {
  GlobalKey _listKey = GlobalKey();
  dynamic KOJI_DATA = {};
  List<dynamic> TABLE_DATA = [];
  List<dynamic> KOJI_KAKAKU = [];
  Map<int, Map<String, String>> NEW_TABLE_DATA = {};
  Map<int, Tuple2<TextEditingController?, FocusNode?>> nameCtrls = {};
  Map<int, Tuple2<TextEditingController?, FocusNode?>> codeCtrls = {};
  Map<int, Tuple2<TextEditingController?, FocusNode?>> quantityCtrls = {};
  Map<int, Tuple2<TextEditingController?, FocusNode?>> unitPriceCtrls = {};
  TextEditingController remarkCtrl = TextEditingController();

  late AutoScrollController _scrollController;
  int _firstVisibleItemIndex = 0;

  bool hasAnyEmpty = false;
  bool? checkSign;

  @override
  void initState() {
    super.initState();
    _checkOnline();
    initScroll();
    callGetKojiHoukoku();
  }

  bool isOnline = true;

  _checkOnline()async{
    isOnline = await LocalStorageNotifier.isOnline();
    setState((){});
  }

  @override
  bool get wantKeepAlive => true;

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

    // _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    RenderBox? renderBox =
        _listKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double top = offset.dy;
    double bottom = top + renderBox.size.height;
    int startIndex = _getItemIndexAtOffset(top);
    int endIndex = _getItemIndexAtOffset(bottom);
    dev.log("Visible items from $startIndex to $endIndex");
    // setState(() {
    // _firstVisibleItemIndex = startIndex;
    // });
  }

  int _getItemIndexAtOffset(double offset) {
    RenderBox? renderBox =
        _listKey.currentContext?.findRenderObject() as RenderBox;
    int index = 0;
    for (double h = 0;
        h < offset && index < NEW_TABLE_DATA.length;
        // h < offset && index < TABLE_DATA.length + NEW_TABLE_DATA.length;
        index++) {
      h += renderBox.size.height;
    }
    return index - 1;
  }

  void resetData() {
    KOJI_DATA = {};
    TABLE_DATA = [];
    KOJI_KAKAKU = [];
    NEW_TABLE_DATA = {};
    nameCtrls.clear();
    codeCtrls.clear();
    quantityCtrls.clear();
  }

  Future<dynamic> callGetKojiHoukoku() async {
    resetData();
    final dynamic result = await GetShoudakusho().getShoudakusho(
        JYUCYU_ID: widget.JYUCYU_ID,
        KOJI_ST: widget.KOJI_ST,
        onSuccess: (body) {
          if (body["KOJI_DATA"] != null) {
            KOJI_DATA = body["KOJI_DATA"][0];
          }

          if (body["TABLE_DATA"] != null) {
            TABLE_DATA = body["TABLE_DATA"];
            List tableData = TABLE_DATA;
            for(var t in tableData){
              Map<String, String> newData = {
                'TUIKA_SYOHIN_NAME': t['TUIKA_SYOHIN_NAME'],
                'TUIKA_JISYA_CD': t['TUIKA_JISYA_CD'],
                'SURYO': t['SURYO'],
                'HANBAI_TANKA': t['HANBAI_TANKA'],
                'KINGAK': t['KINGAK'],
                'CHANGE_FLG': '0'
              };
              NEW_TABLE_DATA[tableData.indexOf(t)] = newData;
            }
          }

          if (body["KOJI_KAKAKU"] != null) {
            KOJI_KAKAKU = body["KOJI_KAKAKU"];
          }
          if (body["CHECK_SIGN"] != null) {
            checkSign = body["CHECK_SIGN"];
          }
          loadCachedata(context);
        },
        onFailed: () {
          CustomToast.show(context, message: "承諾書を取得出来ませんでした。");
        });
  }

  void loadCachedata(BuildContext context) {
    List<Map<String, String>> newTableData = context
            .read<CacheNotifier>()
            .cacheNewTableShoudakuShoukisai[widget.JYUCYU_ID] ??
        [];
    for (var element in newTableData) {
      int row = NEW_TABLE_DATA.length;
      // int row = TABLE_DATA.length + NEW_TABLE_DATA.length;
      NEW_TABLE_DATA[row] = element;
    }

    dev.log('load cache: ${jsonEncode(newTableData)}');

    String remark =
        context.read<CacheNotifier>().cacheRemarks[widget.JYUCYU_ID] ?? '';
    remarkCtrl.text = remark;
    setState(() {});
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            context
                                .read<CacheNotifier>()
                                .cacheNewTableShoudakuShoukisaiList(
                                    widget.JYUCYU_ID,
                                    NEW_TABLE_DATA.values.toList());
                            context
                                .read<CacheNotifier>()
                                .cacheRemark(widget.JYUCYU_ID, remarkCtrl.text);
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
                        // title2(),
                        _buildHeader(),
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
                        SizedBox(
                          height: 400.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                  height: 30.h,
                                  child: Row(children: _buildTitle(5))),
                              SizedBox(
                                height: 370.h,
                                child: _buildListView(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildSum(getSum()),
                        const Text(
                          '担当者情報',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _buildFooter(),
                        const SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        color: const Color(0xFFCCCCCC),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '備考欄',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextField(
                                          key: null,
                                          controller: remarkCtrl,
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                          textInputAction: TextInputAction.newline,
                                          decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            isDense: true,
                                            border: InputBorder.none,
                                          ),
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Visibility(
                                        visible: KOJI_DATA['CO_CD'] != null &&
                                            KOJI_DATA['CO_CD'] != '',
                                        child: KOJI_DATA['CO_CD'] != null
                                            ? FadeInImage(
                                                placeholder: Assets.blankImage,
                                                image: NetworkImage(
                                                    KOJI_DATA['CO_CD']),
                                                imageErrorBuilder: (context,
                                                    error, stackTrace) {
                                                  return !isOnline && LocalStorageNotifier.isTodayDownload()
                                                      ? Image.file(File(KOJI_DATA['CO_CD']))
                                                      : const Icon(Icons.error);
                                                },
                                              )
                                            : const SizedBox.shrink()),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: hasAnyEmpty,
                  child: const Text(
                    '入力必須です。',
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ),
                sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    dev.log('_buildListView');
    return ListView.builder(
      key: _listKey,
      padding: EdgeInsets.zero,
      controller: _scrollController,
      itemCount: max(NEW_TABLE_DATA.length + 5, 20),
      // itemCount: max(TABLE_DATA.length + NEW_TABLE_DATA.length + 5, 20),
      itemBuilder: (context, index) {
        return IntrinsicHeight(
          child: Row(
            key: ValueKey(index),
            children: _buildCells2(5, index),
          ),
        );
      },
    );
  }

  int getSum() {
    int result = 0;
    // for (var element in TABLE_DATA) {
    //   if (element['KINGAK'] != null) {
    //     result += int.tryParse(element['KINGAK']) ?? 0;
    //   }
    // }

    for (var key in NEW_TABLE_DATA.keys) {
      Map? data = NEW_TABLE_DATA[key];
      if (data != null && data['KINGAK'] != null) {
        result += int.tryParse(data['KINGAK']) ?? 0;
      }
    }
    return result;
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
      Color bgColor = Colors.white;
      BorderSide borderSide =
          const BorderSide(color: Color(0xFFDB4158), width: 2);
      Border border =
          Border(left: borderSide, top: borderSide, bottom: borderSide);
      if (col == 0) {
        text = "受注ID";
        bgColor = const Color(0xFFEBBDA9);
      }
      if (col == 1) {
        text = widget.JYUCYU_ID.length == 10
            ? widget.JYUCYU_ID
            : widget.JYUCYU_ID.substring(0, 10);
      }
      if (col == 2) {
        text = "お客様名";
        bgColor = const Color(0xFFEBBDA9);
      }
      if (col == 3) {
        text = KOJI_DATA["SETSAKI_NAME"] ?? "";
      }
      if (col == 4) {
        text = "ご訪問日";
        bgColor = const Color(0xFFEBBDA9);
      }
      if (col == 5) {
        text = KOJI_DATA["KOJI_YMD"] ?? "";
        border = Border.all(width: 2, color: const Color(0xFFDB4158));
      }

      return Container(
        decoration: BoxDecoration(
          border: border,
          color: bgColor,
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

  Widget _buildHeader() {
    BorderSide borderSide =
        const BorderSide(color: Color(0xFFDB4158), width: 2);
    Border border =
        Border(left: borderSide, top: borderSide, bottom: borderSide);
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              _buildHeaderItem(
                  title: '受注ID',
                  textColor: const Color(0xFFDB4158),
                  bgColor: const Color(0xFFEBBDA9),
                  border: border),
              Expanded(
                child: _buildHeaderItem(
                    title: widget.JYUCYU_ID.length == 10
                        ? widget.JYUCYU_ID
                        : widget.JYUCYU_ID.substring(0, 10),
                    bgColor: Colors.white,
                    border: border),
              ),
              _buildHeaderItem(
                  title: 'ご訪問日',
                  textColor: const Color(0xFFDB4158),
                  bgColor: const Color(0xFFEBBDA9),
                  border: border),
              Expanded(
                child: _buildHeaderItem(
                    title: KOJI_DATA["KOJI_YMD"] ?? "",
                    bgColor: Colors.white,
                    border:
                        Border.all(color: const Color(0xFFDB4158), width: 2)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        IntrinsicHeight(
          child: Row(
            children: [
              _buildHeaderItem(
                  title: 'お客様名',
                  textColor: const Color(0xFFDB4158),
                  bgColor: const Color(0xFFEBBDA9),
                  border: border),
              Expanded(
                child: _buildHeaderItem(
                    title: KOJI_DATA["SETSAKI_NAME"] ?? "",
                    bgColor: Colors.white,
                    border: border,
                    alignment: Alignment.centerLeft),
              ),
              _buildHeaderItem(
                  title: '様',
                  textColor: const Color(0xFFDB4158),
                  bgColor: Colors.white,
                  border: Border(
                      right: borderSide, top: borderSide, bottom: borderSide),
                  alignment: Alignment.centerRight),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    BorderSide borderSide =
        const BorderSide(color: Color(0xFFDB4158), width: 2);
    Border border =
        Border(left: borderSide, top: borderSide, bottom: borderSide);
    return IntrinsicHeight(
      child: Row(
        children: [
          _buildHeaderItem(
              title: '担当営業所・担当店',
              textColor: const Color(0xFFDB4158),
              bgColor: const Color(0xFFEBBDA9),
              border: border),
          Expanded(
            child: _buildHeaderItem(
                title: KOJI_DATA["KOJIGYOSYA_NAME"] ?? '',
                bgColor: Colors.white,
                border: border),
          ),
          _buildHeaderItem(
              title: '担当者名',
              textColor: const Color(0xFFDB4158),
              bgColor: const Color(0xFFEBBDA9),
              border: border),
          Expanded(
            child: _buildHeaderItem(
                flex: 4,
                title: [
                  KOJI_DATA["HOMON_TANT_NAME1"] ?? "",
                  KOJI_DATA["HOMON_TANT_NAME2"] ?? "",
                  KOJI_DATA["HOMON_TANT_NAME3"] ?? ""
                ].where((s) => s != null && s.isNotEmpty).join(', '),
                bgColor: Colors.white,
                border: Border.all(color: const Color(0xFFDB4158), width: 2)),
          ),
        ],
      ),
    );
  }

  Widget _buildSum(int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('追加費用合計金額 (税込み)',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerRight,
          decoration:
              BoxDecoration(border: Border.all(width: 3, color: Colors.black)),
          child: Text(value.formatNumber),
        ),
        const SizedBox(width: 8),
        const Text(
          '円',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderItem(
      {int flex = 1,
      String title = '',
      Color? textColor,
      Color bgColor = Colors.white,
      Border? border,
      Alignment alignment = Alignment.center}) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        color: bgColor,
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
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
    List<int> flexs = [16, 4, 4, 2, 4];

    return List.generate(count, (col) {
      return Expanded(
        flex: flexs[col],
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: col == 1 ? const Color(0xFFEBBDA9) : Colors.white,
          ),
          // height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          alignment: align(col),
          child: contentTable(col: col, row: row),
        ),
      );
    });
  }

  List<Widget> _buildTitle(int count) {
    List<String> colNames = [
      '内容',
      'コード',
      '単価（税込）',
      '数量',
      '小計（税込）',
    ];
    List<int> flexs = [16, 4, 4, 2, 4];

    return List.generate(count, (col) {
      return Expanded(
        flex: flexs[col],
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFFCCCCCC),
          ),
          alignment: Alignment.center,
          // width: colwidth[col],
          height: 30,
          child: Text(
            colNames[col],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    });
  }

  Widget contentTable({required int col, required int row, String? initial}) {
    // if (TABLE_DATA.isNotEmpty && row < TABLE_DATA.length) {
    //   List<String> list = [
    //     "TUIKA_SYOHIN_NAME",
    //     "TUIKA_JISYA_CD",
    //     "HANBAI_TANKA",
    //     "SURYO",
    //     "KINGAK",
    //   ];
    //   var item = TABLE_DATA.elementAt(row);
    //   String text = '';
    //   if (item is Map) {
    //     text = TABLE_DATA[row][list[col]] ?? '';
    //   }
    //   if (col == 2 || col == 3 || col == 4) {
    //     text = text.formatNumber;
    //   }
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 3.0),
    //     child: Text(
    //       text,
    //       // textAlign: align(col),
    //       softWrap: true,
    //       style: const TextStyle(color: Colors.black, fontSize: 16),
    //     ),
    //   );
    // }

    Map<String, String>? data = NEW_TABLE_DATA[row];

    String textValue = initial ?? '';
    bool canEditUnitPrice = false;
    if (data != null) {
      canEditUnitPrice = data['CHANGE_FLG'] == '1';
      switch (col) {
        case 0:
          textValue = data['TUIKA_SYOHIN_NAME'] ?? '';
          break;
        case 1:
          textValue = data['TUIKA_JISYA_CD'] ?? '';
          break;
        case 2:
          textValue = data['HANBAI_TANKA'] != null
              ? data['HANBAI_TANKA']!.formatNumber
              : '';
          break;
        case 3:
          textValue = data['SURYO'] != null ? data['SURYO']!.formatNumber : '';

          break;
        case 4:
          textValue =
              data['KINGAK'] != null ? data['KINGAK']!.formatNumber : '';
          break;
        default:
          break;
      }
    }
    if (col == 0 || col == 1 || col == 2 || col == 3) {
      TextEditingController? ctrl;
      FocusNode? focusNode;
      switch (col) {
        case 0:
          ctrl = nameCtrls[row]?.item1;
          if (ctrl == null) {
            ctrl = TextEditingController(text: textValue);
            focusNode = FocusNode();
            nameCtrls[row] = Tuple2(ctrl, focusNode);
          } else {
            ctrl.text = textValue;
            ctrl.selection = TextSelection.fromPosition(
                TextPosition(offset: textValue.length));
          }
          break;
        case 1:
          ctrl = codeCtrls[row]?.item1;
          if (ctrl == null) {
            ctrl = TextEditingController(text: textValue);
            focusNode = FocusNode();
            codeCtrls[row] = Tuple2(ctrl, focusNode);
          } else {
            ctrl.text = textValue;
            ctrl.selection = TextSelection.fromPosition(
                TextPosition(offset: textValue.length));
          }
          break;
        case 2:
          ctrl = unitPriceCtrls[row]?.item1;
          if (ctrl == null) {
            ctrl = TextEditingController(text: textValue);
            focusNode = FocusNode();
            unitPriceCtrls[row] = Tuple2(ctrl, focusNode);
          } else {
            ctrl.text = textValue;
            ctrl.selection = TextSelection.fromPosition(
                TextPosition(offset: textValue.length));
          }
          break;
        case 3:
          ctrl = quantityCtrls[row]?.item1;
          if (ctrl == null) {
            ctrl = TextEditingController(text: textValue);
            focusNode = FocusNode();
            quantityCtrls[row] = Tuple2(ctrl, focusNode);
          } else {
            ctrl.text = textValue;
            ctrl.selection = TextSelection.fromPosition(
                TextPosition(offset: textValue.length));
          }

          break;
        default:
      }

      return TextField(
        key: ValueKey('$row$col'),
        inputFormatters: col == 0
            ? []
            : [
                // for below version 2 use this
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // for version 2 and greater youcan also use this
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(col == 1 ? 4 : 100),
                if (col == 2 || col == 3) NumberInputFormatter(),
              ],
        onChanged: (value) {
          onChange(value, row, col);
        },
        readOnly: col != 2 ? false : !canEditUnitPrice,
        controller: ctrl,
        focusNode: focusNode,
        keyboardType: col == 0 ? TextInputType.multiline : TextInputType.number,
        minLines: 1,
        maxLines: 100,
        textAlign: textAlign(col),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 5, bottom: 5),
          isDense: true,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      );
    }
    return Text(
      textValue,
      // textAlign: align(col),
      softWrap: true,
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  Alignment align(int col) {
    switch (col) {
      case 0:
        return Alignment.centerLeft;
      case 1:
        return Alignment.center;
      case 2:
        return Alignment.centerRight;
      case 3:
        return Alignment.center;
      case 4:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  TextAlign textAlign(int col) {
    switch (col) {
      case 0:
        return TextAlign.left;
      case 1:
        return TextAlign.center;
      case 2:
        return TextAlign.right;
      case 3:
        return TextAlign.center;
      case 4:
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
          onTap: () {
            hasAnyEmpty = false;
            NEW_TABLE_DATA.forEach((key, value) {
              if(
                value['TUIKA_SYOHIN_NAME']==null || value['TUIKA_SYOHIN_NAME']!.isEmpty
                || value['SURYO']==null || value['SURYO']!.isEmpty
                || value['HANBAI_TANKA']==null || value['HANBAI_TANKA']!.isEmpty
                || value['KINGAK']==null || value['KINGAK']!.isEmpty
              ){
                setState(() {
                  hasAnyEmpty = true;
                });
                return;
              }
            });

            // go to top
            if(!hasAnyEmpty){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoudakuSho(
                    kojiData: KOJI_DATA,
                    tableData: [],
                    // tableData: TABLE_DATA,
                    newTableData: NEW_TABLE_DATA.values.toList(),
                    jyucyuId: widget.JYUCYU_ID,
                    singleSummarize: widget.SINGLE_SUMMARIZE,
                    biko: remarkCtrl.text,
                    initialDate: widget.initialDate,
                    checkSign: checkSign ?? false,
                    onSaveSuccess: () {
                      callGetKojiHoukoku();
                    },
                    kojiHoukoku: widget.kojiHoukoku,
                  ),
                ),
              );
            }

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
            width: 180.w,
            height: 37,
            decoration: BoxDecoration(
              color: const Color(0xFFFFA800),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Center(
              child: Text(
                '次へ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
    switch (col) {
      case 0:
        // quantity
        Map? data = NEW_TABLE_DATA[row];
        if (data != null) {
          Map<String, String> newData = {
            'TUIKA_SYOHIN_NAME': value,
            'TUIKA_JISYA_CD': data['TUIKA_JISYA_CD'] ?? '',
            'SURYO': data['SURYO'],
            'HANBAI_TANKA': data['HANBAI_TANKA'] ?? '',
            'KINGAK': data['KINGAK'],
            'CHANGE_FLG': data['CHANGE_FLG'] ?? '0'
          };

          setDataNew(newData, row, col);
        }
        break;
      case 1:
        // code
        var item = KOJI_KAKAKU.firstWhere(
            (element) => (element['JISYA_CD'] as String) == jisyaCode,
            orElse: () {
          return null;
        });

        if (item != null) {
          Map<String, String>? data = NEW_TABLE_DATA[row];
          // setState(() {
          nameCtrls[row]?.item1!.text = item['SYOHIN_NAME'] ?? '';
          // });
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
            'CHANGE_FLG': item['CHANGE_FLG'] ?? '0'
          };
          setDataNew(newData, row, col);
        } else {
          nameCtrls[row]?.item1!.text = '';
          quantityCtrls[row]?.item1!.text = '';
          unitPriceCtrls[row]?.item1!.text = '';

          Map<String, String> newData = {
            'TUIKA_SYOHIN_NAME': '',
            'TUIKA_JISYA_CD': value,
            'SURYO': '',
            'HANBAI_TANKA': '',
            'KINGAK': '',
            'CHANGE_FLG': '0'
          };

          setDataNew(newData, row, col);
        }
        break;
      case 3:
        // quantity
        Map? data = NEW_TABLE_DATA[row];
        if (data != null) {
          int quantity =
              value.isNotEmpty ? int.parse(value.replaceAll(',', '')) : 0;
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
            'CHANGE_FLG': data['CHANGE_FLG'] ?? '0'
          };

          setDataNew(newData, row, col);
        }
        break;
      case 2:
        // unit price
        Map? data = NEW_TABLE_DATA[row];
        if (data != null) {
          int unitPrice =
              value.isNotEmpty ? int.parse(value.replaceAll(',', '')) : 0;
          String quantity = data['SURYO'] ?? '';
          int quantityNumber = quantity.isNotEmpty ? int.parse(quantity) : 0;

          Map<String, String> newData = {
            'TUIKA_SYOHIN_NAME': data['TUIKA_SYOHIN_NAME'] ?? '',
            'TUIKA_JISYA_CD': data['TUIKA_JISYA_CD'] ?? '',
            'SURYO': data['SURYO'] ?? '',
            'HANBAI_TANKA': unitPrice.toString(),
            'KINGAK': (quantityNumber > 0) && (unitPrice) > 0
                ? '${quantityNumber * unitPrice}'
                : '',
            'CHANGE_FLG': data['CHANGE_FLG'] ?? '0'
          };

          setDataNew(newData, row, col);
        }
        break;
      default:
    }
  }

  void setDataNew(Map<String, String> data, int row, int col) {
    if(col!=0) {
      setState(() {
        NEW_TABLE_DATA[row] = data;
      });
    }
    else{
      NEW_TABLE_DATA[row] = data;
    }

    FocusNode? focusNode;

    switch (col) {
      case 0:
        focusNode = nameCtrls[row]?.item2;
        break;
      case 1:
        focusNode = codeCtrls[row]?.item2;
        break;
      case 2:
        focusNode = unitPriceCtrls[row]?.item2;
        break;
      case 3:
        focusNode = quantityCtrls[row]?.item2;
        break;
      default:
        break;
    }

    if (focusNode != null) {
      focusNode.requestFocus();
    }
  }
}
