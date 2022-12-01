import 'dart:io';

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

class ShashinTeishuutsuHoukokuPage extends StatefulWidget {
  final DateTime? initialDate;
  final String JYUCYU_ID;
  final Function(XFile) onSelectedImage;
  const ShashinTeishuutsuHoukokuPage({
    super.key,
    this.initialDate,
    required this.onSelectedImage,
    required this.JYUCYU_ID,
  });

  @override
  State<ShashinTeishuutsuHoukokuPage> createState() =>
      _ShashinTeishuutsuHoukokuPageState();
}

class _ShashinTeishuutsuHoukokuPageState
    extends State<ShashinTeishuutsuHoukokuPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;

  void selectImage() async {
    try {
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        setState(() {
          imageFile = selectedImage;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 1000.h,
      width: 900.w,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
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
              imageFile == null
                  ? Container(
                      width: size.width - 50,
                      height: size.height * 2 / 3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                    )
                  : Image.file(
                      File(imageFile!.path),
                      width: size.width - 50,
                      height: size.height * 2 / 3,
                      fit: size.width > size.height ? null : BoxFit.fill,
                    ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(height: size.width > size.height ? 20 : 50),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 18),
              //       child: GestureDetector(
              //         onTap: () {
              //           Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => Page3BaoCaoHoanThanhCongTrinh(
              //                 initialDate: widget.initialDate,
              //               ),
              //             ),
              //           );
              //         },
              //         child: GestureDetector(
              //           onTap: () async {
              //             final box = await Hive.openBox<String>('user');
              //             String loginID = box.values.last;

              //             if (imageFile == null) {
              //               CustomToast.show(
              //                 context,
              //                 message: "Please select photo",
              //                 backGround: Colors.orange,
              //               );
              //             } else {
              //               UploadPhotoApi().uploadPhotoApi(
              //                   JYUCYU_ID: widget.JYUCYU_ID,
              //                   LOGIN_ID: loginID,
              //                   FILE_PATH: imageFile!.path,
              //                   onFailed: () {
              //                     CustomToast.show(
              //                       context,
              //                       message: "Upload photo failed ",
              //                       backGround: Colors.red,
              //                     );
              //                   },
              //                   onSuccess: () {
              //                     CustomToast.show(
              //                       context,
              //                       message: "Upload photo successfull ",
              //                       backGround: Colors.green,
              //                     );
              //                   });
              //             }
              //           },
              //           child: Container(
              //             width: 150,
              //             height: 40,
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.black, width: 1.5),
              //             ),
              //             child: const Center(
              //               child: Text(
              //                 '登録',
              //                 style: TextStyle(
              //                     fontSize: 20, fontWeight: FontWeight.w300),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
