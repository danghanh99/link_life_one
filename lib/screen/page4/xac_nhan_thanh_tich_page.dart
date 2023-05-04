import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/result/default.dart';
import 'package:link_life_one/api/result/get_pulldown_list_month.dart';
import 'package:link_life_one/api/result/get_pulldown_list_people.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/models/month.dart';
import 'package:link_life_one/models/people.dart';
import 'package:link_life_one/models/thanh_tich.dart';
import '../../components/custom_header_widget.dart';
import '../../components/login_widget.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../../shared/date_formatter copy.dart';
import '../menu_page/menu_page.dart';

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

  List<DateTime> dates = [];

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
    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                110,
                130,
                130,
                100,
                100,
                100,
                100,
                100,
              ]
            : [
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
              ];
    return List.generate(count, (col) {
      var y = NumberFormat("###,###");
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
          if (col == 1) {
            text = listThanhTich.isEmpty
                ? '0'
                : y.format(listThanhTich
                    .map((e) => e.chiPhiKyGuiChuaXacNhan ?? 0)
                    .reduce((value, element) => value + element))
                    .toString();
          }
          if (col == 2) {
            text = listThanhTich.isEmpty
                ? '0'
                : y.format(listThanhTich
                    .map((e) => e.chiPhiKyGuiDaXacNhan ?? 0)
                    .reduce((value, element) => value + element))
                    .toString();
          }
          if (col == 3) {
            text = listThanhTich.isEmpty
                ? '0'
                : y.format(listThanhTich
                    .map((e) => e.soLuongCongTrinh ?? 0)
                    .reduce((value, element) => value + element))
                    .toString();
          }
          if (col == 4) {
            text = listThanhTich.isEmpty
                ? '0'
                : y.format(listThanhTich
                    .map((e) => e.soLuongXemTruoc ?? 0)
                    .reduce((value, element) => value + element))
                    .toString();
          }
          if (col == 5) {
            text = listThanhTich.isEmpty
                ? '0'
                : y.format(listThanhTich
                    .map((e) => e.soLuongBoSung ?? 0)
                    .reduce((value, element) => value + element))
                    .toString();
          }
          if (col == 6) {
            text = listThanhTich.isEmpty
                ? '0'
                : y.format(listThanhTich
                    .map((e) => e.soLuongBanHang ?? 0)
                    .reduce((value, element) => value + element))
                    .toString();
          }
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFF6D8FDB),
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 40,
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
      bool isToday = DateFormat('yyyyMMdd').format(listThanhTich[row - 2].ngayThang)==DateFormat('yyyyMMdd').format(DateTime.now());
      switch (col) {
        case (0):
          text = DateFormatter.yearMonthDay2(listThanhTich[row - 2].ngayThang);
          break;
        case (1):
          text = y
              .format(listThanhTich[row - 2].chiPhiKyGuiChuaXacNhan)
              .toString();
          break;
        case (2):
          text =
              y.format(listThanhTich[row - 2].chiPhiKyGuiDaXacNhan).toString();
          break;
        case (3):
          text = y.format(listThanhTich[row - 2].soLuongCongTrinh).toString();
          break;
        case (4):
          text = y.format(listThanhTich[row - 2].soLuongXemTruoc).toString();
          break;
        case (5):
          text = y.format(listThanhTich[row - 2].soLuongBoSung).toString();
          break;
        case (6):
          text = y.format(listThanhTich[row - 2].soLuongBanHang).toString();
          break;

        default:
          {}
      }
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: isToday
            ? Colors.black12
            : Colors.white,
        ),
        alignment: Alignment.center,
        width: colwidth[col],
        height: 50,
        child: Text(
          text,
          style: isToday
            ? const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            )
            : const TextStyle(color: Colors.black),
        ),
      );
    });
  }

  List<Widget> _buildRows(int count, int start) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(7, start+index),
      );
    });
  }

  List<People> listPeople = [];
  People? peopleSelected;
  List<Month> listMonth = [];
  Month? monthSelected;
  List<ThanhTich> listThanhTich = [];

  @override
  void initState() {
    getPullDownListPeople();
    super.initState();
  }

  Future<void> getPullDownListPeople() async {
    await GetPullDownListPeople().getPullDownListPeople(
        onSuccess: (list) async {
          final box = Hive.box<String>('user');
          final loginId = box.values.last;
          List<People>? people = list.where((element) => element.tantoCd==loginId).toList();
      await GetPullDownListMonth().getPullDownListMonth(
        TANT_CD: people.isNotEmpty ? people[0].tantoCd : list.first.tantoCd,
        onSuccess: (listMonthResponse) async {
          setState(
            () {
              listPeople = list;
              peopleSelected = people.isNotEmpty ? people[0] : listPeople.first;
              listMonth = listMonthResponse;
              var thisMonth = DateFormat('yyyy/MM').format(DateTime.now());
              List<Month> months = listMonth.where((element) => element.formatedDate==thisMonth).toList();
              monthSelected = months.isNotEmpty ? months[0] : listMonth.first;
            },
          );
          if (monthSelected != null) {
            String year = monthSelected!.formatedDate.split("/").first;
            String month = monthSelected!.formatedDate.split("/").last;
            int day = _getLastDayOfMonth(int.parse(month), int.parse(year));
            int count = 1;
            List<ThanhTich> tmp = [];
            while (count <= day) {
              DateTime date =
                  DateTime(int.parse(year), int.parse(month), count);
              ThanhTich a = ThanhTich(
                  ngayThang: date,
                  soLuongBanHang: 0,
                  soLuongBoSung: 0,
                  soLuongCongTrinh: 0,
                  soLuongXemTruoc: 0,
                  chiPhiKyGuiChuaXacNhan: 0,
                  chiPhiKyGuiDaXacNhan: 0,
                  tantoCd: '');
              tmp.add(a);
              count += 1;
            }
            setState(() {
              listThanhTich = tmp;
            });
          }
          if (listMonthResponse.isNotEmpty) {
            await Default().getDefault(
                JISEKI_YMD: listMonthResponse.first.formatedDate,
                TANT_CD: listMonthResponse.first.tantoCd,
                onSuccess: ((listThanhTichResponse) {
                  List<ThanhTich> tam = [];
                  listThanhTich.forEach((elementA) {
                    ThanhTich thanhTichA = elementA;
                    listThanhTichResponse.forEach((elementB) {
                      if (elementA.ngayThang == elementB.ngayThang) {
                        thanhTichA = elementB;
                      }
                    });
                    tam.add(thanhTichA);
                  });
                  setState(() {
                    listThanhTich = tam;
                  });
                }),
                onFailed: () {});
          }
        },
        onFailed: () {
          CustomToast.show(context, message: 'プルダウンを取得出来ませんでした。');
        },
      );
    });
  }

  _getLastDayOfMonth(int month, int year) {
    DateTime date = DateTime(year, month + 1, 1);
    return date.subtract(const Duration(days: 1)).day;
  }

  @override
  Widget build(BuildContext context) {
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
                _dropDownListPeople(context),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 80,
                  child: const Text(
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
                _dropDownListMonth(context),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: const [
                Text(
                  '※ 委託費は、下見案件1件あたりの委託額を加算済みの数値です。',
                  style: TextStyle(
                    color: Color(0xFF9D9D9D),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // Flexible(
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Flexible(
            //           child: SingleChildScrollView(
            //             scrollDirection: Axis.vertical,
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: _buildRows(listThanhTich.length, 2),
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRows(listThanhTich.isNotEmpty ? 2 : 0, 0)+[
                    Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: _buildRows(listThanhTich.length, 2),
                          ),
                        )
                    )
                  ],
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

  Widget _dropDownListMonth(BuildContext context) {
    return PopupMenuButton<Month>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listMonth.map((e) {
        return PopupMenuItem(
          onTap: () async {
            setState(() {
              monthSelected = e;
            });
            if (monthSelected != null) {
              String year = monthSelected!.formatedDate.split("/").first;
              String month = monthSelected!.formatedDate.split("/").last;
              int day = _getLastDayOfMonth(int.parse(month), int.parse(year));
              int count = 1;
              List<ThanhTich> tmp = [];
              while (count <= day) {
                DateTime date =
                    DateTime(int.parse(year), int.parse(month), count);
                ThanhTich a = ThanhTich(
                    ngayThang: date,
                    soLuongBanHang: 0,
                    soLuongBoSung: 0,
                    soLuongCongTrinh: 0,
                    soLuongXemTruoc: 0,
                    chiPhiKyGuiChuaXacNhan: 0,
                    chiPhiKyGuiDaXacNhan: 0,
                    tantoCd: '');
                tmp.add(a);
                count += 1;
              }
              setState(() {
                listThanhTich = tmp;
              });
              await Default().getDefault(
                  TANT_CD: monthSelected!.tantoCd,
                  JISEKI_YMD: monthSelected!.formatedDate,
                  onSuccess: (list) {
                    List<ThanhTich> tam = [];
                    listThanhTich.forEach((elementA) {
                      ThanhTich thanhTichA = elementA;
                      list.forEach((elementB) {
                        if (elementA.ngayThang == elementB.ngayThang) {
                          thanhTichA = elementB;
                        }
                      });
                      tam.add(thanhTichA);
                    });
                    setState(() {
                      listThanhTich = tam;
                      tam = [];
                    });
                  },
                  onFailed: () {
                    CustomToast.show(context, message: 'データを取得出来ませんでした。');
                  });
            } else {
              CustomToast.show(context, message: '月を選択してください。');
            }
          },
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: e,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 14,
                  ),
                  Text(e.formatedDate),
                ],
              ),
              const Divider(
                color: Colors.black,
              )
            ],
          ),
        );
      }).toList(),
      offset: const Offset(0, 30),
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
              listMonth.isEmpty ? '' : monthSelected!.formatedDate,
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

  Widget _dropDownListPeople(BuildContext context) {
    return PopupMenuButton<People>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listPeople.map((e) {
        return PopupMenuItem(
          onTap: () async {
            await GetPullDownListMonth().getPullDownListMonth(
                TANT_CD: e.tantoCd,
                onSuccess: (list) async {
                  setState(
                    () {
                      peopleSelected = e;
                      listMonth = list;
                      monthSelected =
                          listMonth.isEmpty ? null : listMonth.first;
                    },
                  );
                  if (monthSelected == null) {
                    setState(() {
                      listThanhTich = [];
                    });
                  } else {
                    String year = monthSelected!.formatedDate.split("/").first;
                    String month = monthSelected!.formatedDate.split("/").last;
                    int day =
                        _getLastDayOfMonth(int.parse(month), int.parse(year));
                    int count = 1;
                    List<ThanhTich> tmp = [];
                    while (count <= day) {
                      DateTime date =
                          DateTime(int.parse(year), int.parse(month), count);
                      ThanhTich a = ThanhTich(
                          ngayThang: date,
                          soLuongBanHang: 0,
                          soLuongBoSung: 0,
                          soLuongCongTrinh: 0,
                          soLuongXemTruoc: 0,
                          chiPhiKyGuiChuaXacNhan: 0,
                          chiPhiKyGuiDaXacNhan: 0,
                          tantoCd: '');
                      tmp.add(a);
                      count += 1;
                    }
                    setState(() {
                      listThanhTich = tmp;
                    });
                    await Default().getDefault(
                        TANT_CD: monthSelected!.tantoCd,
                        JISEKI_YMD: monthSelected!.formatedDate,
                        onSuccess: (list) {
                          List<ThanhTich> tam = [];
                          listThanhTich.forEach((elementA) {
                            ThanhTich thanhTichA = elementA;
                            list.forEach((elementB) {
                              if (elementA.ngayThang == elementB.ngayThang) {
                                thanhTichA = elementB;
                              }
                            });
                            tam.add(thanhTichA);
                          });
                          setState(() {
                            listThanhTich = tam;
                            tam = [];
                          });
                        },
                        onFailed: () {
                          CustomToast.show(context, message: 'データを取得出来ませんでした。');
                        });
                  }
                },
                onFailed: () {});
          },
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: e,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 14,
                  ),
                  Text(e.tantoName),
                ],
              ),
              const Divider(
                color: Colors.black,
              )
            ],
          ),
        );
      }).toList(),
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
              listPeople.isEmpty ? '' : peopleSelected!.tantoName,
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
