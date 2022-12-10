import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/koji/postPhotoSubmissionRegistration/upload_photo_api.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/screen/page3/page_3/page_3_bao_cao_hoan_thanh_cong_trinh.dart';
import 'package:link_life_one/shared/custom_button.dart';

import '../../api/koji/getPhotoConfirm/get_shashin_kakunin.dart';

class ShashinKakuninPage extends StatefulWidget {
  final String JYUCYU_ID;
  final String SINGLE_SUMMARIZE;
  const ShashinKakuninPage({
    super.key,
    required this.JYUCYU_ID,
    required this.SINGLE_SUMMARIZE,
  });

  @override
  State<ShashinKakuninPage> createState() => _ShashinKakuninPageState();
}

class _ShashinKakuninPageState extends State<ShashinKakuninPage> {
  Future? getShashinKakunin;
  List<dynamic> listPhotos = [];
  // String url = "https://koji-app.starboardasiavn.com/";
  @override
  void initState() {
    getShashinKakunin = callGetShashinKakunin();
    super.initState();
  }

  Future<void> callGetShashinKakunin() async {
    final result = await GetShashinKakunin().getShashinKakunin(
        JYUCYU_ID: widget.JYUCYU_ID,
        SINGLE_SUMMARIZE: widget.SINGLE_SUMMARIZE,
        onSuccess: (list) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   setState(() {
          //     listPhotos = list;
          //   });
          // });
          setState(() {
            listPhotos = list;
          });
        },
        onFailed: () {
          CustomToast.show(context,
              message: "Failed to get list kakunin photos");
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 900.h,
      width: 800.w,
      color: Color.fromARGB(245, 239, 234, 234),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
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
                      onClick: () {
                        print("object");
                      },
                      name: '写真確認',
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
            SizedBox(height: 50.h),
            CarouselSlider.builder(
              options: CarouselOptions(
                initialPage: listPhotos.length,
                viewportFraction: 1,
                height: size.height * 0.7,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  //   setState(() {
                  //     currentPhoto = widget.listImage[index];
                  //   });
                  //   autoScrollController.scrollToIndex(index,
                  //       preferPosition: AutoScrollPosition.middle);
                },
              ),
              itemCount: listPhotos.length,
              // carouselController: carouselController,
              itemBuilder: (BuildContext context, int itemIndex, int idx) {
                String? path = listPhotos[idx]["FILEPATH"] == null
                    ? null
                    : listPhotos[idx]["FILEPATH"];
                return path == null
                    ? Container()
                    : Container(
                        width: 700.w,
                        height: 1000.h,
                        child: CachedNetworkImage(
                          imageUrl: path,
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: const CircularProgressIndicator(
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
          ],
        ),
      ),
    );
  }
}
