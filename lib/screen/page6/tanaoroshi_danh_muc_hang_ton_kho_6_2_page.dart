import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link_life_one/api/inventory/QR_api.dart';
import 'package:link_life_one/api/inventory/get_inventories_api.dart';
import 'package:link_life_one/api/inventory/inventory_api.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/models/inventory.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../components/custom_header_widget.dart';
import '../../components/custom_text_field.dart';
import '../../components/login_widget.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';
import 'inventories/danh_sach_cac_bo_phan_5_1_3_page.dart';

class TanaoroshiDanhMucHangTonKho62Page extends StatefulWidget {
  final bool isContinue;
  const TanaoroshiDanhMucHangTonKho62Page({
    required this.isContinue,
    Key? key,
  }) : super(key: key);

  @override
  State<TanaoroshiDanhMucHangTonKho62Page> createState() =>
      _TanaoroshiDanhMucHangTonKho62PageState();
}

class _TanaoroshiDanhMucHangTonKho62PageState
    extends State<TanaoroshiDanhMucHangTonKho62Page> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isShowScandQR = false;
  late int currentRadioRow;

  bool? isEmptyList;

  List<Inventory> listInventory = [];

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
    currentRadioRow = -1;
    if(!widget.isContinue){
      InventoryAPI.shared.postTanamsaiSaveDelete(
          onSuccess: (){},
          onFailed: (){}
      );
    }
    getListInventory();
    super.initState();
  }

  Future<void> getListInventory() async {
    await GetInventoriesApi().getInventories(
        isContinue: widget.isContinue,
        onStart: (){
          setState(() {
            isEmptyList = null;
          });
        },
        onSuccess: (list) {
          setState(
            () {
              listInventory = list;
            },
          );
          if(list.isEmpty){
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
          CustomToast.show(context, message: 'データを取得出来ませんでした。');
        });
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      '部材 管理番号',
      '分類',
      'メーカー',
      '品番',
      '商品名',
      '先月 実在庫',
      '出庫数量',
      '発注数量',
      '単価',
      '当月 実在庫',
      '当月在庫額',
    ];

    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
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
              ]
            : [
                30,
                2 * (size.width - 33) / 12 - 30,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
                (size.width - 33) / 12,
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
          color: listInventory.isEmpty
              ? Colors.white
              : (listInventory[row - 1].haibanFlg == '1'
                  ? Colors.grey
                  : Colors.white),
        ),
        alignment: Alignment.center,
        width: colwidth[col],
        height: 50,
        child: contentTable(col, row),
      );
    });
  }

  List<Widget> _buildRows(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(12, index),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 16,
          right: 16,
          left: 16,
        ),
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
            listInventory.isNotEmpty
                ? Expanded(
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
                                children: _buildRows(listInventory.length + 1),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: _buildRows(listInventory.length + 1),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Visibility(
                            visible: isEmptyList == null || isEmptyList!,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Center(child: Text(isEmptyList == null ? Assets.gettingMessage : Assets.emptyMessage),),
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
                          builder: (context) => DanhSachCacBoPhan513Page(
                            back: (List<Inventory> a) {
                              setState(() {
                                List<String?> hinbans = listInventory.map((e) => e.hinban).toList();
                                for(Inventory i in a){
                                  if(!hinbans.contains(i.hinban)){
                                    listInventory.add(i);
                                  }
                                }
                                if(listInventory.isEmpty){
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

                      List removeItems = listInventory.where((element) => element.STATUS && element.isFromDatabase).toList();
                      await GetInventoriesApi().removeInventory(
                          removeItems: removeItems,
                          onSuccess: () {
                            setState(() {
                              for(var i in listInventory.where((e) => e.STATUS == true).toList()){
                                listInventory.removeAt(listInventory.indexOf(i));
                              }
                              if(listInventory.isEmpty){
                                isEmptyList = true;
                              }
                              else{
                                isEmptyList = false;
                              }
                            });
                            CustomToast.show(context,
                                message: '選択した項目を削除できました。', backGround: Colors.green);
                          },
                          onFailed: () {
                            CustomToast.show(context, message: 'データを取得出来ませんでした。');
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
                const Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      InventoryAPI.shared.postInventoryWithoutSaved(
                        isContinue: widget.isContinue,
                        INVENTORY_DETAIL: listInventory
                            .where((element) => element.STATUS == true)
                            .toList(),
                        onSuccess: () {
                          CustomToast.show(context,
                              message: '登録出来ました。', backGround: Colors.green);
                        },
                        onFailed: () {
                          CustomToast.show(
                            context,
                            message: '登録できませんでした。。',
                          );
                        }
                      );
                      setState(() {
                        listInventory = listInventory.map((e) {
                          e.STATUS = false;
                          return e;
                        }).toList();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '棚卸確定',
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
            isShowScandQR
                ? Container(
                    height: 300,
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
                                setState(() {
                                  result = scanData;
                                  isShowScandQR = false;
                                });
                                QRApi().getQRApi(
                                  hinban: code,
                                  onSuccess: (api) {
                                    setState(() {
                                      listInventory.addAll(api);
                                      if(listInventory.isEmpty){
                                        isEmptyList = true;
                                      }
                                      else{
                                        isEmptyList = false;
                                      }
                                    });
                                  },
                                  onFailed: () {
                                    CustomToast.show(context, message: 'エーラ');
                                  }
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return CustomHeaderWidget(
      onBack: (){
        showDialog(
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
                    "編集途中のリストを保存しますか？",
                    style: TextStyle(
                      color: Color.fromARGB(255, 24, 23, 23),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: () async {
                        await InventoryAPI.shared.postInventoryListMaterialList(
                            items: listInventory,
                            onSuccess: (){},
                            onFailed: (){}
                        );
                        Navigator.pop(context);
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
                      Navigator.pop(context);
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
          name: '棚卸リスト',
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
    if (col == 1) {
      return Text(
          listInventory.isEmpty ? '' : listInventory[row - 1].buzaiKanriGoban!);
    }
    if (col == 2) {
      return Text(listInventory.isEmpty ? '' : listInventory[row - 1].kbnmsaiName!);
    }
    if (col == 3) {
      return Text(listInventory.isEmpty ? '' : listInventory[row - 1].meekaa!);
    }
    if (col == 4) {
      return Text(listInventory.isEmpty ? '' : listInventory[row - 1].hinban!);
    }
    if (col == 5) {
      return SingleChildScrollView(
        child: Text(
            listInventory.isEmpty ? '' : listInventory[row - 1].shohinmei!),
      );
    }
    if (col == 6) {
      return Text(listInventory.isEmpty
          ? ''
          : '${listInventory[row - 1].tougetsuJitsuZaiko}');
    }
    if (col == 7) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].shukkoSuuryou ?? '0'));
    }
    if (col == 8) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].hacchuuSuuryou ?? '0'));
    }
    if (col == 9) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].genka ?? '').toString());
    }
    if (col == 10) {
      return Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Text(listInventory.isNotEmpty
              ? listInventory[row - 1].jissu.toString()
              : 0.toString()),
          const Spacer(),
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

    if (col == 11) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].tanka ??
                  1 * (listInventory[row - 1].tougetsuJitsuZaiko ?? 0))
              .toString());
    }

    if (col == 0) {
      if (listInventory[row - 1].haibanFlg == '1') {
        return Container();
      }
      return Checkbox(
        activeColor: Colors.blue,
        checkColor: Colors.white,
        value: listInventory[row - 1].STATUS,
        onChanged: (newValue) {
          setState(() {
            listInventory[row - 1].STATUS = newValue ?? false;
          });
        },
      );
    }

    return Container();
  }

  Widget _moreButton(BuildContext context, int row) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => List.generate(99, (i) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              listInventory[row - 1].tougetsuJitsuZaiko = (i + 1);
            });
          },
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: i + 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 14,
              ),
              Text(
                (i + 1).toString(),
              ),
            ],
          ),
        );
      }),
      offset: const Offset(-25, -10),
      child: Image.asset(
        Assets.icDropdown,
      ),
    );
  }
}
