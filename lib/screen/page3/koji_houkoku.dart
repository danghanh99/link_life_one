import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_houkoku_page.dart';
import 'package:link_life_one/screen/page3/shoudaku_shoukisai.dart';
import 'package:link_life_one/screen/page7/component/dialog.dart';
import 'package:link_life_one/shared/custom_button.dart';

import '../../api/koji/requestConstructionReport/get_koji_houkoku.dart';
import '../../shared/assets.dart';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/koji/postPhotoSubmissionRegistration/upload_photo_api.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page3/page_3/page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import 'package:link_life_one/shared/custom_button.dart';

import '../../api/koji/getPhotoConfirm/get_shashin_kakunin.dart';

class KojiHoukoku extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final String SINGLE_SUMMARIZE;
  final String KOJI_ST;
  final String SYUYAKU_JYUCYU_ID;
  const KojiHoukoku({
    super.key,
    this.initialDate,
    required this.JYUCYU_ID,
    required this.SINGLE_SUMMARIZE,
    required this.KOJI_ST,
    required this.SYUYAKU_JYUCYU_ID,
  });

  @override
  State<KojiHoukoku> createState() => _KojiHoukokuState();
}

class _KojiHoukokuState extends State<KojiHoukoku> {
  List<dynamic> listPullDown = [];
  List<dynamic> listKojiHoukoku = [];
  List<dynamic> listStateIndexDropdown = [];
  int currentIndexPullDown = 0;
  String currentPullDownValue = '';
  XFile? imageFile;
  @override
  void initState() {
    super.initState();
    callGetKojiHoukoku();
  }

  Future<dynamic> callGetKojiHoukoku() async {
    final dynamic result = await GetKojiHoukoku().getKojiHoukoku(
        JYUCYU_ID: widget.JYUCYU_ID,
        SINGLE_SUMMARIZE: widget.SINGLE_SUMMARIZE,
        KOJI_ST: widget.KOJI_ST,
        SYUYAKU_JYUCYU_ID:
            widget.SINGLE_SUMMARIZE == "02" ? widget.SYUYAKU_JYUCYU_ID : null,
        onSuccess: (res) {
          print(res);

          if (res["PULLDOWN"] != null) {
            setState(() {
              listPullDown = res["PULLDOWN"];
              currentPullDownValue = listPullDown[0]["KBNMSAI_NAME"];
              currentIndexPullDown = 0;
            });
          }
          if (res["constructionNotReport"] != null) {
            if (res["constructionNotReport"]["SINGLE"] != null) {
              setState(() {
                listKojiHoukoku = res["constructionNotReport"]["SINGLE"];
              });
            }
            if (res["constructionNotReport"]["SUMMARIZE"] != null) {
              setState(() {
                listKojiHoukoku = res["constructionNotReport"]["SUMMARIZE"];
              });
            }
            if (listKojiHoukoku.isNotEmpty) {
              setState(() {
                List<dynamic> tmp = List<dynamic>.filled(
                    listKojiHoukoku.length, currentIndexPullDown);

                listStateIndexDropdown = tmp;
              });
            }
          } else {
            setState(() {
              listKojiHoukoku = [
                {
                  "MAKER_CD": "",
                  "HINBAN": "",
                }
              ];
              listStateIndexDropdown = [0];
            });
          }
        },
        onFailed: () {});
  }

  //  "MAKER_CD": "★弊社★オ",
  // "HINBAN": "KOJ-3318"

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                          name: '工事報告',
                          textStyle: const TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
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
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftSide(),
                    rightSide(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rightSide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 160,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '施工前写真',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '添付後サムネイルを表示',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 160,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '施工前写真',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '添付後サムネイルを表示',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const Text(
                'その他写真を添付',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget leftSide() {
    return Container(
      height: 400.h,
      width: 300.w,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listKojiHoukoku.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '【施工商品情報】',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'メーカー: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: textUnderline(
                        initial: listKojiHoukoku[index]["MAKER_CD"],
                        onChange: (value) {
                          setState(() {
                            listKojiHoukoku[index]["MAKER_CD"] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '品番: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: textUnderline(
                        initial: listKojiHoukoku[index]["HINBAN"],
                        onChange: (value) {
                          setState(() {
                            listKojiHoukoku[index]["HINBAN"] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    const Text(
                      '建築形態',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _dropDownButton(context, index),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          height: 5,
        ),
      ),
    );
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            CustomDialog.showCustomDialog(
              context: context,
              title: "",
              body: ShashinTeishuutsuHoukokuPage(
                initialDate: widget.initialDate,
                JYUCYU_ID: '',
                onSelectedImage: (file) {
                  setState(() {
                    imageFile = file;
                  });
                },
              ),
            );
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return Container(
            //       width: double.infinity,
            //       child: CupertinoAlertDialog(
            //         title: const Text(
            //           "この工事を設置不可で登録を行います。\n(元に戻せません)",
            //           style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         ),
            //         content: const Padding(
            //           padding: EdgeInsets.only(top: 15),
            //           child: Text(
            //             "操作は必ず本部へ電話報告後に行ってください。\nまたサイボウズの設置不可アプリ登録は必ず行ってください。",
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 16,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ),
            //         actions: <Widget>[
            //           TextButton(
            //               onPressed: () {
            //                 Navigator.pop(context); //close Dialog
            //               },
            //               child: const Text(
            //                 '戻る',
            //                 style: TextStyle(
            //                   color: Color(0xFFEB5757),
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w600,
            //                 ),
            //               )),
            //           TextButton(
            //             onPressed: () {
            //               Navigator.pop(context); //close Dialog
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => ShashinTeishuutsuGamenPage(
            //                     initialDate: widget.initialDate,
            //                     JYUCYU_ID: '',
            //                   ),
            //                 ),
            //               );
            //             },
            //             child: const Text(
            //               'はい',
            //               style: TextStyle(
            //                 color: Color(0xFF007AFF),
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     );
            //   },
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
                '設置不可',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoudakuShoukisai(
                  initialDate: widget.initialDate,
                ),
              ),
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
                '次へ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textUnderline({
    required Function(String) onChange,
    String? initial,
  }) {
    return TextFormField(
      onChanged: (value) {
        onChange.call(value);
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

  Widget _dropDownButton(BuildContext context, int indexInsideListHoukoku) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {}
        if (number == 2) {}
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listPullDown.map((item) {
        int index = listPullDown.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            setState(() {
              // currentPullDownValue = item["KBNMSAI_NAME"];
              // currentIndexPullDown = index;
              listStateIndexDropdown[indexInsideListHoukoku] = index;
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
                      item["KBNMSAI_NAME"],
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        );
      }).toList(),
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
                listPullDown.isNotEmpty && listStateIndexDropdown.isNotEmpty
                    ? listPullDown[
                            listStateIndexDropdown[indexInsideListHoukoku]]
                        ["KBNMSAI_NAME"]
                    : '',
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
