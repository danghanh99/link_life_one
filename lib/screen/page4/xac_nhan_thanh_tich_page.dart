import 'package:flutter/material.dart';
import 'package:link_life_one/models/thanh_tich.dart';
import 'package:link_life_one/screen/login_page.dart';

import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../../shared/date_formatter copy.dart';
import '../menu_page.dart';

class XacNhanThanhTichPage extends StatefulWidget {
  const XacNhanThanhTichPage({
    Key? key,
  }) : super(key: key);

  @override
  State<XacNhanThanhTichPage> createState() => _XacNhanThanhTichPageState();
}

class _XacNhanThanhTichPageState extends State<XacNhanThanhTichPage> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

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
        margin: EdgeInsets.all(1.0),
        child: Text(
          "col ${index + 1}",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '実績',
      '委託費(未確定)',
      '委託費(確定済)',
      '工事件数',
      '下見件数',
      '追加工事件数',
      '物販件数',
    ];

    List<double> colwidth = [
      110,
      130,
      130,
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
          height: 40,
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
      if (row == 1) {
        String text = '';
        if (row == 1 && col == 0) {
          text = '合計';
        } else {
          text = '';
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFF6D8FDB),
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 40,
          // color: Colors.white,
          // margin: const EdgeInsets.all(1.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }
      String text = '';
      switch (col) {
        case (0):
          text = DateFormatter.yearMonthDay2(listThanhTich[row - 2].ngayThang);
          break;
        case (1):
          text = listThanhTich[row - 2].chiPhiKyGuiChuaXacNhan.toString();
          break;
        case (2):
          text = listThanhTich[row - 2].chiPhiKyGuiDaXacNhan.toString();
          break;
        case (3):
          text = listThanhTich[row - 2].soLuongCongTrinh.toString();
          break;
        case (4):
          text = listThanhTich[row - 2].soLuongXemTruoc.toString();
          break;
        case (5):
          text = listThanhTich[row - 2].soLuongBoSung.toString();
          break;
        case (6):
          text = listThanhTich[row - 2].soLuongBanHang.toString();
          break;

        default:
          {}
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
          text,
          style: const TextStyle(color: Colors.black),
        ),
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
            Row(
              children: [
                const SizedBox(
                  width: 80,
                  child: Text(
                    '工事担当者',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                _dropDownButton(context, '担当者を選択'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 80,
                  child: Text(
                    '対象月',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                _dropDownButton(context, '2022 / 09'),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              '※ 委託費は、下見案件1件あたりの委託額を加算済みの数値です。',
              style: TextStyle(
                color: Color(0xFF9D9D9D),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.vertical,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: _buildCells(20),
                    //   ),
                    // ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildRows(listThanhTich.length + 2),
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
          ],
        ),
      ),
    );
  }

  Widget textLineDown(String text, Function() onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap.call();
          },
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF042C5C),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
            textLineDown('ログアウト', () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            textLineDown('戻る', () {
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
          name: '実績確認',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
