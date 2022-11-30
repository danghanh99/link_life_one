import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/riyuu_ko_nyuu_gamen.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/shared/custom_button.dart';
import '../page7/component/dialog.dart';

class ShitamiHoukoku extends StatefulWidget {
  final String JYUCYU_ID;
  const ShitamiHoukoku({super.key, required this.JYUCYU_ID});

  @override
  State<ShitamiHoukoku> createState() => _ShitamiHoukokuState();
}

class _ShitamiHoukokuState extends State<ShitamiHoukoku> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80,
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
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 247, 240, 240))),
                      width: 200,
                      child: CustomButton(
                        color: Colors.white70,
                        onClick: () {},
                        name: '下見報告',
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
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '簡易的に下見報告在を行う',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Text('見積書作成は新基幹システムから作成を行ってください',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShashinTeishuutsuGamenPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  height: 50,
                  width: 400,
                  child: const Center(
                    child: Text(
                      '写真のみシステムに送信する',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  height: 1,
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  CustomDialog.showCustomDialog(
                    context: context,
                    title: '',
                    body: RiyuuKoNyuuGamen(
                      index: 2,
                      JYUCYU_ID: widget.JYUCYU_ID,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  height: 50,
                  width: 400,
                  child: const Center(
                    child: Text(
                      '見積作成逕延報告在を行う',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  CustomDialog.showCustomDialog(
                    context: context,
                    title: '',
                    body: RiyuuKoNyuuGamen(
                      index: 3,
                      JYUCYU_ID: widget.JYUCYU_ID,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  height: 50,
                  width: 400,
                  child: const Center(
                    child: Text(
                      '下見の桔果、キャンセル の報告',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        child: CupertinoAlertDialog(
                          content: const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "依頼書の明細内に含む項目のみで工事に進めます。注文の案内案内などを行いませんがこのまま報告してよろしいですか？",
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
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ShashinTeishuutsuGamenPage(),
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
                  width: 400,
                  child: const Center(
                    child: Text(
                      '見積書なしで、工事へ進める報告',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
