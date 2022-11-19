import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/shared/custom_button.dart';

import '../../shared/assets.dart';

class HoujinKanryousho extends StatefulWidget {
  final DateTime? initialDate;
  const HoujinKanryousho({super.key, this.initialDate});

  @override
  State<HoujinKanryousho> createState() => _HoujinKanryoushoState();
}

class _HoujinKanryoushoState extends State<HoujinKanryousho> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
                              color: const Color.fromARGB(255, 247, 240, 240))),
                      width: 200,
                      child: CustomButton(
                        color: Colors.white70,
                        onClick: () {},
                        name: '法人完了書',
                        textStyle: const TextStyle(
                          color: Color(0xFF042C5C),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
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
                height: 100,
              ),
              Container(
                width: size.width - 100,
                height: 300,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    left: 40,
                  ),
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Spacer(),
              sendButton2(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 150,
            child: const Center(
              child: Text(
                '登録',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sendButton2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                'カメラ起動',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                '写真の添付',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                '登録',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
