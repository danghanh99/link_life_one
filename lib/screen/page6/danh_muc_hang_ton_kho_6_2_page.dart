import 'dart:io';
import 'package:flutter/material.dart';
import 'package:link_life_one/api/inventory/QR_api.dart';
import 'package:link_life_one/api/inventory/create_or_edit_api.dart';
import 'package:link_life_one/api/inventory/get_inventories_api.dart';
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

class DanhMucHangTonKho62Page extends StatefulWidget {
  final bool isContinue;
  const DanhMucHangTonKho62Page({
    required this.isContinue,
    Key? key,
  }) : super(key: key);

  @override
  State<DanhMucHangTonKho62Page> createState() =>
      _DanhMucHangTonKho62PageState();
}

class _DanhMucHangTonKho62PageState extends State<DanhMucHangTonKho62Page> {
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
    getListInventory();
    super.initState();
  }

  Future<void> getListInventory() async {
    await GetInventoriesApi().getInventories(
        isContinue: widget.isContinue,
        onSuccess: (list) {
          setState(
            () {
              listInventory = list;
            },
          );
        },
        onFailed: () {
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
          color: Colors.white,
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
                                listInventory.addAll(a);
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
                    onPressed: () {},
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
                      CreateOrEditApi().createOrEditInventory(
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
                          });
                      setState(() {
                        listInventory = listInventory.map((e) {
                          e.STATUS = false;
                          return e;
                        }).toList();
                      });
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
                                setState(() {
                                  result = scanData;
                                  isShowScandQR = false;
                                });
                                QRApi().getQRApi(onSuccess: (api) {
                                  setState(() {
                                    listInventory.add(api);
                                  });
                                }, onFailed: () {
                                  CustomToast.show(context, message: 'エーラ');
                                });
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
      return Text(listInventory.isEmpty ? '' : listInventory[row - 1].bunrui!);
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
          : (listInventory[row - 1].sengetsuJitsuZaiko ?? '0'));
    }
    if (col == 7) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].shukkoSuuryou ?? ''));
    }
    if (col == 8) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].hacchuuSuuryou ?? ''));
    }
    if (col == 9) {
      return Text(listInventory.isEmpty
          ? ''
          : (listInventory[row - 1].tanka ?? '').toString());
    }
    if (col == 10) {
      return Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Text(listInventory.isNotEmpty
              ? listInventory[row - 1].tougetsuJitsuZaiko.toString()
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
