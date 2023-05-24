import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:link_life_one/api/order/get_qr.dart';
import 'package:link_life_one/models/thanh_tich.dart';
import 'package:link_life_one/models/user.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../api/order/material_ordering.dart';
import '../../api/order/saibuhachuu_list/get_check_list.dart';
import '../../api/order/saibuhachuu_list/get_material_ordering_list.dart';
import '../../components/custom_header_widget.dart';
import '../../components/custom_text_field.dart';
import '../../components/login_widget.dart';
import '../../components/text_line_down.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';
import 'danh_sach_cac_bo_phan_5_1_2_page.dart';

class SaibuhacchuulistDanhSachDatHangVatLieu611Page extends StatefulWidget {
  String? SYOZOKU_CD;
  String? JISYA_CD;
  String? BUZAI_HACYU_ID;
  bool isShowPopup;

  SaibuhacchuulistDanhSachDatHangVatLieu611Page({
    this.SYOZOKU_CD,
    this.JISYA_CD,
    this.BUZAI_HACYU_ID,
    this.isShowPopup = false,
    Key? key,
  }) : super(key: key);

  @override
  State<SaibuhacchuulistDanhSachDatHangVatLieu611Page> createState() =>
      _SaibuhacchuulistDanhSachDatHangVatLieu611PageState();
}

class _SaibuhacchuulistDanhSachDatHangVatLieu611PageState
    extends State<SaibuhacchuulistDanhSachDatHangVatLieu611Page> {
  late int currentRadioRow;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isShowScandQR = false;

  bool? _isSave;
  
  List<List<TextEditingController>> textControllerNewValues = [];

  dynamic first = {
    "MAKER_NAME": "",
    "BUNRUI": '',
    "JISYA_CD": "",
    "SYOHIN_NAME": "",
    "LOT": "",
    "HACYU_TANKA": "",
    "SURYO": "",
    "TANI_CD": "",
    "KINGAK": "",
    "HINBAN": "",
    "BUZAI_HACYU_ID": "",
    "BUZAI_HACYUMSAI_ID": "",
    "status": false,
  };
  List<dynamic> saibuList = [];
  List<dynamic> newRecords = [];

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentRadioRow = -1;
    if(widget.isShowPopup){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSavePopup();
      });
    }
    else{
      if (widget.JISYA_CD != null && widget.SYOZOKU_CD != null) {
        call2ApiGetList(
          syozokuCd: widget.SYOZOKU_CD!,
          jisyaCd: widget.JISYA_CD
        );
      } else {}
    }
  }

  _showSavePopup(){
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: CupertinoAlertDialog(
            content: const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "前回編集途中のリストがあります。",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    final box = Hive.box<User>('userBox');
                    final User user = box.values.last;
                    call2ApiGetList(
                      syozokuCd: user.TANT_CD,
                    );
                    Navigator.pop(context);
                    setState(() {
                      _isSave = true;
                    });
                  },
                  child: const Text(
                    '続きから編集する',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  '破棄して新規リスト作成',
                  style: TextStyle(
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
  }

  toJson(element, {bool hasStatus = true, bool nullId = false}){
    return hasStatus
      ? {
        "MAKER_NAME": element["MAKER_NAME"] ?? '',
        "BUNRUI": element["BUNRUI"] ?? element["BUZAI_BUNRUI"] ?? '',
        "HINBAN": element["HINBAN"] ?? '',
        "SYOHIN_NAME": element["SYOHIN_NAME"] ?? '',
        "LOT": element["LOT"] ?? '',
        "HACYU_TANKA": element["HACYU_TANKA"] ?? element["SIIRE_TANKA"] ?? '',
        "TANI_CD": element["TANI_CD"] ?? element["TANI"] ?? '',
        "JISYA_CD": element["JISYA_CD"] ?? '',
        "SURYO": element["SURYO"] ?? '',
        "KINGAK": element["KINGAK"] ?? '',
        "BUZAI_HACYU_ID": nullId ? '' : element["BUZAI_HACYU_ID"] ?? '',
        "BUZAI_HACYUMSAI_ID": nullId ? '' : element["BUZAI_HACYUMSAI_ID"] ?? '',
        "status": false,
      }
      : {
        "MAKER_NAME": element["MAKER_NAME"] ?? '',
        "BUNRUI": element["BUNRUI"] ?? element["BUZAI_BUNRUI"] ?? '',
        "HINBAN": element["HINBAN"] ?? '',
        "SYOHIN_NAME": element["SYOHIN_NAME"] ?? '',
        "LOT": element["LOT"] ?? '',
        "HACYU_TANKA": element["HACYU_TANKA"] ?? element["SIIRE_TANKA"] ?? '',
        "TANI_CD": element["TANI_CD"] ?? element["TANI"] ?? '',
        "JISYA_CD": element["JISYA_CD"] ?? '',
        "SURYO": element["SURYO"] ?? '',
        "KINGAK": element["KINGAK"] ?? '',
        "BUZAI_HACYU_ID": nullId ? '' : element["BUZAI_HACYU_ID"] ?? '',
        "BUZAI_HACYUMSAI_ID": nullId ? '' : element["BUZAI_HACYUMSAI_ID"] ?? ''
      };
  }

  Future<dynamic> call2ApiGetList({
    required String syozokuCd,
    String? jisyaCd
  }) async {
    final dynamic result = await GetMaterialOrderingList().getMaterialOrderingList(
            SYOZOKU_CD: syozokuCd,
            JISYA_CD: jisyaCd,
            onSuccess: (data) {
              if (data.isEmpty && saibuList.isEmpty) {
                setState(() {});
              } else {
                List<dynamic> tmpList = [];
                for (var element in data) {
                  var itemConvert = toJson(element);
                  tmpList.add(itemConvert);
                }

                setState(() {
                  saibuList.addAll(tmpList);
                });

                if (widget.BUZAI_HACYU_ID != null) {
                  callGetCheckList((res) {
                    if (res.isEmpty && saibuList.isEmpty) {
                      setState(() {});
                    } else {
                      List<dynamic> tmpCheckList = [];
                      for (var element in res) {
                        var itemConvert = toJson(element);
                        tmpCheckList.add(itemConvert);
                      }
                      setState(() {
                        saibuList.addAll(tmpCheckList);
                      });
                    }
                  });
                }
              }
            },
            onFailed: () {
              CustomToast.show(context, message: "データを取得出来ませんでした。");
            });
  }

  Future<dynamic> callGetCheckList(Function(List<dynamic>) onSccess) async {
    final dynamic result = await GetCheckList().getCheckList(
        BUZAI_HACYU_ID: widget.BUZAI_HACYU_ID!,
        onSuccess: (data) {
          onSccess.call(data);
        },
        onFailed: () {
          CustomToast.show(context, message: "データを取得出来ませんでした。");
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false, // this is new
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          reverse: true, // this is new
          // physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 16,
              right: 16,
              left: 16,
            ),
            child: Container(
              height: size.height,
              child: Column(
                children: [
                  header(),
                  title(),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (widget.SYOZOKU_CD!=null && widget.JISYA_CD!=null) || (_isSave ?? false)
                                  ? _buildRows(saibuList.length + 1)
                                  : _buildRows(saibuList.length + 1)+_emptyRow(newRecords.length+1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '発注却下品番・理由 / コメント',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextField(
                    isReadOnly: true,
                    showCursor: false,
                    fillColor: const Color(0xFFA5A7A9),
                    hint: 'テキストテキストテキスト',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isShowScandQR
                      ? Container(
                          height: 300.h,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: QRView(
                                  key: qrKey,
                                  onQRViewCreated: (controller) {
                                    this.controller = controller;
                                    controller.scannedDataStream.listen((scanData) {
                                      String code = (scanData.code!).split(';')[1];
                                      print('code: $code');
                                      GetQR().getQrApi(
                                        code: code,
                                        onSuccess: (data) {
                                          print(data);
                                          if (data.isNotEmpty) {
                                            List<dynamic> mtp = [];

                                            for (var item in data) {
                                              var itemConvert = toJson(item, nullId: true);
                                              mtp.add(itemConvert);
                                            }
                                            setState(() {
                                              // list;
                                              saibuList.addAll(mtp);
                                            });
                                          }
                                          else{
                                            CustomToast.show(
                                                context,
                                                message: 'QRコードのデータが存在しないため、データ取得できません。',
                                                backGround: Colors.grey
                                            );
                                          }
                                        },
                                        onFailed: () {
                                          CustomToast.show(context,
                                              message: "データを取得出来ませんでした。");
                                        }
                                      );
                                      setState(() {
                                        result = scanData;
                                        isShowScandQR = false;
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA1A1A1),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isShowScandQR = true;
                            });
                          },
                          child: const Text(
                            'QR読取',
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
                        width: 5,
                      ),
                      Container(
                        width: 140,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA1A1A1),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DanhSachCacBoPhan512Page(
                                  onAdd: (data) {
                                    List<dynamic> tmp = [];
                                    for(var d in data){
                                      tmp.add(toJson(d, nullId: true));
                                    }
                                    setState(() {
                                      saibuList.addAll(tmp);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'リストから選択',
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
                        width: 5,
                      ),
                      Container(
                        width: 100,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFA6366),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            List<dynamic> list = (saibuList+newRecords)
                                .where((element) => element["status"] == true)
                                .toList();

                            if (list.isEmpty) {
                              CustomToast.show(context,
                                  message: "一つを選択してください。",
                                  backGround: Colors.yellow);
                            } else {
                              await MaterialOrdering().postUpdateMaterialOrdering(
                                  addUpdateList: [],
                                  removeList: list.map((e) => toJson(e, hasStatus: false)).toList(),
                                  onSuccess: () {
                                    setState(() {
                                      saibuList.removeWhere(
                                              (element) => element["status"] == true);
                                      newRecords.removeWhere(
                                              (element) => element["status"] == true);
                                    });
                                    CustomToast.show(
                                      context,
                                      message: "登録出来ました。",
                                      backGround: Colors.green,
                                    );
                                  },
                                  onFailed: () {
                                    CustomToast.show(context,
                                        message: "登録できませんでした。。");
                                  }
                              );
                            }
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
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 140,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFFA1A1A1),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () {
                            List<dynamic> list = (saibuList+newRecords)
                                .where((element) => element["status"] == true)
                                .toList();

                            if (list.isEmpty) {
                              CustomToast.show(context,
                                  message: "一つを選択してください。",
                                  backGround: Colors.yellow);
                            } else {
                              List<dynamic> list2 = [];

                              for (var element in list) {
                                dynamic first = toJson(element, nullId: true);
                                list2.add(first);
                              }

                              setState(() {
                                newRecords.addAll(list2);
                              });
                            }
                          },
                          child: const Text(
                            'リスト複製',
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
                  Expanded(child: Container()),
                  Container(
                    width: 120,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D8FDB),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if(await _showConfirmDialog()){
                          List<dynamic> list = [];
                          list = (saibuList+newRecords).where((element) => element["status"] == true).toList();
                          if (list.isEmpty) {
                            CustomToast.show(
                                context,
                                message: "一つを選択してください。",
                                backGround: Colors.yellow
                            );
                          }
                          else{
                            await MaterialOrdering().postUpdateMaterialOrdering(
                              addUpdateList: list.map((e) => toJson(e, hasStatus: false)).toList(),
                              removeList: [],
                              onSuccess: () {
                                CustomToast.show(
                                  context,
                                  message: "登録出来ました。",
                                  backGround: Colors.green,
                                );
                              },
                              onFailed: () {
                                CustomToast.show(context,
                                    message: "登録できませんでした。。");
                              }
                            );
                          }
                        }
                      },
                      child: const Text(
                        '発注申請',
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
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showConfirmDialog() async {
    bool isConfirm = false;
    await showDialog(
      context: context,
      builder: (context) {
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
                "発注申請を実行します。\nよろしいでしょうか。",
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
                    isConfirm = true;
                    Navigator.pop(context);
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
                  isConfirm = false;
                  Navigator.pop(context);
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

    return isConfirm;
  }

  Widget header() {
    return const CustomHeaderWidget();
  }

  Widget title() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 247, 240, 240))),
        width: 200,
        child: CustomButton(
          color: Colors.white70,
          onClick: () {},
          name: '部材発注リスト',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget contentTable(int col, int row) {
    if (col == 0) {
      return Checkbox(
        activeColor: Colors.blue,
        checkColor: Colors.white,
        value: saibuList[row - 1]["status"],
        onChanged: (newValue) {
          setState(() {
            saibuList[row - 1]["status"] = newValue ?? false;
          });
        },
      );
    }

    if (row != 0 && col != 0) {
      String value = '';
      saibuList;

      if (col == 1) {
        value = saibuList[row - 1]["MAKER_NAME"] ?? '';
      }
      if (col == 2) {
        value = saibuList[row - 1]["BUNRUI"] ?? '';
      }
      if (col == 3) {
        value = saibuList[row - 1]["HINBAN"] ?? '';
      }
      if (col == 4) {
        value = saibuList[row - 1]["SYOHIN_NAME"] ?? '';
      }
      if (col == 5) {
        value = saibuList[row - 1]["LOT"] ?? '';
      }
      if (col == 6) {
        value = saibuList[row - 1]["HACYU_TANKA"] ?? '';
      }

      if (col == 7) {
        return Row(
          children: [
            Expanded(child: Center(child: Text(saibuList[row - 1]["SURYO"] ?? ''))),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.black,
                    width: 0.7,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7, left: 7),
              child: _moreButton(context, row),
            ),
          ],
        );
      }
      if (col == 8) {
        value = saibuList[row - 1]["TANI_CD"] ?? '';
      }
      if (col == 9) {
        value = saibuList[row - 1]["KINGAK"] ?? '';
      }

      return Text(
        value,
        style: TextStyle(color: Colors.black),
      );
    }

    return const Text(
      '',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _moreButton(BuildContext context, int row) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) =>
          List.generate(99, (index) => index + 1).map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              saibuList[row - 1]["SURYO"] = item.toString();
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
      offset: const Offset(-25, -10),
      child: Image.asset(
        Assets.icDropdown,
      ),
    );
  }

  Widget _moreButtonForNewRecords(BuildContext context, int row) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) =>
          List.generate(99, (index) => index + 1).map((item) {
            return PopupMenuItem(
              onTap: () {
                setState(() {
                  newRecords[row]["SURYO"] = item.toString();
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
      offset: const Offset(-25, -10),
      child: Image.asset(
        Assets.icDropdown,
      ),
    );
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      'メーカ',
      '分類',
      '品番',
      '商品名',
      'LOT',
      '発注 単価',
      '数量',
      '単位',
      '合計',
    ];

    List<double> colwidth = [
      30,
      130,
      130,
      100,
      150,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
    ];
    return List.generate(count, (col) {
      if (row == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFFFF9900),
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 80,
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
        height: 50,
        child: contentTable(col, row),
      );
    });
  }

  List<Widget> _emptyRow(int rowCounts) {
    List<double> colwidth = [
      30,
      130,
      130,
      100,
      150,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
      100,
    ];
    return List.generate(rowCounts, (row) => Row(
      children: List.generate(10, (col) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 50,
          child: Builder(builder: (context) {
            if(row<newRecords.length  && row>=textControllerNewValues.length){
              textControllerNewValues.add(List.generate(10, (index) {
                if(index==1) return TextEditingController(text: newRecords[row]['MAKER_NAME']);
                if(index==2) return TextEditingController(text: newRecords[row]['BUNRUI']);
                if(index==3) return TextEditingController(text: newRecords[row]['HINBAN']);
                if(index==4) return TextEditingController(text: newRecords[row]['SYOHIN_NAME']);
                if(index==5) return TextEditingController(text: newRecords[row]['LOT']);
                if(index==6) return TextEditingController(text: newRecords[row]['HACYU_TANKA']);
                if(index==8) return TextEditingController(text: newRecords[row]['TANI_CD']);
                if(index==9) return TextEditingController(text: newRecords[row]['KINGAK']);
                return TextEditingController();
              }));
            }
            switch(col){
              case 0:
                return row<newRecords.length
                  ? Checkbox(
                    key: Key('$row'),
                    activeColor: Colors.blue,
                    checkColor: Colors.white,
                    value: newRecords[row]["status"],
                    onChanged: (newValue) {
                      setState(() {
                        newRecords[row]["status"] = newValue ?? false;
                      });
                    },
                  )
                  : Container();
              case 7:
                return row<newRecords.length
                  ? Row(
                  children: [
                    Expanded(child: Center(child: Text(newRecords[row]["SURYO"] ?? ''))),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.black,
                            width: 0.7,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 7, left: 7),
                      child: _moreButtonForNewRecords(context, row),
                    ),
                  ],
                )
                : Container();
              default: return TextField(
                controller: row>=textControllerNewValues.length ? null : textControllerNewValues[row][col],
                textAlign: TextAlign.center,
                onTap: (){
                  if(row==newRecords.length){
                    setState(() {
                      newRecords.add(toJson(first));
                    });
                  }
                },
                onChanged: (value){
                  switch(col){
                    case 1:
                      setState(() {
                        newRecords[row]['MAKER_NAME'] = value;
                      });
                      break;
                    case 2:
                      setState(() {
                        newRecords[row]['BUNRUI'] = value;
                      });
                      break;
                    case 3:
                      setState(() {
                        newRecords[row]['HINBAN'] = value;
                      });
                      break;
                    case 4:
                      setState(() {
                        newRecords[row]['SYOHIN_NAME'] = value;
                      });
                      break;
                    case 5:
                      setState(() {
                        newRecords[row]['LOT'] = value;
                      });
                      break;
                    case 6:
                      setState(() {
                        newRecords[row]['HACYU_TANKA'] = value;
                      });
                      break;
                    case 8:
                      setState(() {
                        newRecords[row]['TANI_CD'] = value;
                      });
                      break;
                    case 9:
                      setState(() {
                        newRecords[row]['KINGAK'] = value;
                      });
                      break;
                  }
                },
              );
            }
          }),
        );
      }),
    ));
  }

  List<Widget> _buildRows(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(10, index),
      );
    });
  }
}
