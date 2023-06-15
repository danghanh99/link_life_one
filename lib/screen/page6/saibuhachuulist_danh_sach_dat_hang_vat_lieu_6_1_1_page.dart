import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/material/material_api.dart';
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

  String? buzaiHacyuId;
  bool fromMenu;

  SaibuhacchuulistDanhSachDatHangVatLieu611Page({
    this.buzaiHacyuId,
    required this.fromMenu,
    Key? key,
  }) : super(key: key);

  @override
  State<SaibuhacchuulistDanhSachDatHangVatLieu611Page> createState() =>
      _SaibuhacchuulistDanhSachDatHangVatLieu611PageState();
}

class _SaibuhacchuulistDanhSachDatHangVatLieu611PageState
    extends State<SaibuhacchuulistDanhSachDatHangVatLieu611Page> {
  late int currentRadioRow;

  final TextEditingController _noteController = TextEditingController();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isShowScandQR = false;
  
  List<List<TextEditingController>> textControllerNewValues = [];

  bool? isEmptyList;

  dynamic first = {
    "MAKER_NAME": "",
    "BUNRUI": '',
    "KBNMSAI_NAME": '',
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
    if(controller!=null){
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
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
    if(widget.fromMenu){
      getMaterialOrderingListSave();
    }
    else if(widget.buzaiHacyuId != null){
      getCheckList(buzaiHacyuId: widget.buzaiHacyuId!);
    }
  }

  toJson(element, {bool hasStatus = true, bool nullId = false}){
    return hasStatus
      ? {
        "MAKER_CD": element["MAKER_CD"] ?? '',
        "MAKER_NAME": element["MAKER_NAME"] ?? '',
        "BUNRUI": element["BUNRUI"] ?? element["BUZAI_BUNRUI"] ?? '',
        "KBNMSAI_NAME": element["KBNMSAI_NAME"] ?? '',
        "HINBAN": element["HINBAN"] ?? '',
        "SYOHIN_NAME": element["SYOHIN_NAME"] ?? '',
        "LOT": element["LOT"] ?? '',
        "HACYU_TANKA": element["HACYU_TANKA"] ?? element["SIIRE_TANKA"] ?? '',
        "TANI_CD": element["TANI"] ?? element["TANI_CD"] ?? '',
        "JISYA_CD": element["JISYA_CD"] ?? '',
        "SURYO": element["SURYO"] ?? '',
        "KINGAK": element["KINGAK"] ?? '',
        "BUZAI_HACYU_ID": nullId ? '' : element["BUZAI_HACYU_ID"] ?? '',
        "BUZAI_HACYUMSAI_ID": nullId ? '' : element["BUZAI_HACYUMSAI_ID"] ?? '',
        "status": false,
      }
      : {
        "MAKER_CD": element["MAKER_CD"] ?? '',
        "MAKER_NAME": element["MAKER_NAME"] ?? '',
        "BUNRUI": element["BUNRUI"] ?? element["BUZAI_BUNRUI"] ?? '',
        "KBNMSAI_NAME": element["KBNMSAI_NAME"] ?? '',
        "HINBAN": element["HINBAN"] ?? '',
        "SYOHIN_NAME": element["SYOHIN_NAME"] ?? '',
        "LOT": element["LOT"] ?? '',
        "HACYU_TANKA": element["HACYU_TANKA"] ?? element["SIIRE_TANKA"] ?? '',
        "TANI_CD": element["TANI"] ?? element["TANI_CD"] ?? '',
        "JISYA_CD": element["JISYA_CD"] ?? '',
        "SURYO": element["SURYO"] ?? '',
        "KINGAK": element["KINGAK"] ?? '',
        "BUZAI_HACYU_ID": nullId ? '' : element["BUZAI_HACYU_ID"] ?? '',
        "BUZAI_HACYUMSAI_ID": nullId ? '' : element["BUZAI_HACYUMSAI_ID"] ?? ''
      };
  }

  isEmptyElement(e){
    if (e['MAKER_NAME'].toString().trim().isNotEmpty) return false;
    if (e['BUNRUI'].toString().trim().isNotEmpty) return false;
    if (e['KBNMSAI_NAME'].toString().trim().isNotEmpty) return false;
    if (e['HINBAN'].toString().trim().isNotEmpty) return false;
    if (e['SYOHIN_NAME'].toString().trim().isNotEmpty) return false;
    if (e['LOT'].toString().trim().isNotEmpty) return false;
    if (e['HACYU_TANKA'].toString().trim().isNotEmpty) return false;
    if (e['SURYO'].toString().trim().isNotEmpty) return false;
    if (e['TANI_CD'].toString().trim().isNotEmpty) return false;
    if (e['KINGAK'].toString().trim().isNotEmpty) return false;
    return true;
  }

  Future<dynamic> getMaterialOrderingListSave() async {
    await MaterialOrderingList().getMaterialOrderingList(
        onStart: (){
          setState(() {
            isEmptyList = null;
          });
        },
        onSuccess: (data) {
          if (data.isEmpty) {
            setState(() {
              isEmptyList = true;
            });
          } else {

            saibuList.clear();
            List<dynamic> tmpList = [];
            for (var element in data) {
              var itemConvert = toJson(element);
              tmpList.add(itemConvert);
            }
            setState(() {
              saibuList.addAll(tmpList);
              isEmptyList = false;
            });

          }
        },
        onFailed: () {
          setState(() {
            isEmptyList = true;
          });
          CustomToast.show(context, message: "データを取得出来ませんでした。");
        });
  }

  Future<dynamic> getCheckList({required String buzaiHacyuId}) async {

    saibuList.clear();

    await callGetCheckList((res) {
      if (res.isEmpty) {
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

  Future<dynamic> callGetCheckList(Function(List<dynamic>) onSccess) async {
    await GetCheckList().getCheckList(
        BUZAI_HACYU_ID: widget.buzaiHacyuId ?? '',
        onStart: (){
          setState(() {
            isEmptyList = null;
          });
        },
        onSuccess: (data) {
          _noteController.text = '${data[0]['HACNG_RIYU']}'.toLowerCase()=='null' ? '' : data[0]['HACNG_RIYU'] ?? '';
          onSccess.call(data);
          if(data.isEmpty){
            setState(() {
              isEmptyList = true;
            });
          }
          else{
            setState(() {
              isEmptyList = false;
            });
          }
        },
        onFailed: () {
          setState(() {
            isEmptyList = true;
          });
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
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          ..._buildRows(1, 0),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (widget.buzaiHacyuId!=null || widget.fromMenu
                                  ? _buildRows(saibuList.length, 1)
                                  : _buildRows(saibuList.length, 1) + _emptyRow(newRecords.length)) + [
                                  Visibility(
                                    visible: (isEmptyList == null || isEmptyList!) && (widget.fromMenu || widget.buzaiHacyuId!=null) && (saibuList + newRecords).isEmpty,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: Center(child: Text(isEmptyList == null ? Assets.gettingMessage : Assets.emptyMessage),),
                                    ),
                                  )
                                ],
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
                    controller: _noteController,
                    // isReadOnly: true,
                    // showCursor: false,
                    // fillColor: const Color(0xFFA5A7A9),
                    // hint: 'テキストテキストテキスト',
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
                                              if(saibuList.where((element) => element['HINBAN']==itemConvert['HINBAN'] && element['JISYA_CD']==itemConvert['JISYA_CD']).isEmpty) {
                                                mtp.add(itemConvert);
                                              }
                                            }
                                            setState(() {
                                              saibuList.addAll(mtp);
                                              if(saibuList.isEmpty){
                                                isEmptyList = true;
                                              }
                                              else{
                                                isEmptyList = false;
                                              }
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
                              isShowScandQR = !isShowScandQR;
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
                                      if(saibuList.isEmpty){
                                        isEmptyList = true;
                                      }
                                      else{
                                        isEmptyList = false;
                                      }
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
                              if(widget.fromMenu){
                                await MaterialOrdering().postUpdateMaterialOrdering(
                                    addUpdateList: [],
                                    removeSaveList: list.map((e) => toJson(e, hasStatus: false)).toList(),
                                    removeBuzaiList: [],
                                    hacngRiyu: _noteController.text,
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
                              else if(widget.buzaiHacyuId!=null){
                                await MaterialOrdering().postUpdateMaterialOrdering(
                                    addUpdateList: [],
                                    removeSaveList: [],
                                    removeBuzaiList: list.map((e) => toJson(e, hasStatus: false)).toList(),
                                    hacngRiyu: _noteController.text,
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
                              else{
                                setState(() {
                                  saibuList.removeWhere(
                                          (element) => element["status"] == true);
                                  newRecords.removeWhere(
                                          (element) => element["status"] == true);
                                });
                              }
                            }

                            setState(() {
                              if(saibuList.isEmpty){
                                isEmptyList = true;
                              }
                              else{
                                isEmptyList = false;
                              }
                            });
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
                      const Spacer(),
                      Container(
                        width: 120,
                        height: 37,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6D8FDB),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            List<dynamic> list = (saibuList+newRecords).where((element) => element["status"] == true).toList();
                            if(list.where((element) => '${element['SURYO']}'.isEmpty || element['SURYO'] == '0').isNotEmpty) {
                              CustomToast.show(
                                  context,
                                  message: "数量を入力して下さい",
                                  backGround: Colors.yellow
                              );
                              return;
                            }
                            if(await _showConfirmDialog()){
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
                                    removeSaveList: [],
                                    removeBuzaiList: [],
                                    hacngRiyu: _noteController.text,
                                    onSuccess: () {
                                      CustomToast.show(
                                        context,
                                        message: "登録出来ました。",
                                        backGround: Colors.green,
                                      );
                                      Navigator.pop(context);
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
                    ],
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
    return CustomHeaderWidget(
      onBack: () {
        if((saibuList+newRecords).isNotEmpty){
          showDialog(
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: CupertinoAlertDialog(
                  content: const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "編集途中のリストを保存しますか？",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () async {

                          List list = [];

                          for(var l in (saibuList+newRecords)){
                            if(!isEmptyElement(l)){
                              list.add(l);
                            }
                          }

                          await MaterialAPI.shared.postAddBuzaihacyumsaiSave(
                              items: list,
                              onSuccess: (){},
                              onFailed: (){}
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'はい',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'いいえ',
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
        else{
          Navigator.pop(context);
        }
      },
    );
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
        value = saibuList[row - 1]["KBNMSAI_NAME"] ?? '';
      }
      if (col == 3) {
        value = saibuList[row - 1]["HINBAN"] ?? saibuList[row - 1]["JISYA_CD"] ?? '';
      }
      if (col == 4) {
        value = saibuList[row - 1]["SYOHIN_NAME"] ?? '';
      }
      if (col == 5) {
        value = saibuList[row - 1]["LOT"] ?? '';
      }
      if (col == 6) {
        value = saibuList[row - 1]["HACYU_TANKA"] ?? '0';
        value  = NumberFormat('###,###').format(int.tryParse(value) ?? 0);
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
        value = saibuList[row - 1]["KINGAK"] ?? '0';
        value  = NumberFormat('###,###').format(int.tryParse(value) ?? 0);
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
              saibuList[row - 1]["KINGAK"] = '${int.parse('$item') * int.parse(saibuList[row -1 ]["HACYU_TANKA"] ?? '0')}';
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
                  newRecords[row]["KINGAK"] = '${int.parse('$item') * int.parse(newRecords[row]["HACYU_TANKA"] ?? '1')}';
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
                if(index==2) return TextEditingController(text: newRecords[row]['KBNMSAI_NAME']);
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
                        newRecords[row]['KBNMSAI_NAME'] = value;
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

  List<Widget> _buildRows(int count, int start) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(10, start + index),
      );
    });
  }
}
