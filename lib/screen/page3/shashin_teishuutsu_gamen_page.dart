import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/koji/postPhotoSubmissionRegistration/upload_photo_api.dart';
import 'package:link_life_one/components/text_line_down.dart';
import 'package:link_life_one/components/toast.dart';
import 'package:link_life_one/shared/custom_button.dart';

class ShashinTeishuutsuGamenPage extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final String HOMON_SBT;
  final String? cancelRiyuu;
  final DateTime? mitmoriYmd;
  const ShashinTeishuutsuGamenPage({
    super.key,
    this.initialDate,
    this.cancelRiyuu,
    required this.JYUCYU_ID,
    required this.HOMON_SBT,
    this.mitmoriYmd,
  });

  @override
  State<ShashinTeishuutsuGamenPage> createState() =>
      _ShashinTeishuutsuGamenPageState();
}

class _ShashinTeishuutsuGamenPageState
    extends State<ShashinTeishuutsuGamenPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> selectedImages = [];

  void selectImage() async {
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('ライブラリから画像選択'),
                onPressed: () async {
                  try {
                    List<XFile> files = await _picker.pickMultiImage();
                    if (files.isNotEmpty) {
                      setState(() {
                        selectedImages.addAll(files);
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('カメラ起動'),
                onPressed: () async {
                  try {
                    XFile? file = await _picker.pickImage(source: ImageSource.camera);
                    if (file!=null) {
                      setState(() {
                        selectedImages.add(file);
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
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
                        onClick: () {
                          print("object");
                        },
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
              Expanded(
                child: Container(
                  width: size.width - 50,
                  padding: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: [
                        ...selectedImages.map((e) {
                          return SizedBox(
                            width: ((size.width - 60)) / 6 - 5,
                            height: ((size.width - 60)) / 6 - 5,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.file(
                                    File(e.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
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
                                    ))
                              ],
                            ),
                          );
                        }).toList()
                      ],
                    ),
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
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).popUntil((route) =>
                            route.settings.name == 'KojiichiranPage3');
                      },
                      child: GestureDetector(
                        onTap: () async {
                          final box = await Hive.openBox<String>('user');
                          String loginID = box.values.last;

                          if (selectedImages.isEmpty) {
                            CustomToast.show(
                              context,
                              message: "写真を選択してください。。",
                              backGround: Colors.orange,
                            );
                          } else {
                            UploadPhotoApi().uploadPhotoApi(
                                JYUCYU_ID: widget.JYUCYU_ID,
                                LOGIN_ID: loginID,
                                HOMON_SBT: widget.HOMON_SBT,
                                FILE_PATH_LIST:
                                    selectedImages.map((e) => e.path).toList(),
                                onFailed: () {
                                  CustomToast.show(
                                    context,
                                    message: "写真のアップロードに失敗しました。。",
                                    backGround: Colors.red,
                                  );
                                },
                                onSuccess: () {
                                  CustomToast.show(
                                    context,
                                    message: "写真をアップロード出来ました。",
                                    backGround: Colors.green,
                                  );
                                  Navigator.of(context).popUntil((route) =>
                                      route.settings.name ==
                                      'KojiichiranPage3');
                                });
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 37,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA800),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: const Center(
                            child: Text(
                              '登録',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
