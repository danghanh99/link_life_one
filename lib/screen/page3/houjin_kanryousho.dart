import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/KojiPageApi/hou_jin_kan_ryo_sho_api.dart';
import 'package:link_life_one/api/KojiPageApi/request_corporate_completion.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/shared/assets.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/koji_houkoku_model.dart';

class HoujinKanryousho extends StatefulWidget {
  final String JYUCYU_ID;
  final String TENPO_CD;
  final List<KojiHoukokuModel> kojiHoukoku;
  const HoujinKanryousho(
      {super.key,
      required this.JYUCYU_ID,
      required this.TENPO_CD,
      required this.kojiHoukoku});

  @override
  State<HoujinKanryousho> createState() => _HoujinKanryoushoState();
}

class _HoujinKanryoushoState extends State<HoujinKanryousho> {
  final carouselController = CarouselController();
  List<dynamic> listKbn = [];
  List<String> listKbnName = [];
  List<dynamic> listImage = [];
  final ImagePicker _picker = ImagePicker();

  // bool isTodayDownloaded = false;

  // _checkDownload()async{
  //   isTodayDownloaded = await LocalStorageServices.isTodayDataDownloaded();
  //   setState((){});
  // }

  @override
  void initState() {
    super.initState();
    // _checkDownload();
    getHouJin();
  }

  Future<void> getHouJin() async {
    final result = await HouJinKanRyoShoApi().getKojiHoukoku(
        JYUCYU_ID: widget.JYUCYU_ID,
        TENPO_CD: widget.TENPO_CD,
        onSuccess: () {});
    if (result == null || result is! Map) {
      return;
    }
    setState(
      () {
        listKbn = result['KBN'];
        for (var element in listKbn) {
          element.forEach((key, value) {
            if (value != null && value != '') {
              listKbnName.add(value);
            }
          });
        }
        for(var f in result['FILE']){
          if(f!=null) listImage.add(f);
        }
        // listImage = (result['FILE'] ?? []);
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
                Container(
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
                  alignment: Alignment.bottomLeft,
                  child: const Text('！下記が必要な完了書類です',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                Container(
                  width: size.width - 100,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...listKbnName.map((e) => Text(
                            e,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                listImage.isEmpty
                    ? Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                        ),
                      )
                    : Expanded(
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
                                    : listImage[idx]['FILEPATH']!=null ? FadeInImage(
                                        placeholder: Assets.blankImage,
                                        image: NetworkImage(
                                            listImage[idx]['FILEPATH']),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return LocalStorageNotifier.isOfflineMode
                                            ? Image.file(
                                              File(listImage[idx]['FILEPATH']),
                                              width: size.width - 50,
                                              height: size.height * 2 / 5,
                                              fit: size.width > size.height
                                                  ? null
                                                  : BoxFit.fill,
                                            )
                                            : const Icon(Icons.error);
                                        },
                                      ) : const Icon(Icons.error));
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
                  tmp.add(image);
                  listImage = tmp;
                },
              );
              carouselController.jumpToPage(listImage.length - 1);
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
            final List<XFile> images = await _picker.pickMultiImage();
            if (images.isNotEmpty) {
              setState(
                () {
                  List<dynamic> tmp = listImage;
                  tmp.addAll(images);
                  listImage = tmp;
                },
              );
              carouselController.jumpToPage(listImage.length - 1);
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
                kojiHoukokuList: widget.kojiHoukoku,
                filePathList: listImage
                    .where((element) => element.runtimeType == XFile)
                    .toList()
                    .map((e) => e.path as String)
                    .toList(),
                onSuccess: () {
                  CustomToast.show(
                    context,
                    message: '正常に登録できました。',
                    backGround: Colors.green,
                  );
                  Navigator.of(context).popUntil(
                      (route) => route.settings.name == 'KojiichiranPage3');
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
