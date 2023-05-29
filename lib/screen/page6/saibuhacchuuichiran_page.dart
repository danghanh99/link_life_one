import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page6/danh_sach_cac_bo_phan_5_1_2_page.dart';
import 'package:link_life_one/screen/page6/page631/hacchuushounin_phe_duyet_don_dat_hang_6_3_1_page.dart';
import 'package:link_life_one/screen/page6/saibuhachuulist_danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

import '../../api/order/saibuhacchu_ichiran/get_part_order_list_ichiran.dart';
import '../../api/order/saibuhacchu_ichiran/get_pull_down_status_ichiran.dart';
import '../../components/custom_header_widget.dart';
import '../../components/custom_text_field.dart';
import '../../components/login_widget.dart';
import '../../components/text_line_down.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../menu_page/menu_page.dart';
import 'inventories/danh_sach_cac_bo_phan_5_1_3_page.dart';

class SaibuhacchuuichiranPage extends StatefulWidget {
  const SaibuhacchuuichiranPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SaibuhacchuuichiranPage> createState() =>
      _SaibuhacchuuichiranPageState();
}

class _SaibuhacchuuichiranPageState extends State<SaibuhacchuuichiranPage> {
  late int currentRadioRow;

  List<dynamic> listIchiran = [];

  List<dynamic> listIchiranThayDoi = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController tantController = TextEditingController();
  String currentPullDownValue = 'カテゴリを選択';

  List<dynamic> listPullDown = [];

  @override
  void initState() {
    currentRadioRow = -1;
    callGetPullDownStatusIchiran();
    callGetPartOrderListIchiran();
    super.initState();
  }

  Future<dynamic> callGetPullDownStatusIchiran() async {
    final dynamic result = await GetPullDownStatusIchiran()
        .getPullDownStatusIchiran(onSuccess: (data) {
      setState(() {
        listPullDown = data;
      });
    }, onFailed: () {
      CustomToast.show(context, message: "部材発注一覧のプルダウンを取得出来ませんでした。");
    });
  }

  Future<dynamic> callGetPartOrderListIchiran() async {
    FToast? gettingToast;
    final dynamic result = await GetPartOrderListIchiran().getPartOrderListApprove(
      onStart: (){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomToast.show(
              context,
              onShow: (toast){
                gettingToast = toast;
              },
              message: '読み込み中です。', backGround: Colors.grey
          );
        });
      },
      onSuccess: (data) {
        if(gettingToast!=null) gettingToast!.removeCustomToast();
        setState(() {
          listIchiran = data;
          listIchiranThayDoi = listIchiran;
        });
        if(data.isEmpty){
          CustomToast.show(
              context,
              message: 'データはありません。'
          );
        }
      }, onFailed: () {
        CustomToast.show(context, message: "部材発注一覧リストを取得出来ませんでした。");
      }
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
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(),
            title(),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFA5A7A9),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      columnText(
                        controller: idController,
                        width: size.width / 2 - 30,
                        text: '発注ID',
                      ),
                      columnText(
                        controller: tantController,
                        width: size.width / 2 - 30,
                        text: '発注者',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      columnText2(
                        width: size.width / 2 - 28,
                        text: 'ステータス',
                      ),
                      Container()
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      
                      listIchiranThayDoi = listIchiran;
                      
                      if(idController.text.isNotEmpty){
                        listIchiranThayDoi = listIchiranThayDoi.where((element) =>
                            '${element['BUZAI_HACYU_ID']}'.toLowerCase().trim().contains(idController.text.toLowerCase().trim())).toList();
                      }

                      if(tantController.text.isNotEmpty){
                        listIchiranThayDoi = listIchiranThayDoi.where((element) =>
                            '${element['TANT_NAME']}'.toLowerCase().trim().contains(tantController.text.toLowerCase().trim())).toList();
                      }
                      
                      if(currentPullDownValue!='カテゴリを選択'){
                        listIchiranThayDoi = listIchiranThayDoi.where((element) => element['KBNMSAI_NAME']==currentPullDownValue).toList();
                      }

                      setState(() {});
                      
                    },
                    child: const Text(
                      '検索',
                      style: TextStyle(
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
                  width: 100,
                  height: 37,
                  decoration: BoxDecoration(
                    color: currentPullDownValue!='カテゴリを選択' || idController.text.isNotEmpty || tantController.text.isNotEmpty
                      ? Colors.red
                      : const Color(0xFFA1A1A1),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        currentPullDownValue = 'カテゴリを選択';
                        idController.clear();
                        tantController.clear();
                        listIchiranThayDoi = listIchiran;
                      });
                    },
                    child: const Text(
                      'クリア',
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
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildRows(listIchiranThayDoi.length + 1),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6D8FDB),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (currentRadioRow <= 0) {
                        CustomToast.show(context,
                            message: "一つの部材発注一覧を選んでください。");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HachuushouninPheDuyetDonDatHang631Page(
                                    BUZAI_HACYU_ID:
                                        listIchiranThayDoi[currentRadioRow - 1]
                                            ["BUZAI_HACYU_ID"]),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      '発注承認',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Expanded(child: Container()),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA800),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SaibuhacchuulistDanhSachDatHangVatLieu611Page(),
                        ),
                      );
                    },
                    child: const Text(
                      '新規部材発注',
                      style: TextStyle(
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
                  width: 120,
                  height: 37,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA5A7A9),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DanhSachCacBoPhan513Page(
                            back: (list) {
                              print('list: $list');
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'リスト確認',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropDownButton(
    BuildContext context,
    double width,
  ) {
    return PopupMenuButton<int>(
      color: Colors.white,
      padding: EdgeInsets.zero,
      onSelected: (number) {
        if (number == 1) {}
        if (number == 2) {}
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      itemBuilder: (context) => listPullDown.map((item) {
        return PopupMenuItem(
          onTap: () {
            setState(() {
              if (currentPullDownValue == item["KBNMSAI_NAME"]) {
                currentPullDownValue = "カテゴリを選択";
              } else {
                currentPullDownValue = item["KBNMSAI_NAME"];
              }
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
                      item["KBNMSAI_NAME"].toString(),
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
      offset: const Offset(-0, 50),
      child: Container(
        width: width - 4,
        height: 34,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                currentPullDownValue,
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                Assets.icDown,
                width: 13,
                height: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return const CustomHeaderWidget();
  }

  Widget title() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 247, 240, 240))),
        width: 200,
        child: CustomButton(
          color: Colors.white70,
          onClick: () {},
          name: '部材発注一覧',
          textStyle: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget columnText({
    TextEditingController? controller,
    double? width,
    Color? color,
    String? hint,
    String? text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? '',
          style: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          width: width ?? 30,
          child: CustomTextField(
            controller: controller,
            fillColor: color,
            hint: hint ?? '',
            type: TextInputType.emailAddress,
            onChanged: (text) {
              setState(() {});
            },
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget columnText2({
    double? width,
    Color? color,
    String? hint,
    String? text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text ?? '',
          style: const TextStyle(
            color: Color(0xFF042C5C),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _dropDownButton(context, width ?? 30),
      ],
    );
  }

  List<Widget> _buildCells2(int count, int row) {
    List<String> colNames = [
      '',
      '発注ID',
      '状況',
      '発注日',
      '発注者',
      '品番',
      '商品名',
    ];

    Size size = MediaQuery.of(context).size;
    List<double> colwidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? [
                30,
                130,
                130,
                100,
                100,
                120,
                120,
              ]
            : [
                30,
                (size.width - 33) * 2 / 7 + -30,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
                (size.width - 33) / 7,
              ];

    return List.generate(count, (col) {
      if (row == 0) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: const Color(0xFFFF9900),
          ),
          alignment: Alignment.center,
          width: colwidth[col],
          height: 80,
          child: Text(
            colNames[col],
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
          color: listIchiranThayDoi[row - 1]["HACYU_OKFLG"]=="02"
              ? const Color(0xffffff00)
              : listIchiranThayDoi[row - 1]["HACYU_OKFLG"]=="03"
              ? const Color(0xff00bfff)
              : Colors.white,
        ),
        alignment: Alignment.center,
        width: colwidth[col],
        height: 50,
        child: contentTable(col, row),
      );
    });
  }

  List<Widget> _buildRows(int count) {
    return List.generate(count, (index) {
      return Row(
        children: _buildCells2(7, index),
      );
    });
  }

  Widget contentTable(int col, int row) {
    if (row != 0 && col != 0) {
      String value = '';

      if (col == 1) {
        value = listIchiranThayDoi[row - 1]["BUZAI_HACYU_ID"] ?? '';
      }
      if (col == 2) {
        value = listIchiranThayDoi[row - 1]["KBNMSAI_NAME"] ?? '';
      }
      if (col == 3) {
        if (listIchiranThayDoi[row - 1]["HACYU_YMD"] == null) {
          value = '';
        } else {
          DateTime time = DateFormat("yyyy-MM-dd")
              .parse(listIchiranThayDoi[row - 1]["HACYU_YMD"]);
          value = DateFormat('yyyy/MM/dd', 'ja').format(time).toString();
        }
      }
      if (col == 4) {
        value = listIchiranThayDoi[row - 1]["TANT_NAME"] ?? '';
      }
      if (col == 5) {
        value = listIchiranThayDoi[row - 1]["JISYA_CD"] ?? '';
      }
      if (col == 6) {
        value = listIchiranThayDoi[row - 1]["SYOHIN_NAME"] ?? '';
      }

      return Text(
        value,
        style: const TextStyle(color: Colors.black),
      );
    }
    return col == 0
        ? RadioListTile(
            value: row,
            groupValue: currentRadioRow,
            onChanged: (e) {
              setState(() {
                currentRadioRow = row;
              });
            },
          )
        : const Text(
            '',
            style: TextStyle(color: Colors.black),
          );
  }
}
