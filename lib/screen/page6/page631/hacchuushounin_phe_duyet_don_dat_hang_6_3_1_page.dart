import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/models/thanh_tich.dart';
import 'package:link_life_one/screen/login_page.dart';

import '../../../api/order/hachuushounin/get_purchase_order_approval.dart';
import '../../../api/order/hachuushounin/post_purchase_order_approval.dart';
import '../../../components/custom_header_widget.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/login_widget.dart';
import '../../../components/text_line_down.dart';
import '../../../components/toast.dart';
import '../../../shared/assets.dart';
import '../../../shared/custom_button.dart';
import '../../menu_page/menu_page.dart';

class HachuushouninPheDuyetDonDatHang631Page extends StatefulWidget {
  final String BUZAI_HACYU_ID;
  const HachuushouninPheDuyetDonDatHang631Page({
    required this.BUZAI_HACYU_ID,
    Key? key,
  }) : super(key: key);

  @override
  State<HachuushouninPheDuyetDonDatHang631Page> createState() =>
      _HachuushouninPheDuyetDonDatHang631PageState();
}

class _HachuushouninPheDuyetDonDatHang631PageState
    extends State<HachuushouninPheDuyetDonDatHang631Page> {
  List<dynamic> hachuushouninList = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    callGetPurchaseOrderApproval();
  }

  Future<dynamic> callGetPurchaseOrderApproval() async {
    final dynamic result =
        await GetPurchaseOrderApproval().getPurchaseOrderApproval(
            BUZAI_HACYU_ID: widget.BUZAI_HACYU_ID,
            onSuccess: (data) {
              for (var element in data) {
                element["status"] = false;
              }
              setState(() {
                hachuushouninList = data;
                textEditingController.text =
                    hachuushouninList[0]["HACNG_RIYU"] ?? '';
              });
            },
            onFailed: () {
              CustomToast.show(context, message: "発注承認リストを取得出来ませんでした。");
            });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(builder: (context, orientation) {
      print(orientation);
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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildRows(hachuushouninList.length + 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                controller: textEditingController,
                fillColor: const Color(0xFFFFFFFF),
                hint: 'テキストテキストテキスト',
                type: TextInputType.emailAddress,
                onChanged: (text) {},
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF96265),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: TextButton(
                      onPressed: () {
                        List<dynamic> list = hachuushouninList
                            .where((element) => element["status"] == true)
                            .toList();
                        if (list.length > 0) {
                          PostPurchaseOrderApproval().postPurchaseOrderApproval(
                              BUZAI_HACYU_ID_List: list
                                  .map((item) => item["BUZAI_HACYU_ID"])
                                  .toList(),
                              onSuccess: () {
                                CustomToast.show(
                                  context,
                                  message: "発注却下ができました。",
                                  backGround: Colors.green,
                                );

                                setState(() {
                                  for (var element in hachuushouninList) {
                                    element["status"] = false;
                                  }
                                });
                              },
                              onFailed: () {
                                CustomToast.show(context,
                                    message: "発注却下がで出来ませんでした。");
                              });
                        } else {
                          CustomToast.show(context,
                              message: "一つ発注承認を選んでください。。");
                        }
                      },
                      child: const Text(
                        '発注却下',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
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
                        List<dynamic> list = hachuushouninList
                            .where((element) => element["status"] == true)
                            .toList();
                        if (list.length > 0) {
                          PostPurchaseOrderApproval().postPurchaseOrderApproval(
                              BUZAI_HACYU_ID_List: list
                                  .map((item) => item["BUZAI_HACYU_ID"])
                                  .toList(),
                              onSuccess: () {
                                CustomToast.show(
                                  context,
                                  message: "発注承認ができました。",
                                  backGround: Colors.green,
                                );

                                setState(() {
                                  for (var element in hachuushouninList) {
                                    element["status"] = false;
                                  }
                                });
                              },
                              onFailed: () {
                                CustomToast.show(context,
                                    message: "発注承認が出来ませんでした。");
                              });
                        } else {
                          CustomToast.show(context,
                              message: "一つ発注承認を選んでください。。");
                        }
                      },
                      child: const Text(
                        '発注承認',
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
            ],
          ),
        ),
      );
    });
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
            border:
                Border.all(color: const Color.fromARGB(255, 247, 240, 240))),
        width: 200,
        child: CustomButton(
          color: Colors.white70,
          onClick: () {},
          name: '発注承認',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  double getOpacityForOrientation() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return 0;
    } else {
      return 1;
    }
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      'メーカー',
      '分類',
      '品番',
      '商品名',
      'LOT',
      '発注 単価',
      '数量',
      '単位',
      '合計',
    ];

    Size size = MediaQuery.of(context).size;

    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                35,
                200,
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
                100,
                100,
              ]
            : [
                35,
                4 * (size.width - 33) / 20,
                1 * (size.width - 33) / 20,
                2 * (size.width - 33) / 20,
                6 * (size.width - 33) / 20,
                (size.width - 33) / 20,
                2 * (size.width - 33) / 20,
                (size.width - 33) / 20,
                (size.width - 33) / 20,
                2 * (size.width - 33) / 20,
              ];

    return List.generate(count, (col) {
      if (row != 0 && col != 0) {
        String value = '';
        hachuushouninList;

        if (col == 1) {
          value = hachuushouninList[row - 1]["MAKER_NAME"] ?? '';
        }
        if (col == 2) {
          value = hachuushouninList[row - 1]["BUNRUI"] ?? '';
        }
        if (col == 3) {
          value = hachuushouninList[row - 1]["JISYA_CD"] ?? '';
          // if (hachuushouninList[row - 1]["JISYA_CD"] == null) {
          //   value = '';
          // } else {
          //   DateTime time = DateFormat("yyyy-MM-dd")
          //       .parse(hachuushouninList[row - 1]["HACYU_YMD"]);
          //   value = DateFormat('yyyy/MM/dd', 'ja').format(time).toString();
          // }
        }
        if (col == 4) {
          value = hachuushouninList[row - 1]["SYOHIN_NAME"] ?? '';
        }
        if (col == 5) {
          value = hachuushouninList[row - 1]["LOT"] ?? '';
        }
        if (col == 6) {
          value = hachuushouninList[row - 1]["HACYU_TANKA"] ?? '';
        }
        if (col == 7) {
          value = hachuushouninList[row - 1]["SURYO"] ?? '';
        }
        if (col == 8) {
          value = hachuushouninList[row - 1]["TANI_CD"] ?? '';
        }
        if (col == 9) {
          int xx = int.parse(hachuushouninList[row - 1]["HACYU_TANKA"]) *
              int.parse(hachuushouninList[row - 1]["SURYO"]);
          value = xx.toString();
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 50,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }

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
      if (col == 0 && row != 0 && hachuushouninList.length > 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 50,
          child: Checkbox(
            activeColor: Colors.blue,
            checkColor: Colors.white,
            value: hachuushouninList[row - 1]["status"],
            onChanged: (newValue) {
              setState(() {
                hachuushouninList[row - 1]["status"] = newValue ?? false;
              });
            },
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
        child: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      );
    });
  }

  List<Widget> _buildRows(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(10, index),
      );
    });
  }
}
