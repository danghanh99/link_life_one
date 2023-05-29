import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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
  List<bool> checkboxState = [];
  List<int> amountState = [];

  @override
  void initState() {
    getMaterialTakeBack();
    super.initState();
  }

  void getMaterialTakeBack({bool isFirstTime = true}) async {
    FToast? gettingToast;
    MaterialAPI.shared.getListDefaultMaterialTakeBack(
      onStart: (){
        if(isFirstTime) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            CustomToast.show(
                context,
                onShow: (toast){
                  gettingToast = toast;
                },
                message: '読み込み中です。', backGround: Colors.grey
            );
          });
        }
      },
      onSuccess: (materials) {

        if(gettingToast!=null && isFirstTime) gettingToast!.removeCustomToast();

        setState(() {
          checkboxState.clear();
          amountState.clear();
          this.materials = materials;
          for(var m in this.materials){
            checkboxState.add(false);
            amountState.add(0);
          }
        });
        if(materials.isEmpty && isFirstTime){
          CustomToast.show(
              context,
              message: 'データはありません。'
          );
        }

      },
      onFailed: () {
        if(gettingToast!=null && isFirstTime) {
          gettingToast!.removeCustomToast();
          CustomToast.show(context, message: 'データを取得できません。');
        }
    }
    );
  }

  void searchMaterialTakeBack({required String date, bool isFirstTime = true}) async {
    FToast? gettingToast;
    MaterialAPI.shared.getSearchListMaterial(
        searchDate: date,
        onStart: (){
          if(isFirstTime){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              CustomToast.show(
                  context,
                  onShow: (toast){
                    gettingToast = toast;
                  },
                  message: '読み込み中です。', backGround: Colors.grey
              );
            });
          }
        },
        onSuccess: (materials) {
          if(gettingToast!=null && isFirstTime) gettingToast!.removeCustomToast();

          setState(() {
            checkboxState.clear();
            amountState.clear();
            this.materials = materials;
            for(var m in this.materials){
              checkboxState.add(false);
              amountState.add(0);
            }
          });
          if(materials.isEmpty && isFirstTime){
            CustomToast.show(
                context,
                message: 'データがありません。'
            );
          }
        },
        onFailed: () {
          if(gettingToast!=null && isFirstTime) {
            gettingToast!.removeCustomToast();
            CustomToast.show(context, message: 'データを取得できません。');
          }
        },
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
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1)
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(16.0),
                        hintText: DateFormat('yyyy-MM-dd').format(DateTime.now())
                      ),
                      onTap: (){
                        DateTime? picked;
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1990, 3, 5),
                            maxTime: DateTime(2200, 6, 7),
                            onChanged: (datePick) {}, onConfirm: (datePick) {
                              picked = datePick;
                              if (picked != null) {
                                setState(() {
                                  dateSearchController.text = DateFormat('yyyy-MM-dd').format(picked!);
                                });
                              }
                            }, currentTime: DateTime.now(), locale: LocaleType.jp);
                      },
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
                      if(dateSearchController.text.isEmpty){
                        getMaterialTakeBack(isFirstTime: false);
                      }
                      else if(isDate(dateSearchController.text, 'yyyy-MM-dd')){
                        searchMaterialTakeBack(date: dateSearchController.text);
                      }
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
                      selectedMaterials.add(materials[i]);
                      returnSus.add(amountState[i]);
                    }
                  }

                  MaterialAPI.shared.insertMaterialTakeBackById(
                      items: selectedMaterials,
                      returnSus: returnSus,
                      onSuccess: (result) {
                        if(dateSearchController.text.isEmpty){
                          getMaterialTakeBack(isFirstTime: false);
                        }
                        else if(isDate(dateSearchController.text, 'yyyy-MM-dd')){
                          searchMaterialTakeBack(
                            date: dateSearchController.text,
                            isFirstTime: false
                          );
                        }
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

  bool isDate(String input, String format) {
    try {
      final DateTime d = DateFormat(format).parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
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
        height: isValidate && checkboxState[row-1] ? 100 : 70,
        child: contentTable(col, row),
      );
    });
  }

  Widget _moreButton(BuildContext context, int number, Function(int) onChange) {
    List<PopupMenuEntry<int>> widgets = [];

    for (var i = 1; i <= number; i++) {
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
      if (i < number) {
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
              child: Text('${amountState[row - 1]}'),
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
                    amountState[row - 1] = number;
                  });
                }),
          ),
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
