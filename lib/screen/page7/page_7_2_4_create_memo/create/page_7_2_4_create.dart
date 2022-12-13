import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/sukejuuru_page_api/memo/create_memo.dart';

import '../../../../components/custom_text_field.dart';
import '../../../../components/toast.dart';
import '../../../../shared/assets.dart';

class Page724Create extends StatefulWidget {
  final DateTime initialDate;
  final String JYOKEN_CD;
  final bool isPhongBan;
  final Function() onSuccess;
  const Page724Create({
    required this.initialDate,
    required this.JYOKEN_CD,
    required this.isPhongBan,
    required this.onSuccess,
    Key? key,
  }) : super(key: key);

  @override
  State<Page724Create> createState() => _Page724CreateState();
}

class _Page724CreateState extends State<Page724Create> {
  TextEditingController dateinput = TextEditingController();
  List<String> listDateTime1 = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "00:00",
  ];
  List<String> listDateTime2 = [
    "01:00",
    "02:00",
    "03:00",
    "04:00",
    "05:00",
    "06:00",
    "07:00",
    "08:00",
    "09:00",
    "10:00",
    "11:00",
    "12:00",
    "13:00",
    "14:00",
    "15:00",
    "16:00",
    "17:00",
    "18:00",
    "19:00",
    "20:00",
    "21:00",
    "22:00",
    "23:00",
    "00:00",
  ];
  late DateTime date;
  late bool checkedValue;
  String kara = "01:00";
  String made = "23:00";
  List<dynamic> pullDownMemo = [];
  dynamic pullDownSelected;

  @override
  void initState() {
    date = widget.initialDate;
    checkedValue = false;
    callGetListPullDownMemo();
    super.initState();
  }

  Future<void> callGetListPullDownMemo() async {
    final result = await CreateMemo().pullDownMemo(
        TAN_CAL_ID: '',
        onSuccess: () {},
        onFailed: () {
          CustomToast.show(context, message: "Failed to get memo pulldown");
        });
    setState(() {
      pullDownMemo = result == null ? [] : result['pullDown'];
      pullDownSelected = pullDownMemo.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 650,
      child: Column(
        children: [
          Container(
            height: 50,
            color: const Color(0xFFFFFA7A),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'メモ登録',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '概要',
                          style: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    _moreButton(context),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '日時',
                          style: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat('yyyy年MM月dd日(E)', 'ja')
                            .format(widget.initialDate)
                            .toString(),
                        style: const TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                      width: 5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _moreButton2(context),
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: Colors.blue,
                                  checkColor: Colors.white,
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = newValue ?? true;
                                    });
                                  },
                                ),
                                const Text(
                                  '終日',
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          '~',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _moreButton3(context),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 130,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '内容',
                          style: TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 420,
                      child: CustomTextField(
                        fillColor: const Color(0xFFF5F6F8),
                        hint: '',
                        type: TextInputType.text,
                        controller: dateinput,
                        onChanged: (text) {},
                        maxLines: 6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 37,
                decoration: BoxDecoration(
                  color: const Color(0xFF6C8EDA),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: TextButton(
                  onPressed: () {
                    CreateMemo().createMemo(
                        KBNMSAI_CD: pullDownSelected['KBNMSAI_CD'],
                        JYOKEN_CD: widget.JYOKEN_CD,
                        JYOKEN_SYBET_FLG: widget.isPhongBan ? '1' : '0',
                        YMD: widget.initialDate,
                        TAG_KBN: '06',
                        MEMO_CD: pullDownSelected['KBNMSAI_CD'],
                        NAIYO: dateinput.text,
                        START_TIME: kara,
                        END_TIME: made,
                        ALL_DAY_FLG: checkedValue ? '1' : '0',
                        onSuccess: () {
                          Navigator.pop(context);
                          CustomToast.show(context,
                              message: "Create successfull",
                              backGround: Colors.green);
                          widget.onSuccess.call();
                        },
                        onFailed: () {
                          CustomToast.show(context, message: 'Create error');
                        });
                  },
                  child: const Text(
                    '登録',
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
                width: 10,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 120,
                height: 37,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'キャンセル',
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
    );
  }

  Widget _moreButton(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => pullDownMemo.map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              pullDownSelected = item;
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
                      item['KBNMSAI_NAME'],
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
              pullDownSelected != null ? pullDownSelected['KBNMSAI_NAME'] : '',
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

  Widget _moreButton2(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listDateTime1.map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              kara = item;
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
                      item.toString(),
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
              kara,
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

  Widget _moreButton3(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {},
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listDateTime2.map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              made = item;
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
                      item.toString(),
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
              made,
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
}
