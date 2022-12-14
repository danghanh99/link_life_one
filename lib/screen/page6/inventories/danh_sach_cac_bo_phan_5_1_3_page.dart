import 'package:flutter/material.dart';
import 'package:link_life_one/api/inventory/get_buzai_api.dart';
import 'package:link_life_one/api/inventory/get_pulldown_api.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/models/buzai.dart';
import '../../../components/custom_header_widget.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/login_widget.dart';
import '../../../components/text_line_down.dart';
import '../../../models/inventory.dart';
import '../../../shared/assets.dart';
import '../../../shared/custom_button.dart';
import '../../menu_page/menu_page.dart';

class DanhSachCacBoPhan513Page extends StatefulWidget {
  final Function(List<Inventory>) back;
  const DanhSachCacBoPhan513Page({
    required this.back,
    Key? key,
  }) : super(key: key);

  @override
  State<DanhSachCacBoPhan513Page> createState() =>
      _DanhSachCacBoPhan513PageState();
}

class _DanhSachCacBoPhan513PageState extends State<DanhSachCacBoPhan513Page> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  List<Buzai> listBuzai = [];
  List<Buzai> tmp = [];

  List<dynamic> pullDown = [];

  dynamic pullDownSelected;
  final TextEditingController hinbanController = TextEditingController();
  final TextEditingController mekaController = TextEditingController();
  final TextEditingController shohinmeiController = TextEditingController();

  late int currentRadioRow;

  @override
  void initState() {
    currentRadioRow = -1;
    getListBuzai();
    getPullDown();
    super.initState();
  }

  Future<void> getListBuzai() async {
    await GetBuzaiApi().getBuzai(onSuccess: (buzaiResponse) {
      setState(() {
        listBuzai = buzaiResponse;
        tmp = listBuzai;
      });
    }, onFailed: () {
      CustomToast.show(context, message: 'データを取得出来ませんでした。');
    });
  }

  Future<void> getPullDown() async {
    await GetPullDownApi().getPullDown(onSuccess: (list) {
      setState(() {
        var a = list;
        a.add(null);
        a.reversed;
        pullDown = a;
        pullDownSelected = pullDown.isEmpty ? '' : list.first['KBNMSAI_NAME'];
      });
    }, onFailed: () {
      CustomToast.show(context, message: 'データを取得出来ませんでした。');
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
                          controller: hinbanController),
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
                          controller: mekaController),
                      columnText(
                          width: size.width / 2 - 30,
                          text: '商品名',
                          controller: shohinmeiController),
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
                      List<Buzai> list = [];
                      if (pullDownSelected != '全部') {
                        list = listBuzai
                            .where((element) => (element.HINBAN!
                                    .toUpperCase()
                                    .contains(hinbanController.text
                                        .toUpperCase()
                                        .trim()) &&
                                element.MAKER_NAME!.toUpperCase().contains(
                                    mekaController.text.toUpperCase().trim()) &&
                                element.SYOHIN_NAME!.contains(
                                    shohinmeiController.text
                                        .toUpperCase()
                                        .trim()) &&
                                element.BUZAI_BUNRUI!
                                    .toUpperCase()
                                    .contains(pullDownSelected.toUpperCase())))
                            .toList();
                      } else {
                        list = listBuzai
                            .where((element) => (element.HINBAN!
                                    .toUpperCase()
                                    .contains(hinbanController.text
                                        .toUpperCase()
                                        .trim()) &&
                                element.MAKER_NAME!.toUpperCase().contains(
                                    mekaController.text.toUpperCase().trim()) &&
                                element.SYOHIN_NAME!.contains(
                                    shohinmeiController.text
                                        .toUpperCase()
                                        .trim())))
                            .toList();
                      }

                      setState(() {
                        tmp = list;
                      });
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
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildRows(tmp.length + 1),
                  ),
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
                      var x = listBuzai
                          .where((element) => element.STATUS == true)
                          .toList();
                      widget.back.call(x
                          .map((e) => (Inventory(
                              bunrui: e.BUZAI_BUNRUI,
                              buzaiKanriGoban: e.BUZAI_KANRI_NO,
                              meekaa: e.MAKER_NAME,
                              hinban: e.HINBAN,
                              shohinmei: e.SYOHIN_NAME)))
                          .toList());
                      Navigator.pop(context);
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
    return PopupMenuButton<dynamic>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => pullDown.map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              item == null
                  ? pullDownSelected = '全部'
                  : pullDownSelected = item['KBNMSAI_NAME'];
            });
          },
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: item == null ? '全部' : item['KBNMSAI_NAME'],
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
                      item == null ? '全部' : item['KBNMSAI_NAME'],
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
                pullDownSelected ?? '全部',
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
    TextEditingController? controller,
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
            controller: controller,
            type: TextInputType.emailAddress,
            onChanged: (text) {},
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget contentTable(int col, int row) {
    if (col == 1) {
      return Text(
        tmp.isNotEmpty ? tmp[row - 1].BUZAI_KANRI_NO.toString() : '',
        style: const TextStyle(color: Colors.black),
      );
    }
    if (col == 2) {
      return Text(
        tmp.isNotEmpty ? tmp[row - 1].BUZAI_BUNRUI.toString() : '',
        style: const TextStyle(color: Colors.black),
      );
    }
    if (col == 3) {
      return Text(
        tmp.isNotEmpty ? tmp[row - 1].MAKER_NAME.toString() : '',
        style: const TextStyle(color: Colors.black),
      );
    }
    if (col == 4) {
      return Text(
        tmp.isNotEmpty ? tmp[row - 1].HINBAN.toString() : '',
        style: const TextStyle(color: Colors.black),
      );
    }
    return col == 0
        ? Checkbox(
            activeColor: Colors.blue,
            checkColor: Colors.white,
            value: tmp[row - 1].STATUS,
            onChanged: (newValue) {
              setState(() {
                tmp[row - 1].STATUS = newValue ?? false;
              });
            },
          )
        : const Text(
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
      '',
      '',
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
