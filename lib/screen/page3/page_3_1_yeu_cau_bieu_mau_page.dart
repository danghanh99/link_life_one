import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_life_one/api/KojiPageApi/get_list_pdf.dart';
import 'package:link_life_one/components/login_widget.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:link_life_one/screen/page3/shashin_kakinin_page.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/screen/page3/shitami_houkoku_page.dart';
import 'package:link_life_one/screen/page7/component/dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../components/text_line_down.dart';
import '../../models/koji.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';
import '../page7/component/dialog.dart';
import 'koji_houkoku.dart';

class Page31YeuCauBieuMauPage extends StatefulWidget {
  final DateTime? initialDate;
  final bool isShitami;
  final Koji koji;
  final bool isSendAList;
  final String single_summarize;
  final String JYUCYU_ID;
  final String KOJI_ST;

  const Page31YeuCauBieuMauPage({
    required this.isShitami,
    this.initialDate,
    required this.isSendAList,
    required this.koji,
    required this.single_summarize,
    required this.JYUCYU_ID,
    required this.KOJI_ST,
    Key? key,
  }) : super(key: key);

  @override
  State<Page31YeuCauBieuMauPage> createState() =>
      _Page31YeuCauBieuMauPageState();
}

class _Page31YeuCauBieuMauPageState extends State<Page31YeuCauBieuMauPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  List<dynamic> list_pdf = [];
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  String SINGLE_SUMMARIZE = "01";

  @override
  void initState() {
    SINGLE_SUMMARIZE = widget.isSendAList ? "02" : "01";
    callGetListPdf();
    super.initState();
  }

  Future<void> callGetListPdf() async {
    List<dynamic> list = await GetListPdf().getListPdf(
        koji: widget.koji, SINGLE_SUMMARIZE: widget.single_summarize);
    setState(() {
      list_pdf = list;
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
          children: [
            Row(
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
                    LoginWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
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
                  name: '依頼書',
                  textStyle: const TextStyle(
                    color: Color(0xFF042C5C),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                TextLineDown(
                    text: '戻る',
                    onTap: () {
                      Navigator.pop(context);
                    }),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  itemCount: list_pdf.length,
                  itemBuilder: (ctx, index) {
                    final item = list_pdf[index];
                    return GestureDetector(
                      onTap: () {
                        CustomDialog.showCustomDialog(
                            context: context,
                            title: '',
                            body: Container(
                              // width: size.width * 2 / 3,
                              // height: size.height * 2 / 3,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(''),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              border: Border.all(
                                                  color: Colors.red)),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  Container(
                                    width: size.width.w * 4 / 5,
                                    height: size.height.h * 4 / 5,
                                    child: SfPdfViewer.network(
                                        "https://koji-app.starboardasiavn.com/${item['FILEPATH']}",
                                        key: _pdfViewerKey),
                                  )
                                ],
                              ),
                            ));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 111, 177, 224),
                            border: Border.all(
                              color: const Color.fromARGB(255, 111, 177, 224),
                            ),
                          ),
                          child: Text("PDF $index")),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(child: Container()),
            Row(
              children: [
                Container(
                  width: 100.w,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA6366),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (widget.KOJI_ST == "03") {
                        CustomToast.show(context,
                            message: "工事報告が未報告の場合は、写真提出が不可となります。");
                      } else {
                        // 01 || 02
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
                                          builder: (context) =>
                                              ShashinTeishuutsuGamenPage(
                                            JYUCYU_ID: widget.JYUCYU_ID,
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
                      }
                    },
                    child: const Text(
                      '設置不可',
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
                  width: 100.w,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      CustomDialog.showCustomDialog(
                        context: context,
                        title: '',
                        body: ShashinKakuninPage(
                          JYUCYU_ID: widget.JYUCYU_ID,
                          SINGLE_SUMMARIZE: SINGLE_SUMMARIZE,
                        ),
                      );
                    },
                    child: const Text(
                      '写真確認',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: 140.w,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (widget.isShitami) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShitamiHoukoku(
                              JYUCYU_ID: widget.koji.jyucyuId,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KojiHoukoku(
                              initialDate: widget.initialDate,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      '工事・下見報告',
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
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  Widget leftNextButton(int number, String text) {
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
          child: number == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.polygonLeft,
                      width: 13,
                      height: 13,
                    ),
                  ],
                )
              : Row(
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

  Widget rightNextButton(int number, String text) {
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
          child: number == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.polygonRight,
                      width: 13,
                      height: 13,
                    ),
                  ],
                )
              : Row(
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
                color: Color(0xFF042C5C),
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

  String formatJikan({required String? jikan}) {
    if (jikan == null || jikan == '' || jikan.length != 4) return '';
    jikan = jikan[0] + jikan[1] + ":" + jikan[2] + jikan[3];
    return jikan;
  }
}
