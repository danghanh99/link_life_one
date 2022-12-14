import 'package:flutter/material.dart';
import 'package:link_life_one/api/order/saubulist/get_part_list.dart';
import 'package:link_life_one/api/order/saubulist/get_pull_down_category.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/page5/page_5_3_danh_sach_nhan_lai_vat_lieu.dart';

import '../../components/custom_header_widget.dart';
import '../../components/custom_text_field.dart';
import '../../components/login_widget.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';

class DanhSachCacBoPhan512Page extends StatefulWidget {
  final Function(List<dynamic>) onAdd;
  const DanhSachCacBoPhan512Page({
    required this.onAdd,
    Key? key,
  }) : super(key: key);

  @override
  State<DanhSachCacBoPhan512Page> createState() =>
      _DanhSachCacBoPhan512PageState();
}

class _DanhSachCacBoPhan512PageState extends State<DanhSachCacBoPhan512Page> {
  late int currentRadioRow;

  List<dynamic> saibuList = [];

  List<dynamic> listPullDown = [];

  String pulldownCategory = 'カテゴリを選択';

  @override
  void initState() {
    currentRadioRow = -1;

    super.initState();
    callGetPartList();
    callGetPullDownCategory();
  }

  Future<dynamic> callGetPartList() async {
    final dynamic result = await GetPartList().getPartList(onSuccess: (data) {
      for (var element in data) {
        element["status"] = false;
      }

      setState(() {
        saibuList.addAll(data);
      });
    }, onFailed: () {
      CustomToast.show(context, message: "データを取得出来ませんでした。");
    });
  }

  Future<dynamic> callGetPullDownCategory() async {
    final dynamic result =
        await GetPullDownCategory().getPullDownCategory(onSuccess: (data) {
      setState(() {
        listPullDown.addAll(data);
      });
    }, onFailed: () {
      CustomToast.show(context, message: "データを取得出来ませんでした。");
    });
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
          children: [
            header(),
            title(),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // color: const Color(0xFFA5A7A9),
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
                        text: '分類',
                      ),
                      columnText(
                        width: size.width / 2 - 30,
                        text: '品番',
                      ),
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
                      ),
                      columnText(
                        width: size.width / 2 - 30,
                        text: '商品名',
                      ),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRows(saibuList.length + 1),
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
                      Navigator.pop(context);
                      List<dynamic> listSelected = saibuList
                          .where((element) => element["status"] == true)
                          .toList();
                      for (var element in listSelected) {
                        element["status"] = false;
                      }
                      widget.onAdd.call(listSelected);
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
    double width,
  ) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {}
        if (number == 2) {}
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listPullDown.map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              if (pulldownCategory == item["KBNMSAI_NAME"]) {
                pulldownCategory = 'カテゴリを選択';
              } else {
                pulldownCategory = item["KBNMSAI_NAME"];
              }
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
                      item["KBNMSAI_NAME"].toString(),
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
                pulldownCategory,
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
          name: '部材リスト',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
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
        _dropDownButton(context, width ?? 30),
      ],
    );
  }

  Widget columnText({
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
        SizedBox(
          width: width ?? 30,
          child: CustomTextField(
            fillColor: color,
            hint: hint ?? '',
            type: TextInputType.emailAddress,
            onChanged: (text) {},
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget contentTable(int col, int row) {
    if (row != 0 && col != 0) {
      String value = '';

      if (col == 1) {
        value = saibuList[row - 1]["BUZAI_HACYUMSAI_ID"] ?? '';
      }
      if (col == 2) {
        value = saibuList[row - 1]["BUNRUI"] ?? '';
      }
      if (col == 3) {
        value = saibuList[row - 1]["MAKER_NAME"] ?? '';
      }
      if (col == 4) {
        value = saibuList[row - 1]["HINBAN"] ?? '';
      }
      if (col == 5) {
        value = saibuList[row - 1]["SYOHIN_NAME"] ?? '';
      }
      if (col == 6) {
        value = saibuList[row - 1]["SURYO"] ?? '';
      }

      return Text(
        value,
        style: const TextStyle(color: Colors.black),
      );
    }

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
    return const Text(
      '',
      style: TextStyle(color: Colors.black),
    );
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      '部材 管理番号',
      '分類',
      'メーカー',
      '品番',
      '商品名',
      '実数量',
    ];

    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                30,
                130,
                130,
                100,
                100,
                130,
                130,
              ]
            : [
                30,
                (size.width - 33) * 2 / 7 + -30,
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
