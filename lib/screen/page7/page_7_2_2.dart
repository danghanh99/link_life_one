import 'package:flutter/material.dart';

import '../../components/custom_text_field.dart';
import '../../shared/assets.dart';
import '../../shared/validator.dart';

class Page722 extends StatefulWidget {
  const Page722({
    Key? key,
  }) : super(key: key);

  @override
  State<Page722> createState() => _Page722State();
}

class _Page722State extends State<Page722> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late bool checkedValue;

  late String nettoKouJi;
  late String kaigiKara;
  late String kaigiMade;

  @override
  void initState() {
    checkedValue = true;
    nettoKouJi = 'ネット工事';
    kaigiKara = '10：00';
    kaigiMade = '12：00';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: 650,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 50,
              color: const Color(0xFF6F86D6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ネット工事(アポ済み)',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 40,
              color: const Color(0xFF91B1F9),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '更新情報：神奈川営業所事務　テキスト氏名　2022/01/19(水) HH:MM',
                        style: TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 130,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'タグ',
                            style: TextStyle(
                              color: Color(0xFF042C5C),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      _moreButton(context),
                      // const Spacer(),
                      const SizedBox(
                        width: 160,
                      ),
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
                            'アポイント済み',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '2022年01月19日(水)',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: SizedBox(
                          width: 130,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '人数・所用時間',
                              style: TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: size.width / 2 - 80,
                            width: 80,
                            child: CustomTextField(
                              validator: _validateNumber,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.number,
                              onChanged: (text) {},
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '人',
                              style: TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      ),
                      // const Spacer(),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // width: size.width / 2 - 80,
                            width: 80,
                            child: CustomTextField(
                              validator: _validateNumber2,
                              fillColor: const Color(0xFFF5F6F8),
                              hint: '',
                              type: TextInputType.number,
                              onChanged: (text) {},
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              '時間',
                              style: TextStyle(
                                color: Color(0xFF042C5C),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'コメント',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CustomTextField(
                    fillColor: const Color(0xFFF5F6F8),
                    hint: '',
                    type: TextInputType.emailAddress,
                    onChanged: (text) {},
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            // Expanded(child: Container()),
            SizedBox(
              height: 20,
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
                      if (_formKey.currentState?.validate() == true) {
                        print("okkkkkk");
                      }
                    },
                    child: const Text(
                      '更新',
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
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA0A0A0),
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
      ),
    );
  }

  Widget _moreButton(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {
          setState(() {
            nettoKouJi = 'ネット工事';
          });
        }
        if (number == 2) {
          setState(() {
            nettoKouJi = 'ネット下見';
          });
        }
        if (number == 3) {
          setState(() {
            nettoKouJi = '法人工事';
          });
        }
        if (number == 4) {
          setState(() {
            nettoKouJi = '法人下見';
          });
        }
        if (number == 5) {
          setState(() {
            nettoKouJi = '工事打診';
          });
        }
        if (number == 6) {
          setState(() {
            nettoKouJi = '下見打診';
          });
        }
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
                "ネット工事",
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
                "ネット下見",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 3,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "法人工事",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 4,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "法人下見",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 5,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "工事打診",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 6,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "下見打診",
              ),
            ],
          ),
        ),
      ],
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
              nettoKouJi,
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
      onSelected: (number) {
        if (number == 1) {
          setState(() {
            kaigiKara = '9:00';
          });
        }
        if (number == 2) {
          setState(() {
            kaigiKara = '9:30';
          });
        }
        if (number == 3) {
          setState(() {
            kaigiKara = '10:00';
          });
        }
        if (number == 4) {
          setState(() {
            kaigiKara = '10:30';
          });
        }
        if (number == 5) {
          setState(() {
            kaigiKara = '11:00';
          });
        }
        if (number == 6) {
          setState(() {
            kaigiKara = '11:30';
          });
        }
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
                "9:00",
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
                "9:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 3,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 4,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 5,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 6,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:30",
              ),
            ],
          ),
        ),
      ],
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
              kaigiKara,
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
      onSelected: (number) {
        if (number == 1) {
          setState(() {
            kaigiMade = '9:00';
          });
        }
        if (number == 2) {
          setState(() {
            kaigiMade = '9:30';
          });
        }
        if (number == 3) {
          setState(() {
            kaigiMade = '10:00';
          });
        }
        if (number == 4) {
          setState(() {
            kaigiMade = '10:30';
          });
        }
        if (number == 5) {
          setState(() {
            kaigiMade = '11:00';
          });
        }
        if (number == 6) {
          setState(() {
            kaigiMade = '11:30';
          });
        }
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
                "9:00",
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
                "9:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 3,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 4,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "10:30",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 5,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:00",
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          height: 25,
          padding: const EdgeInsets.only(right: 0, left: 10),
          value: 6,
          child: Row(
            children: const [
              SizedBox(
                width: 14,
              ),
              Text(
                "11:30",
              ),
            ],
          ),
        ),
      ],
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
              kaigiMade,
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

  String? _validateNumber(String? input) {
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return 'Only number';
    }
  }

  String? _validateNumber2(String? input) {
    if (Validator.onlyNumber(input!)) {
      return null;
    } else {
      return 'Only number';
    }
  }
}
