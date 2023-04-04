import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/schedule/schedule_api.dart';
import 'package:link_life_one/api/sukejuuru_page_api/show_holiday.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page7/eigyo_anken/page7_2_3_create_eigyo_anken/page_7_2_3.dart';
import 'package:link_life_one/screen/page7/eigyo_anken/page7_2_3_edit_show_anken/page_7_2_3_edit_show_anken.dart';
import 'package:link_life_one/screen/page7/memo/page_7_2_4_create.dart';
import 'package:link_life_one/screen/page7/memo/page_7_2_4_update.dart';
import 'package:link_life_one/shared/box_manager.dart';
import '../../../api/sukejuuru_page_api/get_anken_cua_mot_phong_ban.dart';
import '../../../api/sukejuuru_page_api/get_list_phong_ban.dart';
import '../../../components/custom_header_widget.dart';
import '../../../models/person_model.dart';
import '../../../shared/assets.dart';
import '../../../shared/custom_button.dart';
import '../component/dialog.dart';
import '../component/popup_hien_thi.dart';
import '../netto_koji/page7_2_1_show_item/page_7_2_1.dart';

class QuanLyLichBieu71Page extends StatefulWidget {
  const QuanLyLichBieu71Page({
    Key? key,
  }) : super(key: key);

  @override
  State<QuanLyLichBieu71Page> createState() => _QuanLyLichBieu71PageState();
}

class _QuanLyLichBieu71PageState extends State<QuanLyLichBieu71Page>
    with RouteAware {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  List<PersonModel> listNhanVien = [];

  List<dynamic> listAnkenPhongBan = [];

  List<dynamic> sukejuuruAllUser = [];

  dynamic sukejuuruPhongBan;

  PersonModel? sukejuuruSelectedUser;

  List<dynamic> listPhongBan = [];

  String value1nguoi = 'グループ';
  // DateTime date = DateTime.parse('2022-11-11');
  DateTime currentDate = DateTime.now();
  ScrollController scrollControllerItem = ScrollController();
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  String phongBanName = '';
  String phongBanId = '';

  Future? geAnkenCuaMotPhongBanFuture;

  @override
  void initState() {
    callGetListPhongBan((isSuccess) {
      if (isSuccess) {
        geAnkenCuaMotPhongBanFuture = callGetAnkenCuaMotPhongBan(
            kojiGyoSyaCd: phongBanId, date: currentDate);
        getListPeople(phongBanId);
      }
    });

    scrollController2.addListener(() {
      print('scrolling.... ${scrollController2.position.pixels}');
      scrollController.jumpTo(scrollController2.position.pixels);
    });

    super.initState();
  }

  void getData() {
    String? tantCode;
    if (value1nguoi == '個人') {
      tantCode = sukejuuruSelectedUser?.tantCode ?? '';
    }
    callGetAnkenCuaMotPhongBan(
      kojiGyoSyaCd: phongBanId,
      date: currentDate,
      selectedTantCode: tantCode,
    );
    getListPeople(phongBanId);
  }

  Future<List<dynamic>> callGetListPhongBan(Function(bool) onSuccess) async {
    final result = await GetListPhongBan().getListPhongBan(onSuccess: (list) {
      setState(() {
        listPhongBan = list;
      });

      bool success = false;

      for (var phongban in list) {
        var code = phongban['KOJIGYOSYA_CD'];
        if (code != null && code != '') {
          if (BoxManager.user.SYOZOKU_CD == code) {
            success = true;
            setState(() {
              phongBanId = phongban["KOJIGYOSYA_CD"];
              phongBanName = phongban["KOJIGYOSYA_NAME"];
            });
          }
        }
      }
      onSuccess.call(success);
    }, onFailed: () {
      CustomToast.show(context,
          message: "データを取得出来ませんでした。", backGround: Colors.red);
    });

    return result;
  }

  Future<dynamic> callGetAnkenCuaMotPhongBan(
      {required String kojiGyoSyaCd,
      required DateTime date,
      String? selectedTantCode,
      Function? onsuccess}) async {
    final dynamic result = await GetAnkenCuaMotPhongBan()
        .getAnkenCuaMotPhongBan(kojiGyoSyaCd, date, (response) {
      if (response["OFFICE"] != null) {
        setState(() {
          sukejuuruPhongBan = response["OFFICE"];
        });
      } else {
        setState(() {
          sukejuuruPhongBan = [];
        });
      }

      if (response["PERSON"] != null) {
        List<dynamic> tmpPERSON = response["PERSON"][0];

        if (tmpPERSON.isEmpty) {
          setState(() {
            sukejuuruAllUser = [];
          });
        } else {
          if (selectedTantCode != null) {
            List<dynamic> listmtp = response["PERSON"][0];
            if (listmtp.isNotEmpty) {
              setState(() {
                sukejuuruAllUser = listmtp;
              });
            }
          } else {
            List<dynamic> listmtp = response["PERSON"][0];
            if (listmtp.isNotEmpty) {
              setState(() {
                sukejuuruAllUser = listmtp;
              });
            }
          }
        }
      } else {
        setState(() {
          listNhanVien = [];
          sukejuuruSelectedUser = null;
          sukejuuruAllUser = [];
        });
      }

      onsuccess?.call();
    }, () {
      CustomToast.show(context, message: "データを取得出来ませんでした。");
    });

    return result;
  }

  void getListPeople(String phongbanId) {
    ScheduleAPI.shared.getListPerson(phongbanId, (peopleList) {
      PersonModel? selectedPerson;
      if (peopleList.isEmpty) {
        setState(() {
          listNhanVien = [];
          sukejuuruSelectedUser = null;
        });
      }
      for (var person in peopleList) {
        if (BoxManager.user.TANT_CD == person.tantCode) {
          selectedPerson = person;
          break;
        }
      }
      if (selectedPerson != null) {
        setState(() {
          listNhanVien = peopleList;
          sukejuuruSelectedUser = selectedPerson;
        });
      } else {
        setState(() {
          listNhanVien = peopleList;
          sukejuuruSelectedUser = peopleList.first;
        });
      }
    }, () {
      listNhanVien = [];
    });
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
            const CustomHeaderWidget(),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 247, 240, 240))),
                width: 200,
                child: CustomButton(
                  color: Colors.white70,
                  onClick: () {},
                  name: 'スケジュール管理',
                  textStyle: const TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Text(
                  '協力店名 / 営業所名',
                  style: TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _moreButton(context),
                ),
                Container(
                  width: 70,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      '表示',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          value1nguoi = 'グループ';
                        });
                      },
                      child: Text(
                        'グループ',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: value1nguoi == 'グループ'
                                  ? <Color>[
                                      const Color(0xFF6F86D6),
                                      const Color(0xFF48C6EF)
                                    ]
                                  : <Color>[
                                      const Color(0xFF042C5C),
                                      const Color(0xFF042C5C)
                                    ],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: value1nguoi == 'グループ'
                              ? [
                                  const Color(0xFF6F86D6),
                                  const Color(0xFF48C6EF)
                                ]
                              : [
                                  const Color(0xFFDFE0E3),
                                  const Color(0xFFDFE0E3)
                                ],
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          value1nguoi = '個人';
                        });
                      },
                      child: Text(
                        '個人',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: value1nguoi == '個人'
                                  ? <Color>[
                                      const Color(0xFF6F86D6),
                                      const Color(0xFF48C6EF)
                                    ]
                                  : <Color>[
                                      const Color(0xFF042C5C),
                                      const Color(0xFF042C5C)
                                    ],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      height: 3.0,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: value1nguoi == '個人'
                              ? [
                                  const Color(0xFF6F86D6),
                                  const Color(0xFF48C6EF)
                                ]
                              : [
                                  const Color(0xFFDFE0E3),
                                  const Color(0xFFDFE0E3)
                                ],
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            value1nguoi == '個人'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _moreButton2(context),
                      const SizedBox(
                        width: 10,
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
                            ShowHoliday().showHoliday(
                              TANT_CD: sukejuuruSelectedUser?.tantCode ?? '',
                              onSuccess: ((body) {
                                CustomDialog.showCustomDialog(
                                  context: context,
                                  title: '',
                                  body: PopupHienThi(
                                    month: currentDate.month.toString(),
                                    body: body,
                                  ),
                                );
                              }),
                            );
                          },
                          child: const Text(
                            '休日確認',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        leftNextButton(value1nguoi == '個人' ? '先月' : '先週'),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                            right: 8,
                            left: 8,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1990, 3, 5),
                                  maxTime: DateTime(2200, 6, 7),
                                  onChanged: (datePick) {},
                                  onConfirm: (newDate) {
                                if (newDate != currentDate) {
                                  setState(() {
                                    currentDate = newDate;
                                  });

                                  String? tantCode;
                                  if (value1nguoi == '個人') {
                                    tantCode =
                                        sukejuuruSelectedUser?.tantCode ?? '';
                                  }
                                  callGetAnkenCuaMotPhongBan(
                                    kojiGyoSyaCd: phongBanId,
                                    date: currentDate,
                                    selectedTantCode: tantCode,
                                  );
                                  getListPeople(phongBanId);
                                }
                              },
                                  currentTime: currentDate,
                                  locale: LocaleType.jp);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.icCalendar,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  DateFormat(
                                          value1nguoi == '個人'
                                              ? 'yyyy / MM'
                                              : 'yyyy /MM / dd (E)',
                                          'ja')
                                      .format(currentDate)
                                      .toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF77869E),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        rightNextButton(value1nguoi == '個人' ? '翌月' : '翌週'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: value1nguoi == '個人'
                            ? _buildPersonTitleRow(1)
                            : _buildLastRows2(1),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          controller: scrollController2,
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder<dynamic>(
                              future: geAnkenCuaMotPhongBanFuture,
                              builder: (context, response) {
                                return response.data == null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children:
                                            _buildRows(1, scrollController2),
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: value1nguoi == '個人'
                                            ? _buildPersonRows(
                                                _getMonthDaysRow(),
                                                scrollController2)
                                            : _buildRows(
                                                listNhanVien.length + 2,
                                                scrollController2),
                                      );
                              }),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: value1nguoi == '個人'
                            ? _buildPersonTitleRow(1)
                            : _buildLastRows2(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget leftNextButton(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          String? tantCode;
          if (value1nguoi == '個人') {
            currentDate = DateTime(currentDate.year, currentDate.month - 1, 1);
            tantCode = sukejuuruSelectedUser?.tantCode ?? '';
          } else {
            currentDate = currentDate.add(const Duration(days: -7));
          }
          callGetAnkenCuaMotPhongBan(
            kojiGyoSyaCd: phongBanId,
            date: currentDate,
            selectedTantCode: tantCode,
          );
          getListPeople(phongBanId);
        });
      },
      child: Column(
        children: [
          Container(
            width: 36,
            height: 32,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.rectangle),
                fit: BoxFit.cover,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  String? tantCode;
                  if (value1nguoi == '個人') {
                    currentDate =
                        DateTime(currentDate.year, currentDate.month - 1, 1);
                    tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                  } else {
                    currentDate = currentDate.add(const Duration(days: -7));
                  }
                  callGetAnkenCuaMotPhongBan(
                    kojiGyoSyaCd: phongBanId,
                    date: currentDate,
                    selectedTantCode: tantCode,
                  );
                  getListPeople(phongBanId);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.polygonLeft,
                    width: 13,
                    height: 13,
                  ),
                  Image.asset(
                    Assets.polygonLeft,
                    width: 13,
                    height: 13,
                  ),
                ],
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF042C5C),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget rightNextButton(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (value1nguoi == '個人') {
            currentDate = DateTime(currentDate.year, currentDate.month + 1, 1);
          } else {
            currentDate = currentDate.add(const Duration(days: 7));
          }
        });

        String? tantCode;
        if (value1nguoi == '個人') {
          tantCode = sukejuuruSelectedUser?.tantCode ?? '';
        }
        callGetAnkenCuaMotPhongBan(
          kojiGyoSyaCd: phongBanId,
          date: currentDate,
          selectedTantCode: tantCode,
        );
        getListPeople(phongBanId);
      },
      child: Column(
        children: [
          Container(
            width: 36,
            height: 32,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.rectangle),
                fit: BoxFit.cover,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (value1nguoi == '個人') {
                    currentDate =
                        DateTime(currentDate.year, currentDate.month + 1, 1);
                  } else {
                    currentDate = currentDate.add(const Duration(days: 7));
                  }
                });

                String? tantCode;
                if (value1nguoi == '個人') {
                  tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                }
                callGetAnkenCuaMotPhongBan(
                  kojiGyoSyaCd: phongBanId,
                  date: currentDate,
                  selectedTantCode: tantCode,
                );
                getListPeople(phongBanId);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.polygonRight,
                    width: 13,
                    height: 13,
                  ),
                  Image.asset(
                    Assets.polygonRight,
                    width: 13,
                    height: 13,
                  ),
                ],
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF042C5C),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget _moreButton(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      constraints: BoxConstraints(
        minWidth: 250,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      itemBuilder: (context) => listPhongBan.map((item) {
        return PopupMenuItem(
          onTap: () {
            int index = listPhongBan.indexOf(item);
            callGetAnkenCuaMotPhongBan(
                kojiGyoSyaCd: listPhongBan[index]["KOJIGYOSYA_CD"],
                date: currentDate,
                onsuccess: () {});
            setState(() {
              phongBanName = listPhongBan[index]["KOJIGYOSYA_NAME"];
              phongBanId = listPhongBan[index]["KOJIGYOSYA_CD"];
            });
            getListPeople(phongBanId);
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
                      item["KOJIGYOSYA_NAME"].toString(),
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
      offset: const Offset(-35, 35),
      child: Container(
        width: 160,
        height: 37,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                phongBanName,
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
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

  Widget _moreButton2(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {}
        if (number == 2) {}
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listNhanVien.map((item) {
        int index = listNhanVien.indexOf(item);
        return PopupMenuItem(
          onTap: () {
            setState(() {
              sukejuuruSelectedUser = listNhanVien[index];
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
                      item.tantName,
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
      offset: const Offset(0, 40),
      child: Container(
        width: 200,
        height: 37,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              sukejuuruSelectedUser?.tantName ?? '',
              style: const TextStyle(
                color: Color(0xFF999999),
                fontSize: 15,
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

  // TABLE begin
  List<Widget> _buildRows(int count, ScrollController scrollController2) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(8, index, scrollController2),
      );
    });
  }

  // TABLE begin
  List<Widget> _buildPersonRows(int count, ScrollController scrollController2) {
    return List.generate(count, (index) {
      return Row(
        children: _buildPersonCell(7, index, scrollController2),
      );
    });
  }

  int get _getMonthDays =>
      DateTime(currentDate.year, currentDate.month + 1, 0).day;

  int _getMonthDaysRow() {
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    int weekDay = firstDayOfMonth.weekday;
    return ((_getMonthDays + (weekDay == 7 ? 0 : weekDay)) / 7).ceil();
  }

  DateTime _getFirstDayPersonMonth() {
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    int weekDay = firstDayOfMonth.weekday;
    return firstDayOfMonth.subtract(Duration(days: weekDay == 7 ? 0 : weekDay));
  }

  List<String> _listDay() {
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    return List.generate(7, (index) => index).map((value) {
      return DateFormat(('yyyy-MM-dd')).format(
        firstDayOfWeek.add(Duration(days: value)),
      );
    }).toList();
  }

  List<Widget> _buildLastRows2(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildLastRowCells(8, index),
      );
    });
  }

  List<Widget> _buildPersonTitleRow(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildPersonTitleCell(7, index),
      );
    });
  }

  List<String> listDayOfWeek() {
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    return List.generate(8, (index) => index).map((value) {
      if (value == 0) {
        return '';
      }
      return DateFormat(('dd  (E)'), 'ja').format(
        firstDayOfWeek.add(Duration(days: value - 1)),
      );
    }).toList();
  }

  List<String> listPersonDay() {
    List<String> dateSymbols = ['日', '月', '火', '水', '木', '金', '土'];
    return List.generate(7, (index) => index).map((value) {
      return dateSymbols.elementAt(value);
    }).toList();
  }

  List<double> colWidth() {
    return List<double>.generate(10, (int index) {
      if (index == 0) return 200;
      return 150.0;
    }, growable: true);
  }

  List<Widget> _buildCells2(
      int count, int row, ScrollController scrollController2) {
    return List.generate(count, (col) {
      if (row == 0) {
        return Container();
        // return Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(width: 0.5),
        //     color: const Color(0xFFA5A7A9),
        //   ),
        //   alignment: Alignment.center,
        //   width: colWidth()[col],
        //   height: 30,
        //   child: Text(
        //     listDayOfWeek()[col],
        //     style: const TextStyle(
        //       color: Colors.black,
        //       fontSize: 15,
        //       fontWeight: FontWeight.w700,
        //     ),
        //   ),
        // );
      }

      if (row != 0) {
        if (value1nguoi != '個人' && row == 1) {
          if (col == 0) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                color: Colors.white,
              ),
              alignment: Alignment.topLeft,
              width: colWidth()[col],
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Text(
                      phongBanName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 5, 18, 35),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                        size: 40.0,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.white,
            ),
            alignment: Alignment.topLeft,
            width: colWidth()[col],
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: kojiItemsPhongBan(row - 1, col),
              ),
            ),
          );
        }
        if (col == 0) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.white,
            ),
            alignment: Alignment.topLeft,
            width: colWidth()[col],
            height: 400,
            child: GestureDetector(
              onTap: () {
                //group
                if (value1nguoi != '個人') {
                  setState(() {
                    value1nguoi = '個人';
                    sukejuuruSelectedUser = listNhanVien[row - 2];
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: colWidth()[col],
                            child: Text(
                              value1nguoi == '個人'
                                  ? (sukejuuruSelectedUser == null
                                      ? ''
                                      : sukejuuruSelectedUser?.tantName ?? '')
                                  : (listNhanVien.isEmpty
                                      ? ''
                                      : listNhanVien[row - 2]?.tantName ?? ''),
                              style: const TextStyle(
                                  color: Color(0xFF042C5C),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                        size: 40.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              color: Colors.white,
            ),
            alignment: Alignment.topLeft,
            width: colWidth()[col],
            height: 400,
            child: SingleChildScrollView(
              controller: scrollControllerItem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: value1nguoi == '個人'
                    ? kojiItems1Persion(row - 1, col)
                    : kojiItems(row - 1, col),
              ),
            ),
          );
        }
      }

      // don't use
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
        ),
        alignment: Alignment.topLeft,
        width: colWidth()[col],
        height: 400,
        child: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      );
    });
  }

  List<Widget> _buildPersonCell(
      int count, int row, ScrollController scrollController2) {
    return List.generate(count, (col) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: Colors.white,
        ),
        alignment: Alignment.topLeft,
        width: colWidth()[col + 1],
        height: 400,
        child: SingleChildScrollView(
            controller: scrollControllerItem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: kojiItems1Persion(row, col),
            )),
      );
    });
  }

  List<Widget> kojiItems(int row, int col) {
    List<Widget> xxx = [];
    PersonModel nv = listNhanVien[row - 1];
    dynamic selectedUser;
    for (var person in sukejuuruAllUser) {
      if (nv.tantCode == person['TANT_CD']) {
        selectedUser = person;
      }
    }
    if (selectedUser == null) {
      return [];
    }
    _listDay().forEach(
      (element) {
        if (selectedUser != null &&
            selectedUser[element] != null &&
            selectedUser[element].isNotEmpty &&
            element == _listDay()[col - 1]) {
          selectedUser[element].forEach(
            (e) => xxx.addAll([
              kojiItemWithType(
                row - 1,
                col,
                e,
                false,
                selectedUser == null ? null : selectedUser["TANT_CD"],
                e["TAN_EIG_ID"],
              ),
            ]),
          );
          String tantKbnCode = selectedUser['TANT_KBN_CD'] ?? '';
          if (tantKbnCode == '03' || tantKbnCode == '3') {
            if ((selectedUser[element] as List).isNotEmpty) {
              var item = selectedUser[element].first;
              xxx.addAll(_saleItems(col, row, selectedUser, item, element));
            }
          }
        }
      },
    );
    xxx.add(
      insert(
        dateSelected: DateTime.parse(_listDay()[col - 1]),
        JYOKEN_CD: selectedUser["TANT_CD"],
        isPhongBan: false,
      ),
    );
    return xxx;
  }

  List<Widget> _saleItems(
      int col, int row, dynamic user, dynamic item, String date) {
    DateTime dateTime = DateTime.parse(date);
    bool isShitami = item['HOMON_SBT'] == '01' || item['HOMON_SBT'] == '1';
    String jyucyuId = item['JYUCYU_ID'] ?? '';
    String jinin =
        isShitami ? item['SITAMI_JININ'] ?? '' : item['KOJI_JININ'] ?? '';
    String kansanPoint = isShitami
        ? item['SITAMI_KANSAN_POINT'] ?? ''
        : item['KOJI_KANSAN_POINT'] ?? '';
    String tantName = user['TANT_NAME'] ?? '';
    String dailySales = user['DAYLY_SALES'] ?? '0';
    String monthlySales = user['MONTHLY_SALES'] ?? '0';
    String sumItakuhi = item['SUM_ITAKUHI'] ?? '0';
    String sumItakuhiBetweenDate = item['SUM_ITAKUHI_BETWEEN_DATE'] ?? '0';
    String percentItakuhi = item['PERCENT_ITAKUHI'] != null
        ? item['PERCENT_ITAKUHI'].toString()
        : '0';

    return [
      Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Container(
          width: colWidth()[col],
          color: const Color(0x331e73d4),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: Container(
                            // color: backgroundKojiItem(e),
                            // color: getTitleColorByText(
                            //   text: e["KBNMSAI_NAME"] ?? '',
                            // ),
                            color: const Color(0xff1e73d4),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                '日予実',
                                style: TextStyle(
                                  // color: kojiColorWithType(e),
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                            text:
                                '${dateTime.month}/${dateTime.day} $tantName: 実$sumItakuhi円/予$dailySales円',
                            style: const TextStyle(
                              color: Color(0xff1e73d4),
                            )),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Container(
          width: colWidth()[col],
          color: const Color(0x33e0c610),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: Container(
                            // color: backgroundKojiItem(e),
                            // color: getTitleColorByText(
                            //   text: e["KBNMSAI_NAME"] ?? '',
                            // ),
                            color: const Color(0xffe0c610),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                '計予実',
                                style: TextStyle(
                                  // color: kojiColorWithType(e),
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                            text:
                                '${dateTime.month}/${dateTime.day} $tantName: 実$sumItakuhiBetweenDate円/予$monthlySales円($percentItakuhi%)',
                            style: const TextStyle(
                              color: Color(0xff1e73d4),
                            )),
                      ]),
                ),
              ],
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> kojiItems1Persion(int row, int col) {
    List<Widget> widgets = [];
    DateTime date =
        _getFirstDayPersonMonth().add(Duration(days: (row * 7) + col));
    String dateStr = DateFormat('yyyy-MM-dd').format(date);
    String dateVisible = DateFormat('MM/dd').format(date);
    widgets.add(Text(
      dateVisible,
      style: const TextStyle(fontSize: 10),
    ));

    dynamic selectedUser;
    for (var person in sukejuuruAllUser) {
      if (sukejuuruSelectedUser?.tantCode == person['TANT_CD']) {
        selectedUser = person;
      }
    }

    if (selectedUser != null &&
        selectedUser[dateStr] != null &&
        selectedUser[dateStr].isNotEmpty) {
      selectedUser[dateStr].forEach(
        (e) => widgets.addAll([
          kojiItemWithType(
            row,
            col,
            e,
            false,
            selectedUser["TANT_CD"],
            e["TAN_EIG_ID"],
          )
        ]),
      );

      String tantKbnCode = sukejuuruSelectedUser?.tantKbnCode ?? '';
      if (tantKbnCode == '03' || tantKbnCode == '3') {
        if ((selectedUser[dateStr] as List).isNotEmpty) {
          var item = selectedUser[dateStr].first;
          widgets.addAll(_saleItems(col, row, selectedUser, item, dateStr));
        }
      }
    }

    if (selectedUser != null) {
      widgets.add(
        insert(
          dateSelected:
              _getFirstDayPersonMonth().add(Duration(days: (row * 7) + col)),
          JYOKEN_CD: selectedUser["TANT_CD"],
          isPhongBan: false,
        ),
      );
    }

    return widgets;
  }

  List<Widget> kojiItemsPhongBan(int row, int col) {
    List<Widget> xxx = [];

    _listDay().forEach(
      (element) {
        if (sukejuuruPhongBan != null &&
            sukejuuruPhongBan[element] != null &&
            sukejuuruPhongBan[element].isNotEmpty &&
            element == _listDay()[col - 1]) {
          sukejuuruPhongBan[element].forEach(
            (e) => xxx.addAll([
              kojiItemWithType(
                row,
                col,
                e,
                true,
                sukejuuruPhongBan == null
                    ? null
                    : sukejuuruPhongBan["KOJIGYOSYA_CD"],
                e["TAN_EIG_ID"],
              )
            ]),
          );
        }
      },
    );
    xxx.add(
      insert(
        dateSelected: DateTime.parse(_listDay()[col - 1]),
        JYOKEN_CD: sukejuuruPhongBan["KOJIGYOSYA_CD"],
        isPhongBan: true,
      ),
    );
    return xxx;
  }

  Color kojiColorWithType(e) {
    switch (e['TYPE']) {
      case 1:
        return const Color.fromARGB(255, 242, 223, 222);
      case 2:
        return Colors.green;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.yellow;
      case 5:
        return Colors.blue;
      case 6:
        return Colors.pinkAccent;
      case 7:
        return Colors.white;
      case 8:
        return Colors.teal;
      default:
        return const Color.fromARGB(255, 242, 223, 222);
    }
  }

  Color backgroundKojiItem(e) {
    switch (e['TYPE']) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.teal;
      case 3:
        return Colors.indigoAccent;
      case 4:
        return Colors.lightBlue;
      case 5:
        return Colors.brown;
      case 6:
        return Colors.white;
      case 7:
        return Colors.blue;
      case 8:
        return Colors.yellow;
      default:
        return const Color.fromARGB(255, 195, 161, 172);
    }
  }

  Color getTitleColorByText({required String text}) {
    switch (text) {
      case 'ネット工事':
        return const Color(0xFF2ea14d);
      case 'ネット下見':
        return const Color(0xfffa2f31);
      case '日予実':
        return const Color(0xff1e73d4);
      case '計予実':
        return const Color(0xffe0c610);
      case '工事打診':
        return const Color(0xff8fd629);
      case '下見打診':
        return const Color(0xfff595a9);
      case '追加希望':
        return const Color(0xfff6b704);
      case '追加STOP':
        return const Color(0xfff60404);
      case 'STOP':
        return const Color(0xfff60404);
      case '休み':
        return const Color(0xfff60404);
      case '重要':
        return const Color(0xfff60404);
      case '!! 重要 !!':
        return const Color(0xfff60404);
      case '月次':
        return const Color(0xff2893b5);
      case '営業下見':
        return const Color(0xfffa2f31);
      case '営業工事':
        return const Color(0xfffa2f31);
      case 'メモ':
        return const Color(0xFF2ea14d);
      default:
        return Colors.grey;
    }
  }

  Color getBackgroundColorByText({required String text}) {
    switch (text) {
      case 'ネット工事':
        return const Color.fromARGB(255, 125, 228, 152);
      case 'ネット下見':
        return const Color.fromARGB(255, 234, 149, 150);
      case '日予実':
        return const Color.fromARGB(255, 109, 155, 209);
      case '計予実':
        return const Color.fromARGB(255, 214, 203, 114);
      case '工事打診':
        return const Color.fromARGB(255, 173, 209, 122);
      case '下見打診':
        return const Color.fromARGB(255, 234, 149, 150);
      case '追加希望':
        return const Color.fromARGB(255, 228, 204, 136);
      case '追加STOP':
        return const Color.fromARGB(255, 234, 149, 150);
      case 'STOP':
        return const Color.fromARGB(255, 234, 149, 150);
      case '休み':
        return const Color.fromARGB(255, 234, 149, 150);
      case '重要':
        return const Color.fromARGB(255, 234, 149, 150);
      case '!! 重要 !!':
        return const Color.fromARGB(255, 234, 149, 150);
      case '月次':
        return const Color.fromARGB(255, 113, 161, 176);
      case '営業下見':
        return const Color.fromARGB(255, 234, 149, 150);
      case '営業工事':
        return const Color.fromARGB(255, 234, 149, 150);
      case 'メモ':
        return const Color.fromARGB(255, 126, 211, 149);
      default:
        return const Color.fromARGB(255, 213, 208, 208);
    }
  }

  String textKojiItem(e) {
    switch (e['TYPE']) {
      case 1:
        return "1";
      case 2:
        return "2";
      case 3:
        return "3";
      case 4:
        return "4";
      case 5:
        return "5";
      case 6:
        return "6";
      case 7:
        return "7";
      case 8:
        return "8";
      default:
        return "";
    }
  }

  String getTypeItemLichTrinh(String kbnCode) {
    switch (kbnCode) {
      case '01':
      case '10':
      case '16':
        return 'anken';
      case '05':
        return 'lichtrinh';
      case '06':
        return 'memo';
      default:
        return '';
    }
  }

  Widget kojiItemWithType(int row, int col, e, bool isPhongBanData,
      String? tantCd, String? TAN_EIG_ID) {
    bool isShitami = e['HOMON_SBT'] == '01' || e['HOMON_SBT'] == '1';
    String jyucyuId = e['JYUCYU_ID'] ?? '';
    String jinin = isShitami ? e['SITAMI_JININ'] ?? '' : e['KOJI_JININ'] ?? '';
    String kansanPoint = isShitami
        ? e['SITAMI_KANSAN_POINT'] ?? ''
        : e['KOJI_KANSAN_POINT'] ?? '';
    String naiyo = e['NAIYO'] ?? '';
    String setsakiAddress = e['SETSAKI_ADDRESS'] ?? '';
    String kbnmsaiName = e['KBNMSAI_NAME'] ?? '';
    if (kbnmsaiName == '日予実' || kbnmsaiName == '計予実') {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        if (isPhongBanData) {
          String type = getTypeItemLichTrinh(e["KBN_CD"]);

          switch (type) {
            case ("lichtrinh"):
              {
                sukejuuruAllUser;

                sukejuuruPhongBan;

                sukejuuruSelectedUser;
                isPhongBanData;
                e;

                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: Page721(
                    HOMON_SBT: e["HOMON_SBT"],
                    JYUCYU_ID: e["JYUCYU_ID"],
                    setsakiAddress: e['SETSAKI_ADDRESS'] ?? '',
                    setsakiName: e['SETSAKI_NAME'] ?? '',
                    kojiItem: e['KOJI_ITEM'] ?? '',
                    onSuccessUpdate: () {
                      String? tantCode;
                      if (value1nguoi == '個人') {
                        tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                      }
                      callGetAnkenCuaMotPhongBan(
                        kojiGyoSyaCd: phongBanId,
                        date: currentDate,
                        selectedTantCode: tantCode,
                      );
                      getListPeople(phongBanId);
                    },
                    onBack: () {
                      getData();
                    },
                  ),
                );
              }
              break;
            case ("anken"):
              {
                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: Page723EditShowAnken(
                    KBNMSAI_NAME: e["KBNMSAI_NAME"],
                    TAN_EIG_ID: TAN_EIG_ID ?? '',
                    onUpdateAnkenSuccessfull: () {
                      String? tantCode;
                      if (value1nguoi == '個人') {
                        tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                      }
                      callGetAnkenCuaMotPhongBan(
                        kojiGyoSyaCd: phongBanId,
                        date: currentDate,
                        selectedTantCode: tantCode,
                      );
                      getListPeople(phongBanId);
                    },
                    initialDate: currentDate,
                    TANT_CD: tantCd ?? '',
                    isPhongBan: isPhongBanData,
                    onBack: () {
                      getData();
                    },
                  ),
                );
              }
              break;
            case ("memo"):
              {
                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: Page724Update(
                    initialDate: DateFormat("yyyy-MM-dd").parse(e['YMD']),
                    TAN_CAL_ID: e['TAN_CAL_ID'],
                    kbnmsaiCode: e['KBNMSAI_CD'],
                    checkedValue: e['ALL_DAY_FLG'] == '1' ? true : false,
                    NAIYO: e['NAIYO'] ?? '',
                    END_TIME: e['END_TIME'],
                    START_TIME: e['START_TIME'],
                    JYOKEN_CD: e['JYOKEN_CD'],
                    isPhongBan: isPhongBanData,
                    onSuccess: (() {
                      String? tantCode;
                      if (value1nguoi == '個人') {
                        tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                      }
                      callGetAnkenCuaMotPhongBan(
                        kojiGyoSyaCd: phongBanId,
                        date: currentDate,
                        selectedTantCode: tantCode,
                      );
                      getListPeople(phongBanId);
                    }),
                    onBack: () {
                      getData();
                    },
                  ),
                );
              }
              break;

            default:
              break;
          }
        } else {
          String type = getTypeItemLichTrinh(e["KBN_CD"] ?? '');

          switch (type) {
            case ("lichtrinh"):
              {
                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: Page721(
                    JYUCYU_ID: e["JYUCYU_ID"],
                    // KBNMSAI_NAME: e["KBNMSAI_NAME"],
                    HOMON_SBT: e["HOMON_SBT"],
                    setsakiAddress: e['SETSAKI_ADDRESS'] ?? '',
                    setsakiName: e['SETSAKI_NAME'] ?? '',
                    kojiItem: e['KOJI_ITEM'] ?? '',
                    onSuccessUpdate: () {
                      String? tantCode;
                      if (value1nguoi == '個人') {
                        tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                      }
                      callGetAnkenCuaMotPhongBan(
                        kojiGyoSyaCd: phongBanId,
                        date: currentDate,
                        selectedTantCode: tantCode,
                      );
                      getListPeople(phongBanId);
                    },
                    onBack: () {
                      getData();
                    },
                  ),
                );
              }
              break;
            case ("anken"):
              {
                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: Page723EditShowAnken(
                    KBNMSAI_NAME: e["KBNMSAI_NAME"],
                    TAN_EIG_ID: TAN_EIG_ID ?? '',
                    initialDate: currentDate,
                    TANT_CD: tantCd ?? '',
                    isPhongBan: isPhongBanData,
                    onUpdateAnkenSuccessfull: () {
                      String? tantCode;
                      if (value1nguoi == '個人') {
                        tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                      }
                      callGetAnkenCuaMotPhongBan(
                        kojiGyoSyaCd: phongBanId,
                        date: currentDate,
                        selectedTantCode: tantCode,
                      );
                      getListPeople(phongBanId);
                    },
                    onBack: () {
                      getData();
                    },
                  ),
                );
              }
              break;
            case ("memo"):
              {
                CustomDialog.showCustomDialog(
                  context: context,
                  title: '',
                  body: Page724Update(
                    initialDate: DateTime.parse(e['YMD']),
                    TAN_CAL_ID: e['TAN_CAL_ID'],
                    kbnmsaiCode: e['KBNMSAI_CD'],
                    checkedValue: e['ALL_DAY_FLG'] == '1' ? true : false,
                    NAIYO: e['NAIYO'] ?? '',
                    END_TIME: e['END_TIME'],
                    START_TIME: e['START_TIME'],
                    JYOKEN_CD: e['JYOKEN_CD'],
                    isPhongBan: isPhongBanData,
                    onSuccess: (() {
                      String? tantCode;
                      if (value1nguoi == '個人') {
                        tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                      }
                      callGetAnkenCuaMotPhongBan(
                        kojiGyoSyaCd: phongBanId,
                        date: currentDate,
                        selectedTantCode: tantCode,
                      );
                      getListPeople(phongBanId);
                    }),
                    onBack: () {
                      getData();
                    },
                  ),
                );
              }
              break;

            default:
              break;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Container(
          width: colWidth()[col],
          // color: getBackgroundColorByText(
          //   text: e["KBNMSAI_NAME"] ?? '',
          // ),
          color: e["YOBIKOMOKU2_KBN2"] != null
              ? Color.fromARGB(
                  int.parse(e["YOBIKOMOKU2_KBN2"].toString().split(", ")[0]),
                  int.parse(e["YOBIKOMOKU2_KBN2"].toString().split(", ")[1]),
                  int.parse(e["YOBIKOMOKU2_KBN2"].toString().split(", ")[2]),
                  int.parse(e["YOBIKOMOKU2_KBN2"].toString().split(", ")[3]),
                )
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                e['SITAMIHOMONJIKAN'] != '' &&
                        e['SITAMIHOMONJIKAN_END'] != '' &&
                        e['SITAMIHOMONJIKAN'] != null &&
                        e['SITAMIHOMONJIKAN_END'] != null
                    ? Text(
                        "${e['SITAMIHOMONJIKAN']} - ${e['SITAMIHOMONJIKAN_END']}",
                        style: const TextStyle(fontSize: 10),
                      )
                    : (e['START_TIME'] != null && e['END_TIME'] != null)
                        ? Text(
                            "${e['START_TIME']} - ${e['END_TIME']}",
                            style: const TextStyle(fontSize: 10),
                          )
                        : Container(),
                RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        WidgetSpan(
                          child: Container(
                            // color: backgroundKojiItem(e),
                            // color: getTitleColorByText(
                            //   text: e["KBNMSAI_NAME"] ?? '',
                            // ),
                            color: Color(int.parse(
                                e["YOBIKOMOKU1_KBN2"] ?? '0xffffffff')),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 2,
                              ),
                              child: Text(
                                kbnmsaiName,
                                style: const TextStyle(
                                  // color: kojiColorWithType(e),
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        jyucyuId.isNotEmpty
                            ? TextSpan(
                                text:
                                    '\n<<${jyucyuId.length == 10 ? jyucyuId : jyucyuId.substring(0, 10)}>>・$jinin 人 $kansanPoint 時間\n')
                            : const TextSpan(),
                        TextSpan(
                          text: setsakiAddress,
                        ),
                        TextSpan(
                          text: naiyo,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // String datetimeToHHmm(String datetimeString) {
  //   return datetimeString.split(" ")[1];
  // }

  Widget insert({
    required DateTime dateSelected,
    required String JYOKEN_CD,
    required bool isPhongBan,
  }) {
    DateTime newDate = DateFormat("yyyy-MM-dd").parse(
        "${dateSelected.year}-${dateSelected.month}-${dateSelected.day}");
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              CustomDialog.showCustomDialog(
                context: context,
                title: '',
                body: Page723(
                  initialDate: newDate,
                  TANT_CD: JYOKEN_CD,
                  isPhongBan: isPhongBan,
                  onCreateAnkenSuccessfull: () {
                    String? tantCode;
                    if (value1nguoi == '個人') {
                      tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                    }
                    callGetAnkenCuaMotPhongBan(
                      kojiGyoSyaCd: phongBanId,
                      date: currentDate,
                      selectedTantCode: tantCode,
                    );
                    getListPeople(phongBanId);
                  },
                ),
              );
            },
            child: const Icon(
              Icons.add_circle,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              CustomDialog.showCustomDialog(
                context: context,
                title: '',
                body: Page724Create(
                  JYOKEN_CD: JYOKEN_CD,
                  isPhongBan: isPhongBan,
                  initialDate: newDate,
                  onSuccess: () {
                    String? tantCode;
                    if (value1nguoi == '個人') {
                      tantCode = sukejuuruSelectedUser?.tantCode ?? '';
                    }
                    callGetAnkenCuaMotPhongBan(
                      kojiGyoSyaCd: phongBanId,
                      date: currentDate,
                      selectedTantCode: tantCode,
                    );
                    getListPeople(phongBanId);
                  },
                ),
              );
            },
            child: const Icon(
              Icons.insert_drive_file_outlined,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildLastRowCells(int count, int row) {
    return List.generate(count, (col) {
      if (row == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFFA5A7A9),
          ),
          alignment: Alignment.center,
          width: colWidth()[col],
          height: 30,
          child: Text(
            listDayOfWeek()[col],
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
        alignment: Alignment.topLeft,
        width: colWidth()[col],
        height: 200,
        child: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
      );
    });
  }

  List<Widget> _buildPersonTitleCell(int count, int row) {
    return List.generate(count, (col) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          color: const Color(0xFFA5A7A9),
        ),
        alignment: Alignment.center,
        width: colWidth()[col + 1],
        height: 30,
        child: Text(
          listPersonDay()[col],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    });
  }
}
