import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_life_one/api/KojiPageApi/get_list_pdf.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:link_life_one/models/pdf_file.dart';
import 'package:link_life_one/screen/page3/shashin_kakinin_page.dart';
import 'package:link_life_one/screen/page3/shashin_teishuutsu_gamen_page.dart';
import 'package:link_life_one/screen/page3/shitami_houkoku_page.dart';
import 'package:link_life_one/screen/page7/component/dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../api/koji/getPhotoConfirm/get_shashin_kakunin.dart';
import '../../components/custom_header_widget.dart';
import '../../models/koji.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
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
  List<PdfFile> list_pdf = [];
  List<String> listPdfURL = [];

  List<dynamic> listPhotos = [];

  int currentPage = 0;

  // String SINGLE_SUMMARIZE = "01";

  @override
  void initState() {
    // SINGLE_SUMMARIZE = widget.isSendAList ? "02" : "01";
    callGetListPdf();
    callGetShashinKakunin();
    super.initState();
  }

  void onChangePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  Future<void> callGetListPdf() async {
    List<PdfFile> list = await GetListPdf().getListPdf(
        koji: widget.koji, SINGLE_SUMMARIZE: widget.single_summarize);
        List<String> listURL = [];
        list.forEach((element) {
          String kojiiraisyoFilePath = element.kojiiraisyoFilePath ?? '';
          String sitamiiraisyoFilePath = element.sitamiiraisyoFilePath ?? '';
          String filePath = element.filePath ?? '';
          if (kojiiraisyoFilePath.isNotEmpty && kojiiraisyoFilePath.endsWith('.pdf')) {
            listURL.add(kojiiraisyoFilePath);
          }
          if (sitamiiraisyoFilePath.isNotEmpty && sitamiiraisyoFilePath.endsWith('.pdf')) {
            listURL.add(sitamiiraisyoFilePath);
          }
          if (filePath.isNotEmpty && filePath.endsWith('.pdf')) {
            listURL.add(filePath);
          }
        });
    setState(() {
      list_pdf = list;
      listPdfURL = listURL;
    });

    if (listPdfURL.length > 1) {
      showPopup('添付ファイルを確認して下さい。');
    }
  }

  Future<void> callGetShashinKakunin() async {
    await GetShashinKakunin().getShashinKakunin(
        JYUCYU_ID: widget.JYUCYU_ID,
        SINGLE_SUMMARIZE: widget.single_summarize,
        onSuccess: (list) {
          listPhotos = list;
          if (list.isNotEmpty) {
            showPopup('添付画像があります。確認を行ってください。');
          }
        },
        onFailed: () {
          CustomToast.show(context, message: "リスト写真を取得出来ませんでした。");
        });
  }

  void showPopup(String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 24, 23, 23),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(height: 0),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Color(0xFF007AFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
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
            CustomHeaderWidget(
              onBack: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: CupertinoAlertDialog(
                        title: const Text(
                          "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        content: const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "記入した情報が破棄されますがよろしいでしょうか。",
                            style: TextStyle(
                              color: Color.fromARGB(255, 24, 23, 23),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context); //close Dialog
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'はい',
                                style: TextStyle(
                                  color: Color(0xFFEB5757),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'いいえ',
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
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: CarouselSlider.builder(
                      itemCount: listPdfURL.length,
                      itemBuilder: (ctx, index, realIndex) {
                       String filePath = listPdfURL.elementAt(index);
                        return filePath.isEmpty
                            ? const Center(
                                child: Text(
                                  'PDFを取得出来ませんでした。',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                            : SfPdfViewer.network(
                                filePath,
                                onDocumentLoaded: (details) {},
                                onDocumentLoadFailed: (detail) {
                                  CustomToast.show(context,
                                      message: "PDFを取得出来ませんでした。");
                                  // message: detail.description);
                                },
                              );
                      },
                      options: CarouselOptions(
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          onChangePage(index);
                        },
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: listPdfURL.isNotEmpty,
              child: Center(
                child: Text(
                  "${currentPage + 1}/${listPdfURL.length}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 130.w,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFA6366),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
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
                                          HOMON_SBT: widget.koji.homonSbt,
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
                  width: 130.w,
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
                          SINGLE_SUMMARIZE: widget.single_summarize,
                          listPhotos: listPhotos,
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
                  width: 180.w,
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
                              KOJI_ST: widget.KOJI_ST,
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
                              SINGLE_SUMMARIZE: widget.single_summarize,
                              JYUCYU_ID: widget.JYUCYU_ID,
                              KOJI_ST: widget.KOJI_ST,
                              SYUYAKU_JYUCYU_ID: widget.JYUCYU_ID,
                              HOJIN_FLG: widget.koji.hojinFlag,
                              HOMON_SBT: widget.koji.homonSbt,
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
