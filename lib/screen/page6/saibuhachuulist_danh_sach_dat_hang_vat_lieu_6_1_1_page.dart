import 'package:flutter/material.dart';
import 'package:link_life_one/models/thanh_tich.dart';
import 'package:link_life_one/screen/login_page.dart';

import '../../api/order/saibuhachuu_list/get_check_list.dart';
import '../../api/order/saibuhachuu_list/get_material_ordering_list.dart';
import '../../components/custom_text_field.dart';
import '../../components/login_widget.dart';
import '../../components/text_line_down.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';
import 'danh_sach_cac_bo_phan_5_1_2_page.dart';

class SaibuhacchuulistDanhSachDatHangVatLieu611Page extends StatefulWidget {
  String? SYOZOKU_CD;
  String? JISYA_CD;
  String? BUZAI_HACYU_ID;
  SaibuhacchuulistDanhSachDatHangVatLieu611Page({
    this.SYOZOKU_CD,
    this.JISYA_CD,
    this.BUZAI_HACYU_ID,
    Key? key,
  }) : super(key: key);

  @override
  State<SaibuhacchuulistDanhSachDatHangVatLieu611Page> createState() =>
      _SaibuhacchuulistDanhSachDatHangVatLieu611PageState();
}

class _SaibuhacchuulistDanhSachDatHangVatLieu611PageState
    extends State<SaibuhacchuulistDanhSachDatHangVatLieu611Page> {
  late int currentRadioRow;

  dynamic first = {
    "MAKER_NAME": "",
    "BUNRUI": '',
    "JISYA_CD": "",
    "SYOHIN_NAME": "",
    "LOT": "",
    "HACYU_TANKA": "",
    "SURYO": "",
    "TANI_CD": "",
    "KINGAK": "",
    "HINBAN": "",
    "BUZAI_HACYU_ID": "",
    "BUZAI_HACYUMSAI_ID": "",
    "status": false,
  };
  List<dynamic> saibuList = [];

  @override
  void initState() {
    currentRadioRow = -1;

    super.initState();
    if (widget.JISYA_CD != null && widget.SYOZOKU_CD != null) {
      call2ApiGetList();
    } else {
      saibuList.add(first);
    }
  }

  Future<dynamic> call2ApiGetList() async {
    final dynamic result =
        await GetMaterialOrderingList().getMaterialOrderingList(
            SYOZOKU_CD: widget.SYOZOKU_CD!,
            JISYA_CD: widget.JISYA_CD!,
            onSuccess: (data) {
              if (data.isEmpty && saibuList.isEmpty) {
                setState(() {
                  saibuList.add(first);
                });
              } else {
                for (var element in data) {
                  element["status"] = false;
                }

                setState(() {
                  saibuList.addAll(data);
                });

                if (widget.BUZAI_HACYU_ID != null) {
                  callGetCheckList((res) {
                    if (res.isEmpty && saibuList.isEmpty) {
                      setState(() {
                        saibuList.add(first);
                      });
                    } else {
                      for (var element in res) {
                        element["status"] = false;
                      }
                      setState(() {
                        saibuList.addAll(res);
                      });
                    }
                  });
                }
              }
            },
            onFailed: () {
              CustomToast.show(context,
                  message: "Failed to get material order list");
            });
  }

  Future<dynamic> callGetCheckList(Function(List<dynamic>) onSccess) async {
    final dynamic result = await GetCheckList().getCheckList(
        BUZAI_HACYU_ID: widget.BUZAI_HACYU_ID!,
        onSuccess: (data) {
          onSccess.call(data);
        },
        onFailed: () {
          CustomToast.show(context, message: "Failed to get check list");
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false, // this is new
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          reverse: true, // this is new
          // physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 16,
              right: 16,
              left: 16,
            ),
            child: Container(
              height: size.height,
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
                                children: _buildRows(saibuList.length + 1),
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
                    fillColor: const Color(0xFFA5A7A9),
                    hint: 'テキストテキストテキスト',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          onPressed: () {},
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
                          onPressed: () {
                            print("object");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DanhSachCacBoPhan512Page(),
                              ),
                            );
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
                          color: const Color(0xFFFA6366),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: TextButton(
                          onPressed: () {},
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
                          onPressed: () {
                            // print("object");
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const DanhSachCacBoPhan512Page(),
                            //   ),
                            // );
                          },
                          child: const Text(
                            'リスト複製',
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
                  Expanded(child: Container()),
                  Container(
                    width: 120,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D8FDB),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        '発注申請',
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
          ),
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
          name: '部材発注リスト',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget contentTable(int col, int row) {
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

    if (row != 0 && col != 0) {
      String value = '';
      saibuList;

      if (col == 1) {
        value = saibuList[row - 1]["MAKER_NAME"] ?? '';
      }
      if (col == 2) {
        value = saibuList[row - 1]["BUNRUI"] ?? '';
      }
      if (col == 3) {
        value = saibuList[row - 1]["HINBAN"] ?? '';
      }
      if (col == 4) {
        value = saibuList[row - 1]["SYOHIN_NAME"] ?? '';
      }
      if (col == 5) {
        value = saibuList[row - 1]["LOT"] ?? '';
      }
      if (col == 6) {
        value = saibuList[row - 1]["HACYU_TANKA"] ?? '';
      }

      if (col == 7) {
        return Row(
          children: [
            Text(saibuList[row - 1]["SURYO"] ?? ''),
            const Spacer(),
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
              child: _moreButton(context),
            ),
          ],
        );
      }
      if (col == 8) {
        value = saibuList[row - 1]["TANI_CD"] ?? '';
      }
      if (col == 9) {
        value = saibuList[row - 1]["KINGAK"] ?? '';
      }

      return Text(
        value,
        style: TextStyle(color: Colors.black),
      );
    }

    return const Text(
      '',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _moreButton(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => EditThemePage(
          //           index: index,
          //           meditationThemeDTO: meditationThemeDTO,
          //         )));
        }
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
                "Dropdown item",
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
                "Dropdown item",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(-25, -10),
      child: Image.asset(
        Assets.icDropdown,
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
      'メーカ',
      '分類',
      '品番',
      '商品名',
      'LOT',
      '発注 単価',
      '数量',
      '単位',
      '合計',
    ];

    List<double> colwidth = [
      30,
      130,
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
        children: _buildCells2(10, index),
      );
    });
  }
}
