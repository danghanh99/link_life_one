import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_life_one/api/material/material_api.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/models/material_take_back_model.dart';
import 'package:link_life_one/shared/colors.dart';

import '../../components/custom_header_widget.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';

class Page53DanhSachNhanLaiVatLieu extends StatefulWidget {
  const Page53DanhSachNhanLaiVatLieu({
    Key? key,
  }) : super(key: key);

  @override
  State<Page53DanhSachNhanLaiVatLieu> createState() =>
      _Page53DanhSachNhanLaiVatLieuState();
}

class _Page53DanhSachNhanLaiVatLieuState
    extends State<Page53DanhSachNhanLaiVatLieu> {
  late int currentRadioRow;
  List<MaterialTakeBackModel> materials = [];
  Map<String, TextEditingController> textControllers = {};

  @override
  void initState() {
    currentRadioRow = -1;
    getMaterialTakeBack();
    super.initState();
  }

  void getMaterialTakeBack() {
    MaterialAPI.shared.getListDefaultMaterialTakeBack(
      onStart: (){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomToast.show(context,
              message: '読み込み中です。', backGround: Colors.grey);
        });
      },
      onSuccess: (materials) {
        setState(() {
          this.materials = materials;
        });
        if(materials.isEmpty){
          CustomToast.show(
              context,
              message: 'データがありません。'
          );
        }
        // CustomToast.show(context,
        //     message: 'データを取得できました。', backGround: Colors.green);
      },
      onFailed: () {
        CustomToast.show(context, message: 'データを取得できません。');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          children: _buildRows(materials.length + 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            Container(
              width: 120,
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFF6D8FDB),
                borderRadius: BorderRadius.circular(26),
              ),
              child: TextButton(
                onPressed: () {
                  if (currentRadioRow < 1) {
                    return;
                  }
                  MaterialTakeBackModel material =
                      materials.elementAt(currentRadioRow - 1);
                  print('suryo: ${textControllers[material.jisyaCode]!.text}');
                  MaterialAPI.shared.insertMaterialTakeBackById(
                      syukkoId: material.syukkoId ?? '',
                      suryo: int.tryParse(textControllers[material.jisyaCode]!.text),//int.tryParse(material.suryo ?? '0') ?? 0,
                      onSuccess: (result) {
                        CustomToast.show(context,
                            message: '画面で選択した項目を登録できました。',
                            backGround: Colors.green);
                      },
                      onFailed: () {
                        CustomToast.show(context,
                            message: '画面で選択した項目を登録できません。');
                      });
                },
                child: const Text(
                  '在庫に戻す',
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
          name: '部材持ち戻りリスト',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

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
      '持ち出し数量',
      '持ち戻り数量'
    ];

    Size size = MediaQuery.of(context).size;
    List<double> colwidth = [
      30,
      (size.width - 33) * 2 / 7 - 30,
      (size.width - 33) / 7,
      (size.width - 33) / 7,
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
        alignment: col==1 || col==2 || col==3 || col==4 ? Alignment.centerLeft : Alignment.center,
        width: colwidth[col],
        height: 50,
        child: contentTable(col, row),
      );
    });
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

  Widget contentTable(int col, int row) {
    if (col == 6) {
      MaterialTakeBackModel material = materials.elementAt(row - 1);
      TextEditingController? textController =
          textControllers[material.jisyaCode];
      if (textController == null) {
        // textController = TextEditingController(text: material.suryo ?? '');
        textController = TextEditingController();
        textControllers[material.jisyaCode ?? ''] = textController;
      }
      OutlineInputBorder borderOutline = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: AppColors.BORDER, width: 1),
      );
      return Container(
        height: 80,
        alignment: Alignment.center,
        child: Center(
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
                // hintText: '0',
                contentPadding: EdgeInsets.zero,
                enabledBorder: borderOutline,
                focusedBorder: borderOutline,
                disabledBorder: borderOutline),
            textAlign: TextAlign.center,
            onChanged: (text) {
              // materials.elementAt(row - 1).suryo = text;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              // for below version 2 use this
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              // for version 2 and greater youcan also use this
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLines: 1,
          ),
        ),
      );
    }

    return col == 0
        ? RadioListTile(
            value: row,
            groupValue: currentRadioRow,
            onChanged: (e) {
              if (row <= materials.length) {
                setState(() {
                  currentRadioRow = row;
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
    MaterialTakeBackModel material = materials.elementAt(row - 1);
    switch (column) {
      case 1:
        return material.ctgoryName ?? '';
      case 2:
        return material.makerName ?? '';
      case 3:
        return material.jisyaCode ?? '';
      case 4:
        return material.syohinName ?? '';
      case 5:
        return material.suryo ?? '';
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
}
