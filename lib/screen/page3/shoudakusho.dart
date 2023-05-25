import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_life_one/api/shoudakusho/get_shoudakusho.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/shared/cache_notifier.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:link_life_one/shared/extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:image/image.dart' as image;

import '../../api/shoudakusho/submit_last_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/koji_houkoku_model.dart';
import '../../shared/assets.dart';

class ShoudakuSho extends StatefulWidget {
  final DateTime? initialDate;
  final Map<String, dynamic> kojiData;
  final List<dynamic> tableData;
  final List<Map<String, dynamic>> newTableData;
  final String singleSummarize;
  final String jyucyuId;
  final String biko;
  final Function() onSaveSuccess;
  final List<KojiHoukokuModel> kojiHoukoku;
  final bool checkSign;
  const ShoudakuSho(
      {super.key,
      this.initialDate,
      required this.kojiData,
      required this.tableData,
      required this.newTableData,
      required this.singleSummarize,
      required this.jyucyuId,
      required this.biko,
      required this.onSaveSuccess,
      required this.kojiHoukoku,
      required this.checkSign});

  @override
  State<ShoudakuSho> createState() => _ShoudakuShoState();
}

class _ShoudakuShoState extends State<ShoudakuSho> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.blue,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
  );

  File? file;
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;
  bool checkedValue6 = false;
  bool checkedValue7 = false;

  bool registeredSignature = false;
  String? signImageUrl;
  bool checkBoxError = false;
  // bool signatureEmptyError = false;
  // bool signatureNotRegistedError = false;
  String msgSignature = '';

  bool isOnline = true;

  _checkOnline()async{
    isOnline = await LocalStorageNotifier.isOnline();
    setState((){});
  }

  @override
  void initState() {
    _checkOnline();
    loadCachedata(context);
    file = null;
    _controller.addListener(() => debugPrint('Value changed'));
    _controller.onDrawStart = onDrawStart;
    _controller.onDrawEnd = onDrawEnd;
    _getSignImage();
    // registeredSignature = widget.checkSign;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  _getSignImage()async{
    signImageUrl = await GetShoudakusho().getCheckSignImage(
        jyucyuId: widget.jyucyuId,
        onSuccess: (){},
        onFailed: (){}
    );
    registeredSignature = signImageUrl!=null && signImageUrl!.isNotEmpty;
    _createSignatureFromImage(signImageUrl);
    setState(() {});
  }

  void loadCachedata(BuildContext context) {
    List<bool> selectedCheckbox =
        context.read<CacheNotifier>().cacheSelectedCheckBoxs[widget.jyucyuId] ??
            [];
    if (selectedCheckbox.isNotEmpty && selectedCheckbox.length == 7) {
      checkedValue1 = selectedCheckbox.first;
      checkedValue2 = selectedCheckbox[1];
      checkedValue3 = selectedCheckbox[2];
      checkedValue4 = selectedCheckbox[3];
      checkedValue5 = selectedCheckbox[4];
      checkedValue6 = selectedCheckbox[5];
      checkedValue7 = selectedCheckbox[6];
    }
  }

  void onDrawStart() {
    if (msgSignature.isNotEmpty) {
      setState(() {
        msgSignature = '';
      });
    }
  }

  void onDrawEnd() {}

  // Future<void> exportSVG(BuildContext context) async {
  //   if (_controller.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         key: Key('snackbarSVG'),
  //         content: Text('No content'),
  //       ),
  //     );
  //     return;
  //   }

  //   final SvgPicture data = _controller.toSVG()!;

  //   if (!mounted) return;

  //   await push(
  //     context,
  //     Scaffold(
  //       appBar: AppBar(
  //         title: const Text('SVG Image'),
  //       ),
  //       body: Center(
  //         child: Container(
  //           color: Colors.grey[300],
  //           child: data,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  bool validateCheckbox() {
    return (checkedValue1 &&
        checkedValue2 &&
        checkedValue3 &&
        checkedValue4 &&
        checkedValue5 &&
        checkedValue6 &&
        checkedValue7);
  }

  Future<Uint8List?> exportImage(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    final Uint8List? data = await _controller.toPngBytes(
        height: 600, width: ((size.width - 100) * 2).toInt());
    if (data == null) {
      return null;
    }

    if (!mounted) return null;

    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                            context
                                .read<CacheNotifier>()
                                .cacheListCheckBox(widget.jyucyuId, [
                              checkedValue1,
                              checkedValue2,
                              checkedValue3,
                              checkedValue4,
                              checkedValue5,
                              checkedValue6,
                              checkedValue7
                            ]);
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
                          name: '承諾書',
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
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildShoudakuShoukisai(),
                            Column(
                              children: [
                                Container(
                                  width: size.width - 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'お客様確認事項',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          const Divider(
                                            height: 1,
                                            color: Colors.black,
                                            thickness: 1.1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  '担当者が以下の事情を行っていたかご確認の上、□にチェックを入れてください。',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue1,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue1 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '水漏れ・ガス漏れチェック （エアコン配管・水道・ガス管なのど）',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue2,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue2 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '追加費用の内容説明',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue3,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue3 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '保証書・取扱説明書の発行・引渡し',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue4,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue4 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '作業後の清掃',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue5,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue5 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '作業箇所・搬出入通路のキズ・汚れ確認',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue6,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue6 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '機器の設置状況（歪み・傾き・動作）確認',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      activeColor: Colors.blue,
                                                      checkColor: Colors.white,
                                                      value: checkedValue7,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          checkedValue7 =
                                                              newValue ?? true;
                                                          checkBoxError = false;
                                                        });
                                                      },
                                                    ),
                                                    const Text(
                                                      '取扱い方法説明',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    '上記内容と問題なく設置機器が使用できることを確認致しました。',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 50,
                                        bottom: 50,
                                        right: 20,
                                        child: Container(
                                          width: 360,
                                          alignment: Alignment.centerRight,
                                          child: RichText(
                                            text: const TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: '※',
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w100)),
                                                TextSpan(
                                                    text:
                                                        '取付時・改修した箇所についてはその場で水漏れ・ガス漏れ等がないことを確認しております。\n念のため、お客さんご自身でも２～３日の間は漏れ等がないかご確認をお願いします。')
                                              ],
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                                visible: checkBoxError,
                                child: const SizedBox(
                                  height: 10,
                                )),
                            Visibility(
                                visible: checkBoxError,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Text('お客様確認事項に確認不足があります。',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red)),
                                )),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    left: 40,
                                  ),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'サイン記載スペース',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: size.width - 100,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: ClipRRect(
                                    child: Signature(
                                      key: const Key('signature'),
                                      controller: _controller,
                                      height: 300,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Visibility(
                                    visible: msgSignature.isNotEmpty,
                                    child: const SizedBox(
                                      height: 10,
                                    )),
                                Visibility(
                                    visible: msgSignature.isNotEmpty,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(msgSignature,
                                          style: const TextStyle(
                                              fontSize: 16, color: Colors.red)),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            sendButton2(),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'こちらの控えは後ほど、メールでお送りいたします',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShoudakuShoukisai() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '請求明細',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(height: 30.h, child: Row(children: _buildTitle(5))),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      widget.tableData.length + widget.newTableData.length,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: Row(
                        children: _buildCells2(5, index),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildSum(getSum()),
                const Text(
                  '担当者情報',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                child: Text(
                                  widget.biko,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.kojiData['CO_NAME'] ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  postFormat(widget.kojiData['CO_POSTNO']),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.kojiData['CO_ADDRESS'] ?? '',
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
                                visible: widget.kojiData['CO_CD'] != null &&
                                    widget.kojiData['CO_CD'] != '',
                                child: widget.kojiData['CO_CD'] != null
                                    ? FadeInImage(
                                        placeholder: Assets.blankImage,
                                        image: NetworkImage(widget.kojiData['CO_CD']),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return !isOnline && LocalStorageNotifier.isTodayDownload()
                                              ? Image.file(File(widget.kojiData['CO_CD']))
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
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
                    title: widget.jyucyuId.length == 10
                        ? widget.jyucyuId
                        : widget.jyucyuId.substring(0, 10),
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
                    title: widget.kojiData["KOJI_YMD"] ?? "",
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
                    flex: 13,
                    title: widget.kojiData["SETSAKI_NAME"] ?? "",
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
                title: widget.kojiData["KOJIGYOSYA_NAME"] ?? '',
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
                title: [
                  widget.kojiData["HOMON_TANT_NAME1"] ?? "",
                  widget.kojiData["HOMON_TANT_NAME2"] ?? "",
                  widget.kojiData["HOMON_TANT_NAME3"] ?? ""
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

  Widget contentTable({required int col, required int row, String? initial}) {
    List<String> list = [
      "TUIKA_SYOHIN_NAME",
      "TUIKA_JISYA_CD",
      "HANBAI_TANKA",
      "SURYO",
      "KINGAK",
    ];
    Map? item;
    String text = '';
    if (row < widget.tableData.length) {
      item = widget.tableData.elementAt(row);
    } else {
      item = widget.newTableData.elementAt(row - widget.tableData.length);
    }

    if (item != null) {
      text = item[list[col]] ?? '';
    }

    if (col == 2 || col == 3 || col == 4) {
      text = text.formatNumber;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
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

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            if (!validateCheckbox()) {
              setState(() {
                checkBoxError = true;
              });
              return;
            }

            if(!registeredSignature){
              CustomToast.show(
                context,
                message: "サインが未登録です",
                backGround: Colors.red
              );
              return;
            }

            // if (_controller.isEmpty) {
            //   setState(() {
            //     signatureEmptyError = true;
            //   });
            // }

            // if (!registeredSignature) {
            //   // CustomToast.show(context, message: 'サインが未登録です。');
            //   setState(() {
            //     signatureNotRegistedError = true;
            //   });
            //   return;
            // }
            showDialog(
              context: context,
              builder: (ctx) {
                return SizedBox(
                  width: double.infinity,
                  child: CupertinoAlertDialog(
                    title: const Text(
                      "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "承諾書を発行し、一覧画面に戻ります",
                        style: TextStyle(
                          color: Color.fromARGB(255, 24, 23, 23),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            SubmitLastPage.shared.submitLastPage(
                              SINGLE_SUMMARIZE: widget.singleSummarize,
                              JYUCYU_ID: widget.jyucyuId,
                              CHECK_FLG1: checkedValue1 ? "1" : "0",
                              CHECK_FLG2: checkedValue2 ? "1" : "0",
                              CHECK_FLG3: checkedValue3 ? "1" : "0",
                              CHECK_FLG4: checkedValue4 ? "1" : "0",
                              CHECK_FLG5: checkedValue5 ? "1" : "0",
                              CHECK_FLG6: checkedValue6 ? "1" : "0",
                              CHECK_FLG7: checkedValue7 ? "1" : "0",
                              biko: widget.biko,
                              list: widget.newTableData,
                              kojiHoukoku: widget.kojiHoukoku,
                              onSuccess: () {
                                widget.onSaveSuccess();
                                CustomToast.show(ctx,
                                    message: "登録出来ました。",
                                    backGround: Colors.green);
                                context
                                    .read<CacheNotifier>()
                                    .clearCache(widget.jyucyuId);
                                Navigator.of(ctx).popUntil((route) =>
                                    route.settings.name == 'KojiichiranPage3');
                              },
                              onFailed: (msg) {
                                Navigator.pop(ctx);
                                CustomToast.show(
                                  ctx,
                                  message: "登録できませんでした。",
                                );
                                setState(() {
                                  msgSignature = msg;
                                });
                              },
                            );
                          },
                          child: const Text(
                            'はい',
                            style: TextStyle(
                              color: Color(0xFF007AFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        child: const Text(
                          'いいえ',
                          style: TextStyle(
                            color: Color(0xFFEB5757),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: 80,
            height: 37,
            decoration: BoxDecoration(
              color: const Color(0xFFFFA800),
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Center(
              child: Text(
                '登録',
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

  int getSum() {
    int result = 0;
    for (var element in widget.tableData) {
      if (element['KINGAK'] != null) {
        result += int.tryParse(element['KINGAK']) ?? 0;
      }
    }

    for (var data in widget.newTableData) {
      if (data['KINGAK'] != null) {
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

  Future<File> exportFile() async {
    var bytes = await exportImage(context);
    Uint8List imageInUnit8List = bytes!;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    return file;
  }

  _createSignatureFromImage(url)async{
    final size = MediaQuery.of(context).size;
    String imgurl = url;
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl)).buffer.asUint8List();
    image.Image? img = image.decodeImage(bytes);
    img = image.copyCrop(img!, (size.width-100)~/2, 150, (size.width-100).toInt(), 300);
    List<Point> hasDataPixels = [];
    if(img!=null) {
      for (int x = 0; x < img.width; x++) {
        for (int y = 0; y < img.height; y++) {
          int pixel = img.getPixel(x, y);
          int red = image.getRed(pixel);
          int green = image.getGreen(pixel);
          int blue = image.getBlue(pixel);
          int alpha = image.getAlpha(pixel);

          if (!(red == 255 && green == 255 && blue == 255 && alpha == 255)) {
            var offset = Offset(x.toDouble(), y.toDouble());
            hasDataPixels.add(Point(offset, PointType.tap, 0.3));
          }
        }
      }
      for(var p in hasDataPixels) {
        _controller.addPoint(p);
      }
    }
  }

  Widget sendButton2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            
            setState(() => _controller.clear());
            
            SubmitLastPage.shared.removeRegisterSignImage(
                jyucyuId: widget.jyucyuId,
                onSuccess: () {
                  print('s');
                  setState(() {
                    registeredSignature = false;
                    msgSignature = '';
                  });
                },
                onFailed: () {
                  print('f');
                  setState(() {});
                });

          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                'サインをリセット',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        GestureDetector(
          onTap: () async {
            if (_controller.isEmpty) {
              setState(() {
                msgSignature = '未入力';
              });
              return;
            }
            // Export to File
            final fileExport = await exportFile();

            setState(
              () {
                file = fileExport;
              },
            );

            SubmitLastPage.shared.uploadSignImage(
                jyucyuId: widget.jyucyuId,
                file: file!,
                onSuccess: () {
                  setState(() {
                    registeredSignature = true;
                    msgSignature = '';
                  });
                  CustomToast.show(context,
                      message: "登録出来ました。", backGround: Colors.green);
                },
                onFailed: () {
                  setState(() {
                    registeredSignature = false;
                  });
                  CustomToast.show(context,
                      message: "登録できませんでした。。", backGround: Colors.red);
                });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                'サインを確定',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Text(
          registeredSignature ? 'サイン登録済み' : 'サイン未登録',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
