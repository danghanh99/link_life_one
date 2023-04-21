import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/KojiPageApi/create_riyuu.dart';
import 'package:link_life_one/api/KojiPageApi/get_image.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/shared/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../shared/cache_notifier.dart';

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
  List<dynamic> selectedImages = [];

  // bool isTodayDownloaded = false;

  void selectImage() async {
    try {
      List<XFile> files = await _picker.pickMultiImage();
      if (files.isNotEmpty) {
        setState(() {
          selectedImages.addAll(files);
        });
      }
    } catch (e) {}
  }

  // _checkDownload()async{
  //   isTodayDownloaded = await LocalStorageServices.isTodayDataDownloaded();
  //   setState((){});
  // }

  @override
  void initState() {
    // _checkDownload();
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
          selectedImages = result.toList();
        } catch (e) {
          selectedImages = [];
        }
        loadCache();
      },
    );
  }

  void loadCache() {
    List<XFile>? cacheImages =
        context.read<CacheNotifier>().cacheShashinTeishuutsuGamenImages[
            widget.JYUCYU_ID + widget.index.toString()];
    if (cacheImages != null && cacheImages.isNotEmpty) {
      selectedImages.addAll(cacheImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double imageContainerHeight = size.height.h * 2 / 3;
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
                        context
                            .read<CacheNotifier>()
                            .cacheListShashinTeishuutsuImages(
                                widget.JYUCYU_ID + widget.index.toString(),
                                List<XFile>.from(selectedImages
                                    .where((element) =>
                                        element.runtimeType == XFile)
                                    .toList()));
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
              Container(
                width: size.width - 50,
                height: imageContainerHeight,
                padding: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: [
                      ...selectedImages.map((e) {
                        print('e: $e');
                        return SizedBox(
                          width: (imageContainerHeight / 4) - 5,
                          height: (imageContainerHeight / 4) - 5,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                  child: e.runtimeType == XFile
                                      ? Image.file(
                                          File(e.path),
                                          fit: BoxFit.cover,
                                        )
                                      : e['FILEPATH']!=null ? CachedNetworkImage(
                                          imageUrl: e['FILEPATH'],
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: CircularProgressIndicator(
                                                color: Colors.yellow,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              LocalStorageNotifier.isOfflineMode  && LocalStorageNotifier.isChoosenToday
                                              ? Image.file(
                                                File(e['FILEPATH']),
                                                fit: BoxFit.cover,
                                              )
                                              : const Icon(Icons.error),
                                        ): const Icon(Icons.error)),
                              Visibility(
                                visible: e.runtimeType == XFile,
                                child: Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 5),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedImages.remove(e);
                                            });
                                          },
                                          padding: EdgeInsets.zero,
                                          alignment: Alignment.topRight,
                                          icon: const Icon(
                                            Icons.remove_circle_rounded,
                                            color: Colors.red,
                                          )),
                                    )),
                              )
                            ],
                          ),
                        );
                      }).toList()
                    ],
                  ),
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
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         KojiichiranPage3BaoCaoHoanThanhCongTrinh(
                        //       initialDate: widget.initialDate,
                        //     ),
                        //   ),
                        // );
                        Navigator.of(context).popUntil((route) =>
                            route.settings.name == 'KojiichiranPage3');
                      },
                      child: GestureDetector(
                        onTap: () async {
                          List<dynamic> newFiles = selectedImages
                              .where((e) => e.runtimeType == XFile)
                              .toList();
                          if (newFiles.isEmpty) {
                            // ignore: use_build_context_synchronously
                            CustomToast.show(
                              context,
                              message: "写真を選択してください。。",
                              backGround: Colors.orange,
                            );
                          } else {
                            CreateRiyuu().createRiyuu(
                                JYUCYU_ID: widget.JYUCYU_ID,
                                FILE_PATH_LIST: newFiles
                                    .map((e) => e.path as String)
                                    .toList(),
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
                                  context.read<CacheNotifier>().clearShitami();

                                  Navigator.of(context).popUntil((route) =>
                                      route.settings.name ==
                                      'KojiichiranPage3');
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
