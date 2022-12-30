import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/KojiPageApi/create_riyuu.dart';
import 'package:link_life_one/api/KojiPageApi/get_image.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page3/page_3/kojiichiran_page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/screen/page3/shoudakusho.dart';
import 'package:link_life_one/shared/custom_button.dart';
import '../../api/shoudakusho/get_shoudakusho.dart';
import '../../components/toast.dart';
import '../../shared/assets.dart';

class ShashinTeishuutsuGamenPage2 extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final String? cancelRiyuu;
  final DateTime? mitmoriYmd;
  final int index;
  final String KOJI_ST;
  const ShashinTeishuutsuGamenPage2(
      {super.key,
      required this.KOJI_ST,
      this.initialDate,
      this.cancelRiyuu,
      required this.JYUCYU_ID,
      this.mitmoriYmd,
      required this.index});

  @override
  State<ShashinTeishuutsuGamenPage2> createState() =>
      _ShashinTeishuutsuGamenPage2State();
}

class _ShashinTeishuutsuGamenPage2State
    extends State<ShashinTeishuutsuGamenPage2> {
  final ImagePicker _picker = ImagePicker();
  final carouselController = CarouselController();
  XFile? imageFile;
  List<dynamic> listImage = [];

  void selectImage() async {
    try {
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        setState(() {
          List<dynamic> tmp = listImage;
          imageFile = selectedImage;
          tmp.add(imageFile);
          listImage = tmp;
        });
        carouselController.jumpToPage(listImage.length - 1);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getListImage();
    super.initState();
  }

  Future<void> getListImage() async {
    final result = await GetImage().getImage(
        JYUCYU_ID: widget.JYUCYU_ID,
        KOJI_ST: widget.KOJI_ST,
        SHITAMI_MENU: widget.index.toString(),
        onSuccess: () {});
    setState(
      () {
        try {
          listImage = result.toList();
        } catch (e) {
          listImage = [];
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                        name: '写真提出画面',
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
              const SizedBox(height: 50),
              listImage.isEmpty
                  ? Container(
                      width: size.width - 50,
                      height: size.height.h * 2 / 3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                    )
                  : Container(
                      width: size.width - 50,
                      height: size.height.h * 2 / 3,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.black),
                      ),
                      child: CarouselSlider.builder(
                        carouselController: carouselController,
                        options: CarouselOptions(
                          initialPage: listImage.length - 1,
                          viewportFraction: 1,
                          height: size.height.h * 0.7 - 50,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {},
                        ),
                        itemCount: listImage.length,
                        itemBuilder:
                            (BuildContext context, int itemIndex, int idx) {
                          String? path =
                              "https://gamek.mediacdn.vn/133514250583805952/2020/6/28/823171412209073690918001588031818576536427n-15933186251841355750111.jpg";
                          return SizedBox(
                            width: 700,
                            height: 1000,
                            child: listImage[itemIndex].runtimeType == XFile
                                ? Image.file(
                                    File(listImage[idx]!.path),
                                    width: size.width - 50,
                                    height: size.height * 2 / 3,
                                    fit: size.width > size.height
                                        ? null
                                        : BoxFit.fill,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: path,
                                    placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: CircularProgressIndicator(
                                          color: Colors.yellow,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: GestureDetector(
                      onTap: () {
                        selectImage();
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: const Center(
                          child: Text(
                            '写真を添付',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.width > size.height ? 20 : 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                KojiichiranPage3BaoCaoHoanThanhCongTrinh(
                              initialDate: widget.initialDate,
                            ),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () async {
                          if (imageFile == null) {
                            // ignore: use_build_context_synchronously
                            CustomToast.show(
                              context,
                              message: "写真を選択してください。。",
                              backGround: Colors.orange,
                            );
                          } else {
                            CreateRiyuu().createRiyuu(
                                JYUCYU_ID: widget.JYUCYU_ID,
                                FILE_PATH: imageFile!.path,
                                onFailed: (error) {
                                  CustomToast.show(
                                    context,
                                    message: error ?? "写真のアップロードに失敗しました。。 ",
                                    backGround: Colors.red,
                                  );
                                },
                                onSuccess: () {
                                  CustomToast.show(
                                    context,
                                    message: "写真をアップロード出来ました。",
                                    backGround: Colors.green,
                                  );
                                  // if (widget.index == 1 || widget.index == 4) {
                                  //   Navigator.pop(context);
                                  // } else {
                                  //   Navigator.pop(context);
                                  //   Navigator.pop(context);
                                  // }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          KojiichiranPage3BaoCaoHoanThanhCongTrinh(
                                        initialDate: widget.initialDate ??
                                            DateTime.now(),
                                      ),
                                    ),
                                  );
                                },
                                SHITAMI_MENU: widget.index.toString(),
                                CANCEL_RIYU: widget.cancelRiyuu,
                                MTMORI_YMD: widget.mitmoriYmd.toString());
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: const Center(
                            child: Text(
                              '登録',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
