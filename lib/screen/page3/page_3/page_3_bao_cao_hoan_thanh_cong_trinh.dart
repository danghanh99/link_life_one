import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/models/koji.dart';
import 'package:link_life_one/screen/page3/page_3/components/logout_widget.dart';
import 'package:link_life_one/screen/page3/page_3_1_yeu_cau_bieu_mau_page.dart';
import '../../../api/KojiPageApi/get_list_koji_api.dart';
import '../../../shared/assets.dart';
import 'components/title_widget.dart';

class Page3BaoCaoHoanThanhCongTrinh extends StatefulWidget {
  final DateTime? initialDate;
  const Page3BaoCaoHoanThanhCongTrinh({
    this.initialDate,
    Key? key,
  }) : super(key: key);

  @override
  State<Page3BaoCaoHoanThanhCongTrinh> createState() =>
      _Page3BaoCaoHoanThanhCongTrinhState();
}

class _Page3BaoCaoHoanThanhCongTrinhState
    extends State<Page3BaoCaoHoanThanhCongTrinh> {
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
    '12',
    '1234',
  ];
  DateTime date = DateTime.now();

  @override
  void initState() {
    date = widget.initialDate ?? DateTime.now();
    super.initState();
    callGetListKojiApi(inputDate: date);
  }

  Future<List<Koji>> callGetListKojiApi({DateTime? inputDate}) async {
    return await GetListKojiApi().getListKojiApi(date: inputDate ?? date);
  }

  String formatJikan({required String? jikan}) {
    if (jikan == null || jikan == '' || jikan.length != 4) return '';
    jikan = "${jikan[0]}${jikan[1]}:${jikan[2]}${jikan[3]}";
    return jikan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            const LogoutWidget(),
            const TitleWidget(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 5,
                ),
                leftNextButton('先週'),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    right: 8,
                    left: 8,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2100));
                      if (picked != null && picked != date) {
                        setState(() {
                          date = picked;
                        });
                        callGetListKojiApi(inputDate: picked);
                      }
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icCalendar,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          DateFormat('yyyy /MM / dd (E)', 'ja')
                              .format(date)
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
                rightNextButton('翌週'),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 400,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: FutureBuilder<List<Koji>>(
                  future: callGetListKojiApi(),
                  builder: (context, response) {
                    if (response.data == null) {
                      return Center(child: Text("Loading..."));
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      itemCount: response.data!.length,
                      itemBuilder: (ctx, index) {
                        final item = response.data![index];
                        bool isShitami = item.homonSbt == '01';
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
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
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 90,
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  '戻る',
                                                  style: TextStyle(
                                                    color: Color(0xFFEB5757),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                          ),
                                          Container(
                                            width: 90,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  //                   <--- left side
                                                  color: Colors.grey,
                                                  width: 1.5,
                                                ),
                                                right: BorderSide(
                                                  //                    <--- top side
                                                  color: Colors.grey,
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); //close Dialog
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Page31YeuCauBieuMauPage(
                                                              isShitami:
                                                                  isShitami,
                                                              initialDate:
                                                                  date),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'いいえ',
                                                  style: TextStyle(
                                                    color: Color(0xFFEB5757),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 90,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); //close Dialog
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Page31YeuCauBieuMauPage(
                                                      isShitami: isShitami,
                                                      initialDate: date,
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
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: !isShitami
                                  ? const Color.fromARGB(255, 216, 181, 111)
                                  : const Color.fromARGB(255, 111, 177, 224),
                              border: Border.all(
                                color: !isShitami
                                    ? const Color.fromARGB(255, 216, 181, 111)
                                    : const Color.fromARGB(255, 111, 177, 224),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isShitami
                                        ? '訪問時間：${formatJikan(jikan: item.sitamiHomonJikan)}　　報告：未'
                                        : '訪問時間：${formatJikan(jikan: item.kojiHomonJikan)}   報告：済',
                                  ),
                                  Text(
                                      '受注ID： ${item.jyucyuId}　人数：${item.shitamiJinin}人　目安作業時間：${item.shitamiJikan ?? ''}(m)'),
                                  Text('工事アイテム： ${item.kojiItem}'),
                                  Text('住所： ${item.setsakiAddress}'),
                                  Text('氏名： ${item.setsakiName}'),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 5,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 120,
              height: 37,
              decoration: BoxDecoration(
                color: const Color(0xFF4F4F4F),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '続きを見る',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                const Text(
                  'チラシ投函数',
                  style: TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                      '更新',
                      style: TextStyle(
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
            )
          ],
        ),
      ),
    );
  }

  Widget leftNextButton(String text) {
    return Column(
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
                date = date.add(const Duration(days: -7));
              });
              callGetListKojiApi(inputDate: date);
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
    );
  }

  Widget rightNextButton(String text) {
    return Column(
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
                date = date.add(const Duration(days: 7));
              });
              callGetListKojiApi(inputDate: date);
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
                "投函数を選択",
                style: TextStyle(
                    // color: Color(0xFF9999999),
                    ),
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
            const Text(
              "投函数を選択",
              style: TextStyle(
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
}
