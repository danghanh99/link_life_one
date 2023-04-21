import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/KojiPageApi/show_popup.dart';
import 'package:link_life_one/components/custom_header_widget.dart';
import 'package:link_life_one/components/custom_text_field.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/local_storage_services/local_storage_base.dart';
import 'package:link_life_one/models/koji.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/models/local_storage/t_koji.dart';
import 'package:link_life_one/screen/page3/page_3_1_yeu_cau_bieu_mau_page.dart';
import 'package:provider/provider.dart';
import '../../../api/KojiPageApi/get_list_koji_api.dart';
import '../../../api/KojiPageApi/request_post_count.dart';
import '../../../api/koji/tirasu/get_tirasi.dart';
import '../../../api/koji/tirasu/post_tirasi_update_api.dart';
import '../../../main.dart';
import '../../../shared/assets.dart';
import '../../../shared/validator.dart';
import 'components/title_widget.dart';

class KojiichiranPage3BaoCaoHoanThanhCongTrinh extends StatefulWidget {
  final DateTime? initialDate;
  const KojiichiranPage3BaoCaoHoanThanhCongTrinh({
    this.initialDate,
    Key? key,
  }) : super(key: key);

  @override
  State<KojiichiranPage3BaoCaoHoanThanhCongTrinh> createState() =>
      _KojiichiranPage3BaoCaoHoanThanhCongTrinhState();
}

class _KojiichiranPage3BaoCaoHoanThanhCongTrinhState
    extends State<KojiichiranPage3BaoCaoHoanThanhCongTrinh> with RouteAware {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  List<Koji> listKoji = [];
  List<String> listNames = [
    '入出庫管理',
    '部材管理',
    '出納帳',
    '12',
    '1234',
  ];
  DateTime date = DateTime.now();

  String tiraru = '';
  bool isValid = true;
  TextEditingController textEditingController = TextEditingController();
  Future<List<Koji>>? getListKojiApi;
  @override
  void initState() {
    date = widget.initialDate ?? DateTime.now();
    super.initState();
    getListKojiApi = callGetListKojiApi(inputDate: date);
    callGetTirasi(inputDate: date);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Called when the current route has been pushed.
  }

  @override
  void didPopNext() {
    callGetListKojiApi(inputDate: date);
    callGetTirasi(inputDate: date);
  }

  Future<void> downloadData() async {
    await Hive.openBox("offKoji");
  }

  Future<List<Koji>> callGetListKojiApi({DateTime? inputDate}) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    return await GetListKojiApi().getListKojiApi(
      date: inputDate ?? date,
      onSuccess: (list) {
        if (mounted) {
          setState(() {
            isLoading = false;
            listKoji = list;
          });
        }
      },
      onFailed: () async{
        if (mounted) {
          setState(() {
            isLoading = false;
            listKoji = [];
          });
        }
      },
    );
  }

  Future<void> callGetTirasi({DateTime? inputDate}) async {
    try {
      await GetTirasi().getTirasi(
        YMD: inputDate ?? date,
        onSuccess: (data) {
          List<dynamic> mtplist = data;
          if (mtplist.isNotEmpty) {
            if (mtplist[0] != null) {
              if (mtplist[0]["KOJI_TIRASISU"] != null) {
                setState(() {
                  tiraru = '${mtplist[0]["KOJI_TIRASISU"]}';
                  textEditingController.text = tiraru;
                });
              }
            }
          } else {
            setState(() {
              tiraru = '';
              textEditingController.text = tiraru;
            });
          }
        },
        onFailed: () {
          CustomToast.show(context, message: "チラシ投函数を取得できません。");
        },
      );
    } catch (e) {
      CustomToast.show(context, message: "チラシを取得出来ませんでした。");
    }
  }

  String formatJikan({required String? jikan}) {
    if (jikan == null || jikan == '' || jikan.length != 4) return '';
    jikan = "${jikan[0]}${jikan[1]}:${jikan[2]}${jikan[3]}";
    return jikan;
  }

  Widget _progressBar(){
    return StreamBuilder(
        stream: context.read<LocalStorageNotifier>().progressController.stream,
        builder: (context, snapshot){
          return LinearProgressIndicator(
            value: snapshot.hasData?snapshot.data as double:0.0,
            backgroundColor: Colors.transparent
          );
        }
    );
  }

  showLoadingPopup({required Function(BuildContext) onShow}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        print('show popup');
        onShow(context);
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
                    padding: const EdgeInsets.only(top: 32.0),
                    child: CupertinoActivityIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: _progressBar(),
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
            const CustomHeaderWidget(),
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
                const SizedBox(
                  width: 8,
                ),
                leftNextButton('先週', 7),
                const SizedBox(width: 8),
                leftNextButton('先日', 1),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15,
                    right: 8,
                    left: 8,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? picked;
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1990, 3, 5),
                          maxTime: DateTime(2200, 6, 7),
                          onChanged: (datePick) {}, onConfirm: (datePick) {
                        picked = datePick;
                        if (picked != null && picked != date) {
                          setState(() {
                            date = picked!;
                          });
                          callGetListKojiApi(inputDate: picked);
                          callGetTirasi(inputDate: picked);
                        }
                      }, currentTime: DateTime.now(), locale: LocaleType.jp);
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
                rightNextButton('翌日', 1),
                const SizedBox(width: 8),
                rightNextButton('翌週', 7),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: FutureBuilder<List<Koji>>(
                    future: getListKojiApi,
                    builder: (context, response) {
                      if (isLoading == true) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: const [
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                color: Colors.grey,
                                strokeWidth: 3,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "読み込み中です。",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 118, 114, 114),
                              ),
                            ),
                          ],
                        );
                      }

                      if (listKoji.isEmpty) {
                        return const Center(
                            child: Text(
                          "案件はありません",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 118, 114, 114),
                          ),
                        ));
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        itemCount: listKoji.length,
                        itemBuilder: (ctx, index) {
                          final item = listKoji[index];
                          bool isShitami = item.homonSbt == '01';
                          return GestureDetector(
                            onTap: () {
                              ShowPopUp().isShowPopup(
                                YMD: date,
                                SETSAKI_ADDRESS: item.setsakiAddress,
                                JYUCYU_ID: item.jyucyuId,
                                onSuccess: (count) {
                                  if (count > 0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text(
                                            "同一のお客様がいます完了確認書を1枚にまとめますか？",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          content: const Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Text(
                                              "いいえの場合、それぞれの完了書にサインをもらってください。",
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
                                                          color:
                                                              Color(0xFFEB5757),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )),
                                                ),
                                                Container(
                                                  width: 90,
                                                  decoration:
                                                      const BoxDecoration(
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
                                                                        date,
                                                                    koji: item,
                                                                    isSendAList:
                                                                        true,
                                                                    single_summarize:
                                                                        '01',
                                                                    JYUCYU_ID: item
                                                                        .jyucyuId,
                                                                    KOJI_ST: item
                                                                        .kojiSt,
                                                                  ),
                                                              settings:
                                                                  const RouteSettings(
                                                                      name:
                                                                          'Page31YeuCauBieuMauPage')),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'いいえ',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFEB5757),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 90,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      RequestPostCount()
                                                          .requestPostCount(
                                                              koji: item,
                                                              date: date,
                                                              onSuccess: () {
                                                                Navigator.pop(
                                                                    context); //close Dialog
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Page31YeuCauBieuMauPage(
                                                                                isShitami: isShitami,
                                                                                initialDate: date,
                                                                                koji: item,
                                                                                isSendAList: true,
                                                                                single_summarize: '02',
                                                                                JYUCYU_ID: item.jyucyuId,
                                                                                KOJI_ST: item.kojiSt,
                                                                              ),
                                                                      settings:
                                                                          const RouteSettings(
                                                                              name: 'Page31YeuCauBieuMauPage')),
                                                                );
                                                              });
                                                    },
                                                    child: const Text(
                                                      'はい',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF007AFF),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Page31YeuCauBieuMauPage(
                                                single_summarize: '01',
                                                JYUCYU_ID: item.jyucyuId,
                                                isShitami: isShitami,
                                                initialDate: date,
                                                koji: item,
                                                isSendAList: true,
                                                KOJI_ST: item.kojiSt,
                                              ),
                                          settings: const RouteSettings(
                                              name: 'Page31YeuCauBieuMauPage')),
                                    );
                                  }
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: showMauXanh(item.kojiSt)
                                    ? const Color(0xffc5d8f1)
                                    : const Color(0xfffce9d9),
                                border: Border.all(
                                  color: showMauXanh(item.kojiSt)
                                      ? const Color(0xffc5d8f1)
                                      : const Color(0xfffce9d9),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "訪問時間：${isShitami ? item.sitamiHomonJikan : item.kojiHomonJikan} - ${isShitami ? item.sitamiHomonJikanEnd : item.kojiHomonJikanEnd}   報告： ${item.kojiSt == '03' ? '済' : '未'}",
                                    ),
                                    isShitami
                                        ? Text(
                                            '受注ID： ${item.jyucyuId.length == 10 ? item.jyucyuId : item.jyucyuId.substring(0, 10)}　人数：${item.shitamiJinin}人　目安作業時間：${item.shitamiJikan ?? ''}(m)')
                                        : Text(
                                            '受注ID： ${item.jyucyuId.length == 10 ? item.jyucyuId : item.jyucyuId.substring(0, 10)}　人数：${item.kojiJinin}人　目安作業時間：${item.kojiJikan ?? ''}(m)'),
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
            ),
            const SizedBox(
              height: 5,
            ),
            // Container(
            //   width: 120,
            //   height: 37,
            //   decoration: BoxDecoration(
            //     color: const Color(0xFF4F4F4F),
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: TextButton(
            //     onPressed: () {},
            //     child: const Text(
            //       '続きを見る',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    height: 100.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'チラシ投函数',
                            style: TextStyle(
                              color: const Color(0xFF042C5C),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 240.w,
                                height: 100.h,
                                child: CustomTextField(
                                  controller: textEditingController,
                                  maxLength: 10,
                                  hint: '',
                                  type: TextInputType.phone,
                                  validator: _validateNumber,
                                  onChanged: (text) {
                                    setState(() {
                                      tiraru = text;
                                    });
                                    // validateNumber(text);
                                  },
                                ),
                              ),
                              // !isValid
                              //     ? Text(
                              //         '整数のみ',
                              //         style: TextStyle(
                              //             color: Colors.red, fontSize: 12.sp),
                              //       )
                              //     : Container(),
                            ],
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA800),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() == true) {
                                final box = await Hive.openBox<String>('user');
                                String loginID = box.values.last;

                                PostTirasiUpdateApi().postTirasiUpdateApi(
                                    YMD: DateFormat('yyyy-MM-dd', 'ja')
                                        .format(date)
                                        .toString(),
                                    LOGIN_ID: loginID,
                                    KOJI_TIRASISU: tiraru,
                                    onFailed: () {
                                      CustomToast.show(context,
                                          message: "エラー!!!投函数更新ができませんでした。");
                                    },
                                    onSuccess: () {
                                      CustomToast.show(context,
                                          message: "投函数更新ができました。",
                                          backGround: Colors.green);
                                    });
                              }
                            },
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
                  ),
                ),
                const SizedBox(width: 30.0,),
                DateFormat('yyyyMMdd').format(date)==DateFormat('yyyyMMdd').format(DateTime.now())
                  ?  Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA800),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              var dialogContext;
                              showLoadingPopup(
                                onShow: (context){
                                  dialogContext = context;
                                }
                              );
                              await context.read<LocalStorageNotifier>().downloadData();
                              Navigator.pop(dialogContext);
                            },
                            child: const Text(
                              'オフライン用ダウンロード',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA800),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              var dialogContext;
                              showLoadingPopup(
                                  onShow: (context)async{
                                    dialogContext = context;
                                    await context.read<LocalStorageNotifier>().uploadData();
                                    Navigator.pop(dialogContext);
                                  }
                              );
                            },
                            child: const Text(
                              'オンラインアップロード',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                  : Container()
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget leftNextButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          date = date.add(Duration(days: -index));
        });
        callGetListKojiApi(inputDate: date);
        callGetTirasi(inputDate: date);
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
                  date = date.add(Duration(days: -index));
                });
                callGetListKojiApi(inputDate: date);
                callGetTirasi(inputDate: date);
              },
              child: index == 7
                  ? Row(
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
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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

  // bool validateNumber(String? input) {
  //   if (Validator.onlyNumber(input!)) {
  //     setState(() {
  //       isValid = true;
  //       tiraru = input;
  //     });
  //     return true;
  //   } else {
  //     setState(() {
  //       isValid = false;
  //       tiraru = '';
  //     });
  //     return false;
  //   }
  // }

  String? _validateNumber(String? input) {
    if (input == '' || input == null) {
      return 'チラシ投函数を入力してください。';
    } else {
      if (Validator.onlyNumber(input)) {
        return null;
      } else {
        return '整数の数字だけを入力してください。';
      }
    }
  }

  Widget rightNextButton(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          date = date.add(Duration(days: index));
        });
        callGetListKojiApi(inputDate: date);
        callGetTirasi(inputDate: date);
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
                  date = date.add(Duration(days: index));
                });
                callGetListKojiApi(inputDate: date);
                callGetTirasi(inputDate: date);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: index == 7
                    ? [
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
                      ]
                    : [
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

  bool showMauXanh(String kojiSt) {
    return kojiSt == '03';
  }
}
