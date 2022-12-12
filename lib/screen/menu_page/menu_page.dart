import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_life_one/api/menu/get_thong_bao_menu_api.dart';
import 'package:link_life_one/components/login_widget.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page5/page5_quan_ly/quan_ly_nhap_xuat_page.dart';
import 'package:link_life_one/screen/page6/page6_quan_ly/page_6_quan_ly_thanh_vien.dart';
import 'package:link_life_one/screen/page7/page7_1/quan_ly_lich_bieu_7_1_page.dart';
import 'package:link_life_one/screen/page7_0/page_7_so_tai_khoan_page.dart';
import 'package:link_life_one/screen/page4/xac_nhan_thanh_tich_page.dart';

import '../../api/menu/post_update_koji_read_flg.dart';
import '../../shared/assets.dart';
import '../../shared/custom_button.dart';
import '../page3/page_3/page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import 'components/list_comment.dart';
import 'components/list_thong_bao.dart';
import 'components/menu.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> listNames = [
    '工事完了報告',
    'スケジュール管理',
    '実績確認',
    '入出庫管理',
    '部材管理',
    '出納帳',
  ];

  List<dynamic> listComments = [
    // '2022 / 11 / 11　工事のテスト様に新着コメントがあります。',
  ];

  String NYUKOYOTEI_TOTAL = "0";
  String KOJI_TOTAL = "0";
  String SITAMI_TOTAL = "0";
  String BUZAIHACYU_TOTAL = "0";

  List<dynamic> listThongBao = [
    '未処理の入庫が 10 件あります。',
    '未処理の完了報告が 5 件あります。',
    '未処理の下見が 3 件あります。',
    '未処理の部材発注申請が 5 件あります。',
  ];

  List<dynamic> listValue = [
    "0",
    "0",
    "0",
    "0",
  ];

  List<dynamic> listJYUCYU_ID = [];

  Future? callGetThongBaoMenuApiFuture;

  @override
  void initState() {
    callGetThongBaoMenuApiFuture = callGetThongBaoMenuApi();
    super.initState();
  }

  Future<dynamic> callGetThongBaoMenuApi() async {
    final dynamic result =
        await GetThongBaoMenuApi().getThongBaoMenuApi(onSuccess: (res) {
      print(res);

      if (res["COMMENT"] != null) {
        setState(() {
          listComments = res["COMMENT"];
        });

        List<dynamic> tmp = [];
        for (var element in res["COMMENT"]) {
          tmp.add(element["JYUCYU_ID"]);
        }
        setState(() {
          listJYUCYU_ID = tmp;
        });
      }
      if (res["TOTAL"] != null) {
        setState(() {
          listValue[0] = res["TOTAL"][0]["NYUKOYOTEI_TOTAL"];
          listValue[1] = res["TOTAL"][1]["KOJI_TOTAL"];
          listValue[2] = res["TOTAL"][2]["SITAMI_TOTAL"];
          listValue[3] = res["TOTAL"][3]["BUZAIHACYU_TOTAL"];
        });
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 16,
          right: 16,
          left: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Assets.LOGO_LINK,
                    width: 100.w,
                    height: 100.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFFDFE0E3),
                          width: 2.w,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: LoginWidget(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.COMMENT_ICON,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '新着コメント',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      PostUpdateKojiReadFlg().postUpdateKojiReadFlg(
                          listJYUCYU_ID: listJYUCYU_ID,
                          onSuccess: () {
                            CustomToast.show(
                              context,
                              message: "既読ができました。",
                              backGround: Colors.green,
                            );
                            callGetThongBaoMenuApi();
                          },
                          onFailed: () {
                            CustomToast.show(
                              context,
                              message: "既読ができませんでした。",
                              backGround: Colors.red,
                            );
                          });
                    },
                    child: const Text(
                      '既読にする',
                      style: TextStyle(
                        color: Color(0xFF042C5C),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ListComment(
                listComments: listComments,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    Assets.NEWS_ICON,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'お知らせ',
                    style: TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              ListThongBao(
                listValue: listValue,
              ),
              const SizedBox(
                height: 10,
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
                    name: 'メニュー',
                    textStyle: const TextStyle(
                      color: Color(0xFF042C5C),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Menu(
                listNames: listNames,
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(String name) {
    switch (name) {
      case ('スケジュール管理'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuanLyLichBieu71Page(),
          ),
        );
        break;
      case ('出納帳'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SoTaiKhoanPage(),
          ),
        );
        break;
      case ('工事完了報告'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page3BaoCaoHoanThanhCongTrinh(),
          ),
        );
        break;

      case ('実績確認'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const XacNhanThanhTichPage(),
          ),
        );
        break;

      case ('部材管理'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page6QuanLyThanhVien(),
          ),
        );
        break;

      case ('入出庫管理'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuanLyNhapXuatPage(),
          ),
        );
        break;

      default:
        {}
    }
  }
}
