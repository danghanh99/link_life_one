import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/KojiPageApi/hou_jin_kan_ryo_sho_api.dart';
import 'package:link_life_one/api/KojiPageApi/request_corporate_completion.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HoujinKanryousho extends StatefulWidget {
  final String JYUCYU_ID;
  final String TENPO_CD;
  const HoujinKanryousho(
      {super.key, required this.JYUCYU_ID, required this.TENPO_CD});

  @override
  State<HoujinKanryousho> createState() => _HoujinKanryoushoState();
}

class _HoujinKanryoushoState extends State<HoujinKanryousho> {
  final carouselController = CarouselController();
  List<dynamic> listKbn = [];
  List<dynamic> listImage = [];
  final ImagePicker _picker = ImagePicker();
  XFile? imageSelected;

  @override
  void initState() {
    super.initState();
    getHouJin();
  }

  Future<void> getHouJin() async {
    final result = await HouJinKanRyoShoApi().getKojiHoukoku(
        JYUCYU_ID: '0301416579', TENPO_CD: widget.TENPO_CD, onSuccess: () {});
    setState(
      () {
        listKbn = result['KBN'];
        listImage = result['FILE'] ?? [];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 1000.h,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 70,
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
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 247, 240, 240))),
                        width: 200,
                        child: CustomButton(
                          color: Colors.white70,
                          onClick: () {},
                          name: '法人完了書',
                          textStyle: const TextStyle(
                            color: Color(0xFF042C5C),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
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
                  height: 100,
                ),
                Container(
                  width: size.width - 100,
                  height: 150.h,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listKbn.isEmpty
                              ? ''
                              : listKbn[0]['YOBIKOMOKU1'] ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          listKbn.isEmpty
                              ? ''
                              : listKbn[0]['YOBIKOMOKU2'] ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          listKbn.isEmpty
                              ? ''
                              : listKbn[0]['YOBIKOMOKU3'] ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          listKbn.isEmpty
                              ? ''
                              : listKbn[0]['YOBIKOMOKU4'] ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          listKbn.isEmpty
                              ? ''
                              : listKbn[0]['YOBIKOMOKU5'] ?? '',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                listImage.isEmpty
                    ? Container(
                        width: size.width - 100,
                        height: size.height * 1 / 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                      )
                    : SizedBox(
                        height: 500.h,
                        child: CarouselSlider.builder(
                          carouselController: carouselController,
                          options: CarouselOptions(
                            initialPage: listImage.length - 1,
                            viewportFraction: 1,
                            height: size.height * 0.7,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {},
                          ),
                          itemCount: listImage.length,
                          itemBuilder:
                              (BuildContext context, int itemIndex, int idx) {
                            String? path =
                                "https://gamek.mediacdn.vn/133514250583805952/2020/6/28/823171412209073690918001588031818576536427n-15933186251841355750111.jpg";
                            return SizedBox(
                              width: 700.w,
                              height: 500.h,
                              child: listImage[itemIndex].runtimeType == XFile
                                  ? Image.file(
                                      File(listImage[idx]!.path),
                                      width: size.width - 50,
                                      height: size.height * 2 / 5,
                                      fit: size.width > size.height
                                          ? null
                                          : BoxFit.fill,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: path,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: SizedBox(
                                          width: 100,
                                          height: 1,
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
                const SizedBox(
                  height: 30,
                ),
                sendButton2(),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 150,
            child: const Center(
              child: Text(
                '登録',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget sendButton2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            final XFile? image =
                await _picker.pickImage(source: ImageSource.camera);
            if (image != null) {
              setState(
                () {
                  List<dynamic> tmp = listImage;
                  imageSelected = image;
                  tmp.add(imageSelected);
                  listImage = tmp;
                },
              );
              carouselController.jumpToPage(listImage.length - 1);
            } else {
              // ignore: use_build_context_synchronously
              CustomToast.show(context,
                  message: '写真を選択してください。',
                  textStyle: const TextStyle(color: Colors.red));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                'カメラ起動',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          onTap: () async {
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(
                () {
                  List<dynamic> tmp = listImage;
                  imageSelected = image;
                  tmp.add(imageSelected);
                  listImage = tmp;
                },
              );
              carouselController.jumpToPage(listImage.length - 1);
            } else {
              // ignore: use_build_context_synchronously
              CustomToast.show(context,
                  message: '写真を選択してください。',
                  textStyle: const TextStyle(color: Colors.red));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                '写真の添付',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        GestureDetector(
          onTap: () {
            RequestCorporateCompletion().requestCorporateCompletion(
                JYUCYU_ID: widget.JYUCYU_ID,
                onSuccess: () {
                  CustomToast.show(
                    context,
                    message: '正常に登録できました。',
                    backGround: Colors.green,
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                onFailed: () {
                  CustomToast.show(context, message: '登録できませんでした。');
                });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            height: 50,
            width: 200,
            child: const Center(
              child: Text(
                '登録',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
