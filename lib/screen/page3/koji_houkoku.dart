
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/models/koji_houkoku_model.dart';
import 'package:link_life_one/screen/page3/houjin_kanryousho.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/screen/page3/shoudaku_shoukisai.dart';
import 'package:link_life_one/shared/custom_button.dart';

import '../../api/koji/requestConstructionReport/get_koji_houkoku.dart';
import '../../shared/assets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/components/toast.dart';

class KojiHoukoku extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final String SINGLE_SUMMARIZE;
  final String KOJI_ST;
  final String SYUYAKU_JYUCYU_ID;
  final String HOJIN_FLG;
  final String HOMON_SBT;
  const KojiHoukoku(
      {super.key,
      this.initialDate,
      required this.JYUCYU_ID,
      required this.SINGLE_SUMMARIZE,
      required this.KOJI_ST,
      required this.SYUYAKU_JYUCYU_ID,
      required this.HOJIN_FLG,
      required this.HOMON_SBT});

  @override
  State<KojiHoukoku> createState() => _KojiHoukokuState();
}

class _KojiHoukokuState extends State<KojiHoukoku> {
  List<dynamic> listPullDown = [];
  List<KojiHoukokuModel> listKojiHoukoku = [];
  Map<int, int> listStateIndexDropdown = {};
  XFile? imageFile;
  XFile? befImage;
  XFile? aftImage;

  String? TENPO_CD = '';
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
        SYUYAKU_JYUCYU_ID: widget.SYUYAKU_JYUCYU_ID,
        onSuccess: (res) {
          if (res['DATA'] != null) {
            setState(() {
              List<dynamic> kojiListJson = res['DATA'];
              listKojiHoukoku = kojiListJson
                  .map((e) => KojiHoukokuModel.fromJson(e))
                  .toList();
            });
          }
          if (listKojiHoukoku.isNotEmpty) {
            KojiHoukokuModel firstItem = listKojiHoukoku.first;
            TENPO_CD = firstItem.tenpoCd;
          } else {
            setState(() {
              listKojiHoukoku = [KojiHoukokuModel.empty()];
            });
          }
          if (res["TENPO_CD"] != null) {
            setState(() {
              TENPO_CD = res['TENPO_CD'];
            });
          }

          List pulldownList = res['PULLDOWN'];

          if (pulldownList.isNotEmpty) {
            for (var i = 0; i < listKojiHoukoku.length; i++) {
            KojiHoukokuModel koji = listKojiHoukoku[i];
            for (var j = 0; j < pulldownList.length; j++) {
              Map<String, dynamic> pulldownItem = pulldownList[j];
              if (koji.kensetuKeitai == pulldownItem['KBNMSAI_CD']) {
                listStateIndexDropdown[i] = j;
              }
            }
            
          }
            setState(() {
              listPullDown = pulldownList;
            });
          }
        },
        onFailed: () {
          setState(() {
            listKojiHoukoku = [KojiHoukokuModel.empty()];
          });
        });
  }

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      List<XFile> files = await picker.pickMultiImage();
      if (files.isNotEmpty) {
        // TODO: Chưa biết làm gì
      }
    } catch (e) {
      print(e);
    }
  }

  void selectBeforeImage(int? index) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (index != null) {
          setState(() {
            listKojiHoukoku.elementAt(index).befSekiPhotoFilePath = file.path;
          });
        } else {
          setState(() {
            befImage = file;
          });
        }
      }
    } catch (e) {}
  }

  void selectafterImage(int? index) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (index != null) {
          setState(() {
            listKojiHoukoku.elementAt(index).aftSekoPhotoFilePath = file.path;
          });
        } else {
          setState(() {
            aftImage = file;
          });
        }
      }
    } catch (e) {}
  }

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
                        width: 200.sp,
                        child: CustomButton(
                          color: Colors.white70,
                          onClick: () {},
                          name: '工事報告',
                          textStyle: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80.sp,
                    )
                  ],
                ),
                SizedBox(
                  height: 40.sp,
                ),
                widget.SINGLE_SUMMARIZE == "0" ||
                        widget.SINGLE_SUMMARIZE == "00"
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // k gop: 1 doi tuong - gom nhieu item
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          leftSide(),
                          SizedBox(width: 20.sp),
                          rightSide(null, null),
                        ],
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis
                            .vertical, // gop lai: nhieu doi tuong - 1 doi tuong  = 1 item
                        shrinkWrap: true,
                        itemCount: listKojiHoukoku.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              leftSide1Item(index),
                              SizedBox(width: 20.sp),
                              rightSide(
                                  listKojiHoukoku.elementAt(index), index),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                          child: SizedBox(
                            height: 5.sp,
                            width: 100.w.sp,
                            child: Divider(
                              height: 2.sp,
                              color: Colors.black,
                              thickness: 2.sp,
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Divider(
                    color: Colors.black,
                    thickness: 2.sp,
                  ),
                ),
                SizedBox(
                  height: 100.sp,
                ),
                sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isNetworkPath(String path) {
    final uri = Uri.parse(path);
    return uri.scheme.startsWith('http') || uri.scheme.startsWith('ftp');
  }

  Widget rightSide(KojiHoukokuModel? item, int? index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            selectBeforeImage(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: 180.sp,
            height: 140.sp,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '施工前写真',
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Expanded(
                      child: item?.befSekiPhotoFilePath == null ||
                              item?.befSekiPhotoFilePath == ''
                          ? const SizedBox.shrink()
                          : isNetworkPath(item?.befSekiPhotoFilePath ?? '')
                              ? Image.network(item?.befSekiPhotoFilePath ?? '')
                              : Image.file(
                                  File(item?.befSekiPhotoFilePath ?? ''))),
                  // Flexible(
                  //   child: Text(
                  //     item['BEF_SEKO_PHOTO_FILEPATH'] ?? '',
                  //     style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                selectafterImage(index);
              },
              child: Container(
                alignment: Alignment.center,
                width: 180.sp,
                height: 140.sp,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '施工後写真',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Expanded(
                          child: item?.aftSekoPhotoFilePath == null ||
                                  item?.aftSekoPhotoFilePath == ''
                              ? const SizedBox.shrink()
                              : isNetworkPath(item?.aftSekoPhotoFilePath ?? '')
                                  ? Image.network(
                                      item?.aftSekoPhotoFilePath ?? '')
                                  : Image.file(
                                      File(item?.aftSekoPhotoFilePath ?? ''))),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            GestureDetector(
              onTap: () {
                selectImage();
              },
              child: Container(
                alignment: Alignment.center,
                width: 180.sp,
                height: 50.sp,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Text(
                  'その他写真を添付',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget leftSide() {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listKojiHoukoku.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '【施工商品情報】',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'メーカー: ',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: textUnderline(
                        initial: listKojiHoukoku[index].makerCd,
                        enable: false,
                        onChange: (value) {
                          setState(() {
                            listKojiHoukoku[index].makerCd = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '品番: ',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: textUnderline(
                        initial: listKojiHoukoku[index].hinban,
                        enable: false,
                        onChange: (value) {
                          setState(() {
                            listKojiHoukoku[index].hinban = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                '【既設品情報】',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'メーカー: ',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: textUnderline(
                        initial: listKojiHoukoku[index].kisetuMakerCd,
                        onChange: (value) {
                          if (listKojiHoukoku[index].kisetuMakerCd != null) {
                            setState(() {
                              listKojiHoukoku[index].kisetuMakerCd = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '品番: ',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    Expanded(
                      child: textUnderline(
                        initial: listKojiHoukoku[index].kisetuHinban ?? '',
                        onChange: (value) {
                          if (listKojiHoukoku[index].kisetuHinban != null) {
                            setState(() {
                              listKojiHoukoku[index].kisetuHinban = value;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Row(
                  children: [
                    Text(
                      '建築形態',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    _dropDownButton(context, index),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) => Padding(
          padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
          child: SizedBox(
            height: 5.sp,
            width: 100.w.sp,
            child: Divider(
              height: 2.sp,
              color: Colors.black,
              thickness: 2.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget leftSide1Item(int index) {
    return Expanded(
      // height:
      //     widget.KOJI_ST == "3" || widget.KOJI_ST == "03" ? 400.h.sp : 240.h.sp,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '【施工商品情報】',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'メーカー: ',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: textUnderline(
                    initial: listKojiHoukoku[index].makerCd,
                    enable: false,
                    onChange: (value) {
                      setState(() {
                        listKojiHoukoku[index].makerCd = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '品番: ',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: textUnderline(
                    initial: listKojiHoukoku[index].hinban,
                    enable: false,
                    onChange: (value) {
                      setState(() {
                        listKojiHoukoku[index].hinban = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          widget.KOJI_ST == "3" || widget.KOJI_ST == "03"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '【既設品情報】',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'メーカー: ',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: textUnderline(
                              initial: listKojiHoukoku[index].kisetuMaker,
                              onChange: (value) {
                                if (listKojiHoukoku[index].kisetuMaker !=
                                    null) {
                                  setState(() {
                                    listKojiHoukoku[index].kisetuMaker =
                                        value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '品番: ',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w700),
                          ),
                          Expanded(
                            child: textUnderline(
                              initial:
                                  listKojiHoukoku[index].kisetuHinban ?? '',
                              onChange: (value) {
                                if (listKojiHoukoku[index].kisetuHinban !=
                                    null) {
                                  setState(() {
                                    listKojiHoukoku[index].kisetuHinban = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                  ],
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(left: 10.sp),
            child: Row(
              children: [
                Text(
                  '建築形態',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                _dropDownButton(context, index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  width: double.infinity,
                  child: CupertinoAlertDialog(
                    title: const Text(
                      "この工事を設置不可で登録を行います。\n(元に戻せません)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "操作は必ず本部へ電話報告後に行ってください。\nまたサイボウズの設置不可アプリ登録は必ず行ってください。",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context); //close Dialog
                          },
                          child: const Text(
                            '戻る',
                            style: TextStyle(
                              color: Color(0xFFEB5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); //close Dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShashinTeishuutsuGamenPage(
                                JYUCYU_ID: widget.JYUCYU_ID,
                                HOMON_SBT: widget.HOMON_SBT,
                                initialDate: widget.initialDate,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'はい',
                          style: TextStyle(
                            color: Color(0xFF007AFF),
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
              border: Border.all(color: Colors.black, width: 1.5.sp),
            ),
            height: 50.sp,
            width: 150.sp,
            child: Center(
              child: Text(
                '設置不可',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (TENPO_CD == null) {
              CustomToast.show(context, message: "TenpoCDを取得出来ませんでした。");
            } else {
              if (widget.HOJIN_FLG == "0" ||
                  widget.HOJIN_FLG == "00" ||
                  widget.HOJIN_FLG == '') {
                // go to top
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoudakuShoukisai(
                      SINGLE_SUMMARIZE: widget.SINGLE_SUMMARIZE,
                      JYUCYU_ID: widget.JYUCYU_ID,
                      KOJI_ST: widget.KOJI_ST,
                      initialDate: widget.initialDate,
                      kojiHoukoku: listKojiHoukoku,
                    ),
                  ),
                );
              } else {
                // go to bottom
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HoujinKanryousho(
                      JYUCYU_ID: widget.JYUCYU_ID,
                      TENPO_CD: TENPO_CD!,
                      befImage: befImage,
                      aftImage: aftImage,
                    ),
                  ),
                );
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5.sp),
            ),
            height: 50.sp,
            width: 150.sp,
            child: Center(
              child: Text(
                '次へ',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textUnderline({
    required Function(String) onChange,
    bool enable = true,
    String? initial,
  }) {
    return TextFormField(
      onChanged: (value) {
        onChange.call(value);
      },
      enabled: enable,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
      initialValue: initial,
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5.sp, bottom: 5.sp),
        isDense: true,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0.sp))),
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
          height: 25.sp,
          padding: EdgeInsets.only(right: 0, left: 10.sp),
          value: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: 14.sp,
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
      offset: Offset(5.sp, 32.sp),
      child: Container(
        width: 130.sp,
        height: 30.sp,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                listPullDown.isNotEmpty && listStateIndexDropdown.isNotEmpty
                    ? listPullDown[
                            listStateIndexDropdown[indexInsideListHoukoku]!]
                        ["KBNMSAI_NAME"]
                    : '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Image.asset(
                Assets.icDown,
                width: 13.sp,
                height: 13.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
