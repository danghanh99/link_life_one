import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/screen/page3/shoudaku_shoukisai.dart';
import 'package:link_life_one/shared/custom_button.dart';

import '../../shared/assets.dart';

class KojiHoukoku extends StatefulWidget {
  final DateTime? initialDate;
  const KojiHoukoku({super.key, this.initialDate});

  @override
  State<KojiHoukoku> createState() => _KojiHoukokuState();
}

class _KojiHoukokuState extends State<KojiHoukoku> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 70,
                        child: TextLineDown(
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF042C5C),
                              fontWeight: FontWeight.w500),
                          text: '戻る',
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 247, 240, 240))),
                        width: 200,
                        child: CustomButton(
                          color: Colors.white70,
                          onClick: () {},
                          name: '工事報告',
                          textStyle: const TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftSide(),
                    rightSide(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leftSide(),
                    rightSide(),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                sendButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rightSide() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: 200,
          height: 160,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '施工前写真',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '添付後サムネイルを表示',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 160,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '施工前写真',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '添付後サムネイルを表示',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const Text(
                'その他写真を添付',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '【施工商品情報】',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'メーカー: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: textUnderline(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '品番: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: textUnderline(),
              ),
            ],
          ),
        ),
        const Text(
          '【施工商品情報】',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'メーカー: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: textUnderline(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '品番: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: textUnderline(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              const Text(
                '建築形態',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                width: 10,
              ),
              _dropDownButton(context, "戶建て"),
            ],
          ),
        ),
      ],
    );
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  width: double.infinity,
                  child: CupertinoAlertDialog(
                    title: const Text(
                      "この工事を設置不可で登録を行います。\n(元に戻せません)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        "操作は必ず本部へ電話報告後に行ってください。\nまたサイボウズの設置不可アプリ登録は必ず行ってください。",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context); //close Dialog
                          },
                          child: const Text(
                            '戻る',
                            style: TextStyle(
                              color: Color(0xFFEB5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); //close Dialog
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShashinTeishuutsuGamenPage(
                                initialDate: widget.initialDate,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'はい',
                          style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 150,
            child: const Center(
              child: Text(
                '設置不可',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoudakuShoukisai(
                  initialDate: widget.initialDate,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 150,
            child: const Center(
              child: Text(
                '次へ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textUnderline() {
    return const TextField(
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5, bottom: 5),
        isDense: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      cursorColor: Colors.black,
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
                "戶建て",
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
                "戶建て",
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(5, 32),
      child: Container(
        width: 130,
        height: 30,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
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
      ),
    );
  }
}
