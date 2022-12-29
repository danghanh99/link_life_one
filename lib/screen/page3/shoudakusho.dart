import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../api/shoudakusho/submit_last_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShoudakuSho extends StatefulWidget {
  final DateTime? initialDate;
  final List<dynamic> DATA_TABLE;
  final String SINGLE_SUMMARIZE;
  final String JYUCYU_ID;
  const ShoudakuSho({
    super.key,
    this.initialDate,
    required this.DATA_TABLE,
    required this.SINGLE_SUMMARIZE,
    required this.JYUCYU_ID,
  });

  @override
  State<ShoudakuSho> createState() => _ShoudakuShoState();
}

class _ShoudakuShoState extends State<ShoudakuSho> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 4,
    penColor: Colors.blue,
    exportBackgroundColor: Colors.blue,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  File? file;
  late bool checkedValue1;
  late bool checkedValue2;
  late bool checkedValue3;
  late bool checkedValue4;
  late bool checkedValue5;
  late bool checkedValue6;
  late bool checkedValue7;
  late bool checkedValue8;

  @override
  void initState() {
    checkedValue1 = false;
    checkedValue2 = false;
    checkedValue3 = false;
    checkedValue4 = false;
    checkedValue5 = false;
    checkedValue6 = false;
    checkedValue7 = false;
    checkedValue8 = false;
    file = null;
    _controller.addListener(() => log('Value changed'));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  Future<Uint8List?> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return null;
    }

    final Uint8List? data =
        await _controller.toPngBytes(height: 1000, width: 1000);
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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: size.width - 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
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
                                                  fontWeight: FontWeight.w700),
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
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        child: Signature(
                                          key: const Key('signature'),
                                          controller: _controller,
                                          height: 150,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            SubmitLastPage().submitLastPage(
              SINGLE_SUMMARIZE: widget.SINGLE_SUMMARIZE,
              JYUCYU_ID: widget.JYUCYU_ID,
              CHECK_FLG1: checkedValue1 ? "1" : "0",
              CHECK_FLG2: checkedValue2 ? "1" : "0",
              CHECK_FLG3: checkedValue3 ? "1" : "0",
              CHECK_FLG4: checkedValue4 ? "1" : "0",
              CHECK_FLG5: checkedValue5 ? "1" : "0",
              CHECK_FLG6: checkedValue6 ? "1" : "0",
              CHECK_FLG7: checkedValue7 ? "1" : "0",
              list: widget.DATA_TABLE,
              onSuccess: () {
                CustomToast.show(context,
                    message: "登録出来ました。", backGround: Colors.green);
              },
              onFailed: () {
                CustomToast.show(
                  context,
                  message: "登録できませんでした。。",
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 150,
            child: const Center(
              child: Text(
                '登録',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<File> exportFile() async {
    var bytes = await exportImage(context);
    Uint8List imageInUnit8List = bytes!;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    return file;
  }

  Widget sendButton2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _controller.clear());
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
            // Export to File
            final fileExport = await exportFile();

            // Export to Image
            var bytes = await exportImage(context);
            var y = Image.memory(bytes!);
            setState(
              () {
                file = fileExport;
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                'サインを登録',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
