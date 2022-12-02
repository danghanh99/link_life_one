import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;

class SubmitLastPage {
  SubmitLastPage() : super();

  Future<void> submitLastPage(
      {required String SINGLE_SUMMARIZE,
      required String JYUCYU_ID,
      required String CHECK_FLG1,
      required String CHECK_FLG2,
      required String CHECK_FLG3,
      required String CHECK_FLG4,
      required String CHECK_FLG5,
      required String CHECK_FLG6,
      required String CHECK_FLG7,
      required List<dynamic> list,
      required Function onSuccess,
      required onFailed}) async {
    try {
      List<dynamic> list2 = [];
      if (list.isNotEmpty) {
        for (var element in list) {
          list2.add({
            "SURYO": element["SURYO"],
            "HANBAI_TANKA": element["HANBAI_TANKA"],
            "KINGAK": element["KINGAK"],
            "TUIKA_JISYA_CD": element["TUIKA_JISYA_CD"],
            "TUIKA_SYOHIN_NAME": element["TUIKA_SYOHIN_NAME"]
          });
        }
      }

      String url = "https://koji-app.starboardasiavn.com/requestConsent.php";
      final response = await http.post(
        Uri.parse(url),
        body: {
          "SINGLE_SUMMARIZE": SINGLE_SUMMARIZE,
          "JYUCYU_ID": JYUCYU_ID,
          "BIKO": "",
          "KENSETU_KEITAI": "",
          "BEF_SEKO_PHOTO_FILEPATH": "",
          "AFT_SEKO_PHOTO_FILEPATH": "",
          "OTHER_PHOTO_FOLDERPATH": "",
          "CHECK_FLG": {
            [
              {
                "CHECK_FLG1": CHECK_FLG1,
                "CHECK_FLG2": CHECK_FLG2,
                "CHECK_FLG3": CHECK_FLG3,
                "CHECK_FLG4": CHECK_FLG4,
                "CHECK_FLG5": CHECK_FLG5,
                "CHECK_FLG6": CHECK_FLG6,
                "CHECK_FLG7": CHECK_FLG7
              }
            ]
          },
          "NEW_DETAIL": list2.toString()
        }.toString(),
      );

      if (response.body == "{\"error_message\":Unauthorized}[]") {
        onFailed.call();
      } else {
        if (response.statusCode == 200) {
          // openBox((box) {
          //   box.add(jsonDecode(response.body)['TANT_CD']);
          //   box.values;
          onSuccess.call();
          // });
        } else {
          onFailed.call();
        }
      }
    } catch (e) {
      onFailed.call();
    }
  }

  void openBox(Function(Box<String>) onsuccess) async {
    final box = await Hive.openBox<String>('user');

    if (box.isOpen) {
      onsuccess.call(box);
    }
  }
}
