import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/models/user.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../api/order/get_part_order_list.dart';
import '../../../api/order/get_pull_down_status.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/login_widget.dart';
import '../../../components/text_line_down.dart';
import '../../../shared/assets.dart';
import '../../../shared/custom_button.dart';
import '../../menu_page/menu_page.dart';
import '../saibuhachuulist_danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

class SaibuhachuuDanhSachDatHangCacBoPhan61Page extends StatefulWidget {
  const SaibuhachuuDanhSachDatHangCacBoPhan61Page({
    Key? key,
  }) : super(key: key);

  @override
  State<SaibuhachuuDanhSachDatHangCacBoPhan61Page> createState() =>
      _SaibuhachuuDanhSachDatHangCacBoPhan61PageState();
}

class _SaibuhachuuDanhSachDatHangCacBoPhan61PageState
    extends State<SaibuhachuuDanhSachDatHangCacBoPhan61Page> {
  late int currentRadioRow;

  List<dynamic> listOrder = [];
  List<dynamic> listOrderKhongCoDinh = [];
  List<dynamic> listPullDown = [];

  String currentPullDownValue = 'カテゴリを選択';

  @override
  void initState() {
    currentRadioRow = -1;

    super.initState();
    callGetPullDownStatus();
    callGetLichTrinhItem();
  }

  Future<dynamic> callGetLichTrinhItem() async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;

    final dynamic result = await GetPartOrderList().getPartOrderList(
        SYOZOKU_CD: user.SYOZOKU_CD,
        onSuccess: (data) {
          print(data);
          setState(() {
            listOrder = data;
            listOrderKhongCoDinh = listOrder;
          });
        },
        onFailed: () {
          CustomToast.show(context, message: "データを取得出来ませんでした。");
        });
  }

  Future<dynamic> callGetPullDownStatus() async {
    final dynamic result =
        await GetPullDownStatus().getPartOrderList(onSuccess: (data) {
      print(data);
      setState(() {
        listPullDown = data;
      });
    }, onFailed: () {
      CustomToast.show(context, message: "データを取得出来ませんでした。");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, //new line

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
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFA5A7A9),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      columnText(
                        width: size.width / 2 - 30,
                        text: '発注ID',
                        onChange: (text) {
                          if (text == '') {
                            setState(() {
                              listOrderKhongCoDinh = listOrder;
                            });
                          } else {
                            setState(() {
                              listOrderKhongCoDinh = listOrderKhongCoDinh
                                  .where((element) => element["BUZAI_HACYU_ID"]
                                      .toString()
                                      .contains(text))
                                  .toList();
                            });
                          }
                        },
                      ),
                      columnText(
                        width: size.width / 2 - 30,
                        text: '発注者',
                        onChange: (text) {
                          listOrderKhongCoDinh;
                          if (text == '') {
                            setState(() {
                              listOrderKhongCoDinh = listOrder;
                            });
                          } else {
                            setState(() {
                              listOrderKhongCoDinh = listOrderKhongCoDinh
                                  .where((element) => element["TANT_NAME"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      columnText2(
                        width: size.width / 2 - 30,
                        text: 'ステータス',
                      ),
                      Container()
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
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildRows(listOrderKhongCoDinh.length + 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SaibuhacchuulistDanhSachDatHangVatLieu611Page(
                              SYOZOKU_CD: null,
                              JISYA_CD: null,
                              BUZAI_HACYU_ID: null,
                            ),
                          ));
                    },
                    child: const Text(
                      '新規部材発注',
                      style: TextStyle(
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
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C8EDA),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (currentRadioRow - 1 >= 0) {
                        List<dynamic> tmp = listOrderKhongCoDinh;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SaibuhacchuulistDanhSachDatHangVatLieu611Page(
                                    SYOZOKU_CD: tmp[currentRadioRow - 1]
                                        ["SYOZOKU_CD"],
                                    JISYA_CD: tmp[currentRadioRow - 1]
                                        ["JISYA_CD"],
                                    BUZAI_HACYU_ID: tmp[currentRadioRow - 1]
                                        ["BUZAI_HACYU_ID"]),
                          ),
                        );
                      } else {
                        CustomToast.show(context, message: "一つを選択してください。");
                      }
                    },
                    child: const Text(
                      'リスト確認',
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
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listPullDown.map((item) {
        return PopupMenuItem(
          onTap: () {
            if (currentPullDownValue == item["KBNMSAI_NAME"]) {
              setState(() {
                currentPullDownValue = 'カテゴリを選択';
                listOrderKhongCoDinh = listOrder;
              });
            } else {
              setState(() {
                List<dynamic> tmp = listOrder
                    .where((element) =>
                        element["KBNMSAI_NAME"] == item["KBNMSAI_NAME"])
                    .toList();
                listOrderKhongCoDinh = tmp;
                currentPullDownValue = item["KBNMSAI_NAME"];
              });
            }
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
                      style: const TextStyle(color: Color(0xFF999999)),
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
        width: width - 4,
        height: 45,
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
                currentPullDownValue,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MenuPage(),
              ),
            );
          },
          child: Image.asset(
            Assets.LOGO_LINK,
            width: 100,
            height: 100,
          ),
        ),
        Column(
          children: [
            LoginWidget(),
            const SizedBox(
              height: 10,
            ),
            TextLineDown(
                text: '戻る',
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ],
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
          name: '部材発注一覧',
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
    Function(String)? onChange,
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
            onChanged: (text) {
              onChange?.call(text);
            },
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
        _dropDownButton(context, 'カテゴリを選択', width ?? 30),
      ],
    );
  }

  Widget contentTable(int col, int row) {
    listOrder;
    List<dynamic> tmp = [];
    tmp = listOrderKhongCoDinh;
    if (row != 0 && col != 0) {
      String value = '';

      if (col == 1) {
        value = tmp[row - 1]["BUZAI_HACYU_ID"];
      }
      if (col == 2) {
        value = tmp[row - 1]["KBNMSAI_NAME"] ?? '';
      }
      if (col == 3) {
        value = tmp[row - 1]["HACYU_YMD"];
      }
      if (col == 4) {
        value = tmp[row - 1]["TANT_NAME"];
      }
      if (col == 5) {
        value = tmp[row - 1]["JISYA_CD"];
      }
      if (col == 6) {
        value = tmp[row - 1]["SYOHIN_NAME"];
      }

      return Text(
        value,
        style: TextStyle(color: Colors.black),
      );
    }

    return col == 0
        ? RadioListTile(
            value: row,
            groupValue: currentRadioRow,
            onChanged: (e) {
              setState(() {
                currentRadioRow = row;
              });
            },
          )
        : const Text(
            '',
            style: TextStyle(color: Colors.black),
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
      '発注ID',
      'ステータス',
      '発注日',
      '発注者',
      '品番',
      '商品名',
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
                120,
                120,
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
