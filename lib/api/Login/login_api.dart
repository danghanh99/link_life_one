import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;

import '../../models/user.dart';

class LoginApi {
  LoginApi() : super();

  Future<void> login(
      {required String id,
      required String password,
      required Function onSuccess,
      required onFailed}) async {
    String url =
        "https://koji-app.starboardasiavn.com/Request/Login/requestLogin.php";
    final response = await http.post(Uri.parse(url),
        // body: {'LOGIN_ID': '00000', 'PASSWORD': 'lifeone0000'});
        body: {'LOGIN_ID': id, 'PASSWORD': password});

    if (response.body == "{\"error_message\":Unauthorized}[]") {
      onFailed.call();
    } else {
      if (response.statusCode == 200) {
        openBox((box, userBox) {
          box.add(jsonDecode(response.body)['TANT_CD']);
          final result = jsonDecode(response.body);
          User user = User(
            TANT_CD: result["TANT_CD"] ?? '',
            TANT_NAME: result["TANT_NAME"] ?? '',
            TANT_KNAME: result["TANT_KNAME"] ?? '',
            BUZAI_HACOK_FLG: result["BUZAI_HACOK_FLG"] ?? '',
            SYOZOKUBUSYO_CD: result["SYOZOKUBUSYO_CD"] ?? '',
            PASSWORD: result["PASSWORD"] ?? '',
            PASSWORD_UPD_YMD: result["PASSWORD_UPD_YMD"] ?? '',
            MENUPTN_CD: result["MENUPTN_CD"] ?? '',
            TANT_KBN_CD: result["TANT_KBN_CD"] ?? '',
            SYOZOKU_CD: result["SYOZOKU_CD"] ?? '',
            KENGEN_CD: result["KENGEN_CD"] ?? '',
            DAYLY_SALES: result["DAYLY_SALES"] ?? '',
            MONTHLY_SALES: result["MONTHLY_SALES"] ?? '',
            KAISYU_RUIKEI: result["KAISYU_RUIKEI"] ?? '',
            DEL_FLG: result["DEL_FLG"] ?? '',
            ADD_PGID: result["ADD_PGID"] ?? '',
            ADD_TANTCD: result["ADD_TANTCD"] ?? '',
            ADD_YMD: result["ADD_YMD"] ?? '',
            UPD_PGID: result["UPD_PGID"] ?? '',
            UPD_TANTCD: result["UPD_TANTCD"] ?? '',
            UPD_YMD: result["UPD_YMD"] ?? '',
          );

          box.values;

          userBox.add(user);
          userBox.values.last;
          onSuccess.call();
        });
      } else {
        onFailed.call();
      }
    }
  }

  void openBox(Function(Box<String>, Box<User>) onsuccess) async {
    final box = await Hive.openBox<String>('user');
    final userBox = await Hive.openBox<User>('userBox');

    if (box.isOpen && userBox.isOpen) {
      onsuccess.call(box, userBox);
    }
  }
}
