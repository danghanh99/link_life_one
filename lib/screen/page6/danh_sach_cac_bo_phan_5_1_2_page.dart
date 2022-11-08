import 'package:flutter/material.dart';
import 'package:link_life_one/models/thanh_tich.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:link_life_one/screen/page5/page_5_3_danh_sach_nhan_lai_vat_lieu.dart';

import '../../components/custom_text_field.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page.dart';

class DanhSachCacBoPhan512Page extends StatefulWidget {
  const DanhSachCacBoPhan512Page({
    Key? key,
  }) : super(key: key);

  @override
  State<DanhSachCacBoPhan512Page> createState() =>
      _DanhSachCacBoPhan512PageState();
}

class _DanhSachCacBoPhan512PageState extends State<DanhSachCacBoPhan512Page> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  late int currentRadioRow;

  @override
  void initState() {
    currentRadioRow = -1;

    super.initState();
  }

  List<ThanhTich> listThanhTich = [
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-01'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-02'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-03'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-04'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-05'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-06'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-07'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-08'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-09'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-10'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-11'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-12'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-13'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-14'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-15'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-16'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-17'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-18'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-19'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-20'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-21'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-22'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-23'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-24'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-25'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
    ThanhTich(
      ngayThang: DateTime.parse('2022-09-26'),
      chiPhiKyGuiChuaXacNhan: 0,
      chiPhiKyGuiDaXacNhan: 0,
      soLuongCongTrinh: 0,
      soLuongXemTruoc: 0,
      soLuongBoSung: 0,
      soLuongBanHang: 0,
    ),
  ];

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
      '部材 管理番号',
      '分類',
      'メーカー',
      '品番',
      '',
      '',
    ];

    List<double> colwidth = [
      30,
      130,
      130,
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
        children: _buildCells2(7, index),
      );
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
                color: const Color(0xFFA5A7A9),
                border: Border.all(width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // child: Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     // SingleChildScrollView(
              //     //   scrollDirection: Axis.vertical,
              //     //   child: Column(
              //     //     crossAxisAlignment: CrossAxisAlignment.start,
              //     //     children: _buildCells(20),
              //     //   ),
              //     // ),
              //     Flexible(
              //       child: SingleChildScrollView(
              //         scrollDirection: Axis.horizontal,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: _buildRows(4),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              child: Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildRows(4),
                  ),
                ),
              ),
            ),
            // Expanded(child: Container()),
            const SizedBox(
              height: 10,
            ),

            Expanded(child: Container()),
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
                          const Page53DanhSachNhanLaiVatLieu(),
                    ),
                  );
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
                "Dropdown item1",
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
                "Dropdown item2",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(-0, 50),
      child: Container(
        width: width,
        height: 50,
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
            TextLineDown(
                text: 'ログアウト',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }),
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
        _dropDownButton(context, 'カテゴリを選択', width ?? 30),
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
}
