import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/api/inventory/inventory_api.dart';
import 'package:link_life_one/components/custom_dialog.dart';
import 'package:link_life_one/models/inventory_schedule.dart';

import '../../components/custom_header_widget.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';

class Page51LichKiemKe extends StatefulWidget {
  const Page51LichKiemKe({
    Key? key,
  }) : super(key: key);

  @override
  State<Page51LichKiemKe> createState() => _Page51LichKiemKeState();
}

class _Page51LichKiemKeState extends State<Page51LichKiemKe> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];
  late int currentRadioRow;

  List<InventorySchedule> schedules = [];

  @override
  void initState() {
    currentRadioRow = -1;

    super.initState();
    getData();
  }

  Future<void> getData() async {
    InventoryAPI.shared.getListInventorySchedule(onSuccess: (result) {
      log('getListInventorySchedule onSuccess');
      setState(() {
        schedules = result;
      });
    }, onFailed: (dynamic) {
      log('getListInventorySchedule onFailed');
      CustomToast.show(context, message: 'プルダウンを取得出来ませんでした。');
    });
  }

  Future<void> updateSchedule(int id) async {
    InventoryAPI.shared.updateInventorySchedule(id, onSuccess: (dynamic) {
      log('updateInventorySchedule onSuccess');
      CustomToast.show(context, message: '登録出来ました。', backGround: Colors.green);
    }, onFailed: (dynamic) {
      log('updateInventorySchedule onFailed');
      CustomToast.show(context, message: 'プルダウンを取得出来ませんでした。');
    });
  }

  void showAlertConfirm(int nyukoId) {
    MyDialog.showCustomDialog(context, '', '入庫処理を実行します。よろしいですか？', 'はい', 'いいえ',
        () {
      updateSchedule(nyukoId);
    }, () => null);
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
              height: 35,
            ),
            Flexible(
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
                          children: _buildRows(schedules.length + 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Expanded(child: Container()),
            const SizedBox(
              height: 10,
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
                onPressed: () {
                  if (currentRadioRow > 0 &&
                      currentRadioRow <= schedules.length) {
                    InventorySchedule schedule =
                        schedules.elementAt(currentRadioRow - 1);
                    showAlertConfirm(int.parse(schedule.nyukoId ?? ''));
                  } else {
                    CustomToast.show(context, message: "一つを選択してください。");
                  }
                },
                child: const Text(
                  '入庫処理',
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
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownButton(BuildContext context, String value) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {}
        if (number == 2) {}
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => [
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 1,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "投函数を選択",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "投函数を選択",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(-35, -90),
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset(
              Assets.icDown,
              width: 13,
              height: 13,
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
          name: '入庫予定表',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.black,
        ),
        alignment: Alignment.center,
        width: 50,
        height: 50,
        // color: Colors.white,
        margin: const EdgeInsets.all(1.0),
        child: Text(
          "col ${index + 1}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      '入庫予定日',
      'カテゴリ',
      'メーカー',
      '品番',
      '商品名',
      ' 入荷 (入庫) 数量',
      '設置先氏名',
      '工事日'
    ];

    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                30,
                170,
                130,
                100,
                100,
                100,
                50,
                100,
                100,
              ]
            : [
                30,
                (size.width - 33) / 9,
                (size.width - 33) / 9,
                (size.width - 33) / 9,
                (size.width - 33) / 9,
                2 * (size.width - 33) / 9,
                0.7 * (size.width - 33) / 9,
                (size.width - 33) / 9,
                (size.width - 33) / 9,
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
        children: _buildCells2(9, index),
      );
    });
  }

  Widget contentTable(int col, int row) {
    return col == 0
        ? RadioListTile(
            value: row,
            groupValue: currentRadioRow,
            onChanged: (e) {
              if (row <= schedules.length) {
                setState(() {
                  currentRadioRow = row;
                });
              }
            },
          )
        : Text(
            valueFrom(col, row),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          );
  }

  String valueFrom(int column, int row) {
    InventorySchedule schedule = schedules.elementAt(row - 1);
    switch (column) {
      case 1:
        return schedule.nyukoYoteiYMD ?? '';
      case 2:
        return schedule.ctgoryName ?? '';
      case 3:
        return schedule.makerName ?? '';
      case 4:
        return schedule.jisyaCode ?? '';
      case 5:
        return schedule.syohinName ?? '';
      case 6:
        return schedule.suryo ?? '';
      case 7:
        return schedule.setsakiName ?? '';
      case 8:
        return schedule.kojiYMD ?? '';
      case 9:
        return schedule.nyukoYoteiYMD ?? '';
      default:
        return '';
    }
  }
}
