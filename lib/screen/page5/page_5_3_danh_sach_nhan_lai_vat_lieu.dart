import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_life_one/api/material/material_api.dart';
import 'package:link_life_one/components/custom_text_field.dart';
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

  final TextEditingController dateSearchController = TextEditingController();

  bool isValidate = false;
  List<MaterialTakeBackModel> materials = [];
  List<TextEditingController> textControllers = [];
  List<bool> checkboxState = [];

  @override
  void initState() {
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
        for(var m in materials){
          textControllers.add(TextEditingController());
        }
        setState(() {
          this.materials = materials;
          for(var m in this.materials){
            checkboxState.add(false);
          }
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
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '持ち出し日',
                  style: TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  color: Colors.red,
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      controller: dateSearchController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.all(16.0)
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 100,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {

                    },
                    child: const Text(
                      '確定',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
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
                  if (!checkboxState.contains(true)) {
                    return;
                  }

                  List<MaterialTakeBackModel> selectedMaterials = [];
                  List<int> returnSus = [];

                  for(int i = 0; i < checkboxState.length; i++){
                    if(checkboxState[i]){
                      if(textControllers[i].text.isEmpty){
                        setState(() {
                          isValidate = true;
                        });
                        return;
                      }
                      else{
                        selectedMaterials.add(materials[i]);
                        returnSus.add(int.tryParse(textControllers[i].text)??0);
                      }
                    }
                  }

                  MaterialAPI.shared.insertMaterialTakeBackById(
                      items: selectedMaterials,
                      returnSus: returnSus,
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
        height: isValidate && checkboxState[row-1] && textControllers[row-1].text.isEmpty ? 100 : 70,
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
      OutlineInputBorder borderOutline = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: AppColors.BORDER, width: 1),
      );
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: TextField(
              controller: textControllers[row-1],
              decoration: InputDecoration(
                // hintText: '0',
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                enabledBorder: borderOutline,
                focusedBorder: borderOutline,
                disabledBorder: borderOutline,
                isDense: true,
              ),
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
              onTap: (){
                setState(() {
                  isValidate = false;
                });
              },
            ),
          ),
          Visibility(
            visible: isValidate && checkboxState[row-1] && textControllers[row-1].text.isEmpty,
            child: const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                '数量を入力して下さい',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13
                ),
              ),
            )
          )
        ],
      );
    }

    return col == 0
        ? Checkbox(
          activeColor: Colors.blue,
          checkColor: Colors.white,
          value: checkboxState[row - 1],
          onChanged: (newValue) {
            setState(() {
              checkboxState[row - 1] = newValue ?? false;
            });
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
