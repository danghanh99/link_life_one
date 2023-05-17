import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_life_one/api/inventory/check_show_popup_api.dart';
import 'package:link_life_one/api/order/get_check_order_save.dart';
import 'package:link_life_one/screen/page6/saibuhacchuuichiran_page.dart';
import 'package:link_life_one/screen/page6/saibuhachuulist_danh_sach_dat_hang_vat_lieu_6_1_1_page.dart';

import '../../../shared/custom_button.dart';
import '../../page3/page_3/kojiichiran_page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import '../../page4/xac_nhan_thanh_tich_page.dart';
import '../../page5/page5_quan_ly/quan_ly_nhap_xuat_page.dart';
import '../../page5/page_5_1_lich_kiem_ke.dart';
import '../../page5/page_5_2_danh_sach_nguyen_lieu.dart';
import '../../page5/page_5_3_danh_sach_nhan_lai_vat_lieu.dart';
import '../../page6/tanaoroshi_danh_muc_hang_ton_kho_6_2_page.dart';
import '../../page6/saibuhachuu/saibuhachuu_danh_sach_dat_hang_cac_bo_phan_6_1_page.dart';
import '../../page6/page6_quan_ly/page_6_quan_ly_thanh_vien.dart';
import '../../page7_0/page_7_so_tai_khoan_page.dart';
import '../../page7/page7_1/quan_ly_lich_bieu_7_1_page.dart';

class CustomMenuButton extends StatefulWidget {
  final String name;
  final double? width;
  final double? height;
  const CustomMenuButton({
    required this.name,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomMenuButton> createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(widget.name);
      },
      child: SizedBox(
        width: widget.width ?? widget.width,
        height: widget.height ?? widget.height,
        child: CustomButton(
          color: const Color(0xFFFFFA7A),
          onClick: () {
            navigateTo(widget.name);
          },
          name: widget.name,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
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
            builder: (context) =>
                const KojiichiranPage3BaoCaoHoanThanhCongTrinh(),
                settings: const RouteSettings(name: 'KojiichiranPage3')
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

//page 5
      case ('入庫予定表'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page51LichKiemKe(),
          ),
        );
        break;

      case ('部材持ち出し 登録'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page52DanhSachNguyenLieu(),
          ),
        );
        break;

      case ('部材持ち戻り 登録'):
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Page53DanhSachNhanLaiVatLieu(),
          ),
        );
        break;
// page 5 end

// page 6 begin
      case ('部材発注'):
        CheckOrderSave().checkOrderSave(
            onSuccess: (isExist){
              if(!isExist){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const SaibuhachuuDanhSachDatHangCacBoPhan61Page(),
                  ),
                );
              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SaibuhacchuulistDanhSachDatHangVatLieu611Page(
                            isShowPopup: true
                        ),
                  ),
                );
              }
            },
            onFailed: (){}
        );
        break;
      case ('棚卸'):
        CheckShowPopupApi().checkShowPopup(
            onSuccess: (tt) {
              if (tt) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TanaoroshiDanhMucHangTonKho62Page(
                        isContinue: false,
                      ),
                    )
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: double.infinity,
                      child: CupertinoAlertDialog(
                        content: const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "前回編集途中のリストがあります。",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TanaoroshiDanhMucHangTonKho62Page(
                                      isContinue: true,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                '続きから編集する',
                                style: TextStyle(
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
                                      const TanaoroshiDanhMucHangTonKho62Page(
                                    isContinue: false,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              '破壊して新規リスト作成',
                              style: TextStyle(
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
            onFailed: () {});

        break;

      case ('発注承認'):
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const PheDuyetDonDatHang631Page(),
        //   ),
        // );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SaibuhacchuuichiranPage(),
          ),
        );
        break;
// page 6 end
      default:
        {}
    }
  }
}
