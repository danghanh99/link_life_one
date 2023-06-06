import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link_life_one/api/inventory/inventory_api.dart';
import 'package:link_life_one/models/default_inventory.dart';
import 'package:link_life_one/models/material_model.dart';
import 'package:link_life_one/models/member_category.dart';

import '../../components/custom_dialog.dart';
import '../../components/custom_header_widget.dart';
import '../../components/custom_text_field.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';

class Page521DanhSachTonKho extends StatefulWidget {
  const Page521DanhSachTonKho({
    Key? key,
  }) : super(key: key);

  @override
  State<Page521DanhSachTonKho> createState() => _Page521DanhSachTonKhoState();
}

class _Page521DanhSachTonKhoState extends State<Page521DanhSachTonKho> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  List<MemberCategory> members = [];
  int currentDropdownIndex = -1;
  String defaultDropDownItem = '部材カテゴリを選択';
  List<DefaultInventory> inventories = [];
  List<int> selectAmounts = [];
  final TextEditingController _jisyaCodeController = TextEditingController();
  final TextEditingController _makerNameController = TextEditingController();
  final TextEditingController _syohinNameController = TextEditingController();

  List<bool> checkBoxState = [];

  bool? isEmptyList;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    getDataDropdown();
    getInventories();
  }

  void getDataDropdown() {
    InventoryAPI.shared.getListMemberCategory(onSuccess: (members) {
      if (members.isNotEmpty) {
        setState(() {
          // currentDropdownIndex = 0;
          this.members = members;
        });
        // CustomToast.show(context,
        //     message: 'ドロップダウンリストのデータを取得できました。', backGround: Colors.green);
      }
    }, onFailed: () {
      CustomToast.show(context, message: 'ドロップダウンリストのデータを取得できません。');
    });
  }

  void getInventories(
      {String categoryCode = '',
      String makerName = '',
      String jisyaCode = '',
      String syohinName = ''}) async {

    await InventoryAPI.shared.getListDefaultInventory(
      categoryCode: categoryCode,
      makerName: makerName,
      jisyaCode: jisyaCode,
      syohinName: syohinName,
      onStart: (){
        setState(() {
          isEmptyList = null;
        });
      },
      onSuccess: (inventories) {
        selectAmounts.clear();
        checkBoxState.clear();
        setState(() {
          this.inventories = inventories;
          selectAmounts = List.generate(inventories.length, (index) => 0);
          checkBoxState = List.generate(inventories.length, (index) => false);
        });
        if(inventories.isEmpty){
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
        CustomToast.show(context, message: 'データリストを取得できません。');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(),
            title(),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFA5A7A9),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      columnText2(
                        width: size.width / 2 - 30,
                        text: '部材カテゴリ',
                      ),
                      columnText(
                          width: size.width / 2 - 30,
                          text: '自社コード',
                          textController: _jisyaCodeController),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      columnText(
                          width: size.width / 2 - 30,
                          text: 'メーカー',
                          textController: _makerNameController),
                      columnText(
                          width: size.width / 2 - 30,
                          text: '商品名',
                          textController: _syohinNameController),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      String categoryCode = currentDropdownIndex == -1 ? '' : (members[currentDropdownIndex].kbnCode ?? '');
                      String makerName = _makerNameController.text;
                      String jisyaCode = _jisyaCodeController.text;
                      String syohinName = _syohinNameController.text;
                      getInventories(
                          categoryCode: categoryCode,
                          makerName: makerName,
                          jisyaCode: jisyaCode,
                          syohinName: syohinName);
                    },
                    child: const Text(
                      '検索',
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
                    color: const Color(0xFFA1A1A1),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        currentDropdownIndex = -1;
                      });
                      _jisyaCodeController.text = '';
                      _makerNameController.text = '';
                      _syohinNameController.text = '';
                      getInventories();
                    },
                    child: const Text(
                      'クリア',
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
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _buildRows(inventories.length + 1) + [
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
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      List<MaterialModel> responseModel = [];
                      for(int i = 0; i< inventories.length; i++){
                        if(checkBoxState[i]){
                          responseModel.add(MaterialModel.fromDefaultInventoryWithSuryo(inventories[i], selectAmounts[i]));
                        }
                      }
                      if (responseModel.isNotEmpty) {
                        Navigator.pop(context, responseModel);
                      } else {
                        CustomToast.show(context, message: "一つを選択してください。");
                      }
                    },
                    child: const Text(
                      '追加',
                      style: TextStyle(
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
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownButton(
    BuildContext context,
    String value,
    double width,
  ) {
    List<PopupMenuEntry<int>> widgets = [];

    for (var i = 0; i < members.length; i++) {
      MemberCategory member = members.elementAt(i);
      widgets.add(PopupMenuItem(
        height: 25,
        padding: const EdgeInsets.only(right: 0, left: 10),
        value: i,
        child: Row(
          children: [
            const SizedBox(
              width: 14,
            ),
            Text(
              member.kbnmsaiName ?? '',
            ),
          ],
        ),
      ));
      if (i < members.length) {
        widgets.add(const PopupMenuDivider());
      }
    }

    widgets.add(PopupMenuItem(
      height: 25,
      padding: const EdgeInsets.only(right: 0, left: 10),
      value: members.length,
      child: Row(
        children: [
          const SizedBox(
            width: 14,
          ),
          Text(
            defaultDropDownItem,
          ),
        ],
      ),
    ));

    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        setState(() {
          currentDropdownIndex = number < members.length ? number : -1;
        });
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => widgets,
      offset: const Offset(-0, 50),
      child: Container(
        width: width,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                Assets.icDown,
                width: 13,
                height: 13,
              ),
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
          name: '在庫リスト',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget columnText({
    double? width,
    Color? color,
    String? hint,
    String? text,
    TextEditingController? textController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? '',
          style: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: width ?? 30,
          child: CustomTextField(
            controller: textController,
            fillColor: color,
            hint: hint ?? '',
            type: TextInputType.name,
            onChanged: (text) {},
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget columnText2({
    double? width,
    Color? color,
    String? hint,
    String? text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? '',
          style: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _dropDownButton(
            context,
            currentDropdownIndex < 0
                ? defaultDropDownItem
                : members.elementAt(currentDropdownIndex).kbnmsaiName ?? '',
            width ?? 30),
      ],
    );
  }

  Widget contentTable(int col, int row) {
    if (col == 6) {
      return Row(
        children: [
          const Text(''),
          const Spacer(),
          Expanded(
            child: Center(
              child: Text('${(row-1)>=selectAmounts.length ? '' : selectAmounts[row-1]}'),
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
            // child: _moreButton(context),
            child: _moreButton(
              context,
              int.parse(valueFrom(5, row)),
              (number){
                setState(() {
                  selectAmounts[row-1] = number;
                });
              }
            ),
          ),
        ],
      );
    }

    return col == 0
        ? Checkbox(
            value: checkBoxState[row-1],
            onChanged: (value) {
              if (row <= inventories.length) {
                setState(() {
                  checkBoxState[row-1] = value ?? false;
                });
              }
            },
          )
        : Text(
            valueFrom(col, row),
            style: const TextStyle(color: Colors.black),
          );
  }

  String valueFrom(int column, int row) {
    DefaultInventory inventory = inventories.elementAt(row - 1);
    switch (column) {
      case 1:
        return inventory.categoryName ?? '';
      case 2:
        return inventory.makerName ?? '';
      case 3:
        return inventory.jisyaCode ?? '';
      case 4:
        return inventory.syoshinName ?? '';
      case 5:
        return inventory.zaikoSu ?? '';
      default:
        return '';
    }
  }

  Widget _moreButton(BuildContext context, int jussu, Function(int) onChange) {

    List<PopupMenuEntry<int>> widgets = [];

    for (var i = 1; i <= jussu; i++) {
      widgets.add(
          PopupMenuItem(
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
          )
      );
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

  // Widget _moreButton(BuildContext context) {
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
    List<double> colwidth = [
      30,
      max(130, (size.width - 33) * 2 / 8 + -30),
      max(130, (size.width - 33) / 8),
      max(100, (size.width - 33) / 8),
      max(130, (size.width - 33) * 2 / 8),
      max(120, (size.width - 33) / 8),
      max(120, (size.width - 33) / 8),
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
        children: _buildCells2(7, index),
      );
    });
  }
}
