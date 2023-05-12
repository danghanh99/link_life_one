import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link_life_one/api/material/material_api.dart';
import 'package:link_life_one/models/default_inventory.dart';
import 'package:link_life_one/models/material_model.dart';
import 'package:link_life_one/screen/page5/page_5_2_1_danh_sach_ton_kho.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../components/custom_header_widget.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';

class Page52DanhSachNguyenLieu extends StatefulWidget {
  const Page52DanhSachNguyenLieu({
    Key? key,
  }) : super(key: key);

  @override
  State<Page52DanhSachNguyenLieu> createState() =>
      _Page52DanhSachNguyenLieuState();
}

class _Page52DanhSachNguyenLieuState extends State<Page52DanhSachNguyenLieu> {

  List<bool> checkboxsState = [];

  List<MaterialModel> materials = [];
  Map<String, TextEditingController> textControllers = {};
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  bool isShowScandQR = false;

  // List<Widget> _buildCells(int count) {
  //   return List.generate(
  //     count,
  //     (index) => Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(),
  //         color: Colors.black,
  //       ),
  //       alignment: Alignment.center,
  //       width: 50,
  //       height: 50,
  //       // color: Colors.white,
  //       margin: const EdgeInsets.all(1.0),
  //       child: Text(
  //         "col ${index + 1}",
  //         style: const TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      'カテゴリ',
      'メーカー',
      '自社コード',
      '商品名',
      '在庫 数量',
      '持ち出し数量',
    ];

    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                40,
                130,
                130,
                100,
                240,
                100,
                160,
              ]
            : [
                40,
                (size.width - 33) * 2 / 7 + -40,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
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
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: col == 1 || col == 2 || col == 3 || col == 4
            ? Alignment.centerLeft
            : Alignment.center,
        width: colwidth[col],
        height: 50,
        child: contentTable(col, row),
      );
    });
  }

  Widget _moreButton(BuildContext context, int jussu, Function(int) onChange) {
    List<PopupMenuEntry<int>> widgets = [];

    for (var i = 1; i <= jussu; i++) {
      widgets.add(PopupMenuItem(
        height: 25,
        padding: const EdgeInsets.only(right: 0, left: 10),
        value: i,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 14,
            ),
            Text('$i'),
          ],
        ),
      ));
      if (i < jussu) {
        widgets.add(const PopupMenuDivider());
      }
    }

    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        onChange(number);
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => widgets,
      offset: const Offset(-25, -10),
      child: Image.asset(
        Assets.icDropdown,
      ),
    );
  }

  Widget contentTable(int col, int row) {
    if (col == 6) {
      return Row(
        children: [
          Expanded(
            child: Center(
              child: Text('${materials[row - 1].suryo}'),
            ),
          ),
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
            child: _moreButton(context, int.tryParse(valueFrom(5, row)) ?? 0,
                (number) {
              print('number: $number');
              setState(() {
                materials[row - 1].suryo = '$number';
              });
            }),
          ),
        ],
      );
    }
    // if (col == 6) {
    //   MaterialModel material = materials.elementAt(row - 1);
    //   TextEditingController? textController =
    //       textControllers[material.jisyaCode];
    //   if (textController == null) {
    //     textController = TextEditingController(text: material.suryo ?? '');
    //     textControllers[material.syukkoId ?? material.jisyaCode ?? ''] =
    //         textController;
    //   }
    //   // textController.text = material.suryo ?? '0';
    //   OutlineInputBorder borderOutline = const OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(0)),
    //     borderSide: BorderSide(color: AppColors.BORDER, width: 1),
    //   );
    //   return Container(
    //     height: 80,
    //     alignment: Alignment.center,
    //     child: Center(
    //       child: TextField(
    //         controller: textController,
    //         decoration: InputDecoration(
    //             hintText: '0',
    //             contentPadding: EdgeInsets.zero,
    //             enabledBorder: borderOutline,
    //             focusedBorder: borderOutline,
    //             disabledBorder: borderOutline),
    //         textAlign: TextAlign.center,
    //         onChanged: (text) {
    //           materials.elementAt(row - 1).suryo = text;
    //         },
    //         keyboardType: TextInputType.number,
    //         inputFormatters: [
    //           // for below version 2 use this
    //           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    //           // for version 2 and greater youcan also use this
    //           FilteringTextInputFormatter.digitsOnly,
    //         ],
    //         maxLines: 1,
    //       ),
    //     ),
    //   );
    // }
    return col == 0
        ? Checkbox(
          activeColor: Colors.blue,
          checkColor: Colors.white,
          value: checkboxsState[row - 1],
          onChanged: (newValue) {
            setState(() {
              checkboxsState[row - 1] = newValue ?? false;
            });
          },
        )
        : Text(
            valueFrom(col, row),
            style: const TextStyle(color: Colors.black),
          );
  }

  String valueFrom(int column, int row) {
    MaterialModel material = materials.elementAt(row - 1);
    switch (column) {
      case 1:
        return material.ctgoryName ?? '';
      case 2:
        return material.makerName ?? '';
      case 3:
        return material.jisyaCode ?? '';
      case 4:
        return material.syoshinName ?? '';
      case 5:
        return material.jissu ?? '';
      default:
        return '';
    }
  }

  List<Widget> _buildRows(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(7, index),
      );
    });
  }

  void checkSave() {

    FToast? gettingToast;

    MaterialAPI.shared.checkSave(onStart: () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        CustomToast.show(
            context,
            onShow: (toast){
              gettingToast = toast;
            },
            message: '読み込み中です。', backGround: Colors.grey
        );
      });
    }, onSuccess: (showPopUp) {

      if(gettingToast!=null) gettingToast!.removeCustomToast();

      if (showPopUp) {
        showDialog(
          context: context,
          builder: (dialogContext) {
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
                        Navigator.pop(dialogContext);
                        getEditMaterial(showPopUp);
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
                      Navigator.pop(dialogContext); //close Dialog
                      // deleteMaterial();
                      deleteExistSave();
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
      } else {}
    }, onSuccessList: (listMaterials) {

      if(gettingToast!=null) gettingToast!.removeCustomToast();

      setState(() {
        materials = listMaterials;
        checkboxsState.clear();
        for(var m in materials) {
          checkboxsState.add(false);
        }
      });
      if (listMaterials.isEmpty) {
        CustomToast.show(context, message: 'データがありません。');
      }
      // CustomToast.show(context,
      //     message: '保存したデータを確認できました。', backGround: Colors.green);
    }, onFailed: () {

      if(gettingToast!=null) gettingToast!.removeCustomToast();

      CustomToast.show(context, message: '保存したデータを確認できません。');
    });
  }

  void reloadList() {
    MaterialAPI.shared.checkSave(
      onSuccess: (showPopUp) {},
      onSuccessList: (listMaterials) {
        setState(() {
          materials = listMaterials;
          checkboxsState.clear();
          for(var m in materials) {
            checkboxsState.add(false);
          }
        });
      },
      onFailed: () {
        CustomToast.show(context, message: '保存したデータを確認できません。');
      }
    );
  }

  void deleteMaterial() {
    MaterialAPI.shared.deleteListMaterial(onSuccess: (message) {
      CustomToast.show(context,
          message: '保存したリストを削除できました。', backGround: Colors.green);
    }, onFailed: () {
      CustomToast.show(context, message: '保存したリストを削除できません。');
    });
  }

  void deleteExistSave() {
    MaterialAPI.shared.deleteExistSave(onSuccess: (message) {
      // CustomToast.show(context,
      //     message: '保存したリストを削除できました。', backGround: Colors.green);
    }, onFailed: () {
      // CustomToast.show(context, message: '保存したリストを削除できません。');
    });
  }

  void deleteMaterialItem(MaterialModel item) {
    MaterialAPI.shared.deleteMaterialById(
        syukkoId: item.syukkoId ?? '',
        onSuccess: (message) {
          CustomToast.show(context,
              message: '選択した項目を削除できました。', backGround: Colors.green);
        },
        onFailed: () {
          CustomToast.show(context, message: '選択した項目を削除できません。');
        });
  }

  void getDataQRById(String zaikoId) {
    MaterialAPI.shared.getDataQRById(
        zaikoId: zaikoId,
        onSuccess: (result) {

          if(result.isEmpty){
            CustomToast.show(
                context,
                message: 'QRコードのデータが存在しないため、データ取得できません。',
                backGround: Colors.grey
            );
          }
          else{
            List<MaterialModel> materialList = result.map((e) => MaterialModel.fromDefaultInventory(e)).toList();

            setState(() {
              materials.addAll(materialList);
              checkboxsState.clear();
              for(var m in materials) {
                checkboxsState.add(false);
              }
            });
            CustomToast.show(
              context,
              message: 'QRコードからデータを取得できました。', backGround: Colors.green
            );
          }
        },
        onFailed: () {
          CustomToast.show(context, message: 'QRコードからデータを取得できません。');
        });
  }

  void getEditMaterial(bool showPopup) {
    MaterialAPI.shared.getListDefaultFromEditMaterial(
        showPopup: showPopup,
        onSuccess: (result) {
          setState(() {
            materials = result;
            checkboxsState.clear();
            for(var m in materials) {
              checkboxsState.add(false);
            }
          });
          CustomToast.show(context,
              message: 'データを取得できました。', backGround: Colors.green);
        },
        onFailed: () {
          CustomToast.show(context, message: 'データを取得できません。');
        });
  }

  void registerMaterialItem(List<MaterialModel> items) {
    MaterialAPI.shared.registerMaterialItem(
        items: items,
        onSuccess: (message) {
          reloadList();
          CustomToast.show(context,
              message: '選択した項目を登録できました。', backGround: Colors.green);
        },
        onFailed: () {
          CustomToast.show(context, message: '選択した項目を登録できません。');
        });
  }

  void showAlertEmptyQuantity() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SizedBox(
          width: double.infinity,
          child: CupertinoAlertDialog(
            content: const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '持ち出し数量が0の商品があります。',
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
                  Navigator.pop(dialogContext);
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
  }

  @override
  void initState() {
    checkSave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 35,
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
                          children: _buildRows(materials.length + 1),
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
            isShowScandQR
                ? SizedBox(
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
                                getDataQRById(code);
                                setState(() {
                                  result = scanData;
                                  isShowScandQR = false;
                                });
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
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
                    onPressed: () async {
                      MaterialModel? material = await Navigator.push(
                      // DefaultInventory? inventory = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Page521DanhSachTonKho(),
                        ),
                      );
                      if (material == null) {
                      // if (inventory == null) {
                        return;
                      }
                      bool existed = false;
                      for (var element in materials) {
                        if (element.jisyaCode!=null && material.jisyaCode!=null && element.jisyaCode == material.jisyaCode) {
                        // if (element.jisyaCode == inventory.jisyaCode) {
                          setState(() {
                            element.suryo = '${int.parse(element.suryo??'0')+int.parse(material.suryo??'0')}';
                          });
                          existed = true;
                        }
                      }
                      if (!existed) {
                        setState(() {
                          materials.add(material);
                          checkboxsState.clear();
                          for (var m in materials) {
                            checkboxsState.add(false);
                          }
                          // materials.add(MaterialModel.fromDefaultInventory(inventory));
                        });
                      }
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
                    color: !checkboxsState.contains(true)
                        ? const Color(0xFFA1A1A1)
                        : const Color(0xFFFA6366),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: !checkboxsState.contains(true)
                        ? null
                        : () {
                            for(int i = 0; i<checkboxsState.length; i++){
                              if(checkboxsState[i]) {
                                if (materials[i].syukkoId != null) {
                                  deleteMaterialItem(materials[i]);
                                  materials.removeAt(i);
                                }
                              }
                            }
                            checkboxsState.clear();
                            for (var m in materials) {
                              checkboxsState.add(false);
                            }
                            setState(() {});
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
                Expanded(child: Container()),
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      _saveData(false);
                    },
                    child: const Text(
                      '持ち出し登録',
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
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      ),
    );
  }

  _saveData(isBack) {
    if (checkboxsState.contains(true)) {

      List<MaterialModel> selectedMaterials = [];

      bool hasAnyEmptyMaterial = false;
      for(int i=0; i<checkboxsState.length; i++){
        if(checkboxsState[i]){
          int quantity = 0;
          String text = materials[i].suryo ?? '0';
          if (text.isEmpty) {
            quantity = 0;
          } else {
            quantity = int.parse(text);
          }

          if (quantity == 0) {
            if (!isBack) {
              hasAnyEmptyMaterial = true;
            }
          } else {
            selectedMaterials.add(materials[i]);
          }
        }
      }

      if(hasAnyEmptyMaterial){
        showAlertEmptyQuantity();
      }
      else{
        registerMaterialItem(selectedMaterials);
      }

    } else {
      if (!isBack) CustomToast.show(context, message: "一つを選択してください。");
    }
  }

  // Widget _dropDownButton(BuildContext context, String value) {
  //   return PopupMenuButton<int>(
  //     color: Colors.white,
  //     padding: EdgeInsets.zero,
  //     onSelected: (number) {
  //       if (number == 1) {}
  //       if (number == 2) {}
  //     },
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(12.0))),
  //     itemBuilder: (context) => [
  //       PopupMenuItem(
  //         height: 25,
  //         padding: const EdgeInsets.only(right: 0, left: 10),
  //         value: 1,
  //         child: Row(
  //           children: const [
  //             SizedBox(
  //               width: 14,
  //             ),
  //             Text(
  //               "投函数を選択",
  //             ),
  //           ],
  //         ),
  //       ),
  //       const PopupMenuDivider(),
  //       PopupMenuItem(
  //         height: 25,
  //         padding: const EdgeInsets.only(right: 0, left: 10),
  //         value: 2,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: const [
  //             SizedBox(
  //               width: 14,
  //             ),
  //             Text(
  //               "投函数を選択",
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //     offset: const Offset(-35, -90),
  //     child: Container(
  //       width: 130,
  //       height: 30,
  //       decoration: BoxDecoration(
  //         color: const Color(0xFFF5F6F8),
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Text(
  //             value,
  //             style: const TextStyle(
  //               color: Color(0xFF999999),
  //               fontSize: 14,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           Image.asset(
  //             Assets.icDown,
  //             width: 13,
  //             height: 13,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget header() {
    return CustomHeaderWidget(onBack: () async {
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
                  "編集途中のリストを保存しますか。",
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
                      // _saveData(true);
                      MaterialAPI.shared.onBackMaterial(
                          items: materials,
                          onSuccess: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          onFailed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                    },
                    child: const Text(
                      'はい',
                      style: TextStyle(
                        color: Color(0xFFEB5757),
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
    });
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
          name: '部材持ち出しリスト',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // Widget _moreButton(BuildContext context) {
  //   return PopupMenuButton<int>(
  //     color: Colors.white,
  //     padding: EdgeInsets.zero,
  //     onSelected: (number) {
  //       if (number == 1) {
  //         // Navigator.of(context).push(MaterialPageRoute(
  //         //     builder: (context) => EditThemePage(
  //         //           index: index,
  //         //           meditationThemeDTO: meditationThemeDTO,
  //         //         )));
  //       }
  //       if (number == 2) {}
  //     },
  //     shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(12.0))),
  //     itemBuilder: (context) => [
  //       PopupMenuItem(
  //         height: 25,
  //         padding: const EdgeInsets.only(right: 0, left: 10),
  //         value: 1,
  //         child: Row(
  //           children: const [
  //             SizedBox(
  //               width: 14,
  //             ),
  //             Text(
  //               "Dropdown item",
  //             ),
  //           ],
  //         ),
  //       ),
  //       const PopupMenuDivider(),
  //       PopupMenuItem(
  //         height: 25,
  //         padding: const EdgeInsets.only(right: 0, left: 10),
  //         value: 2,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: const [
  //             SizedBox(
  //               width: 14,
  //             ),
  //             Text(
  //               "Dropdown item",
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //     offset: const Offset(-25, -10),
  //     child: Image.asset(
  //       Assets.icDropdown,
  //     ),
  //   );
  // }
}
