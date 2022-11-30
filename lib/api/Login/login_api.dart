import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;

class LoginApi {
  LoginApi() : super();

  Future<void> login(
      {required String id,
      required String password,
      required Function onSuccess,
      required onFailed}) async {
    String url = "https://koji-app.starboardasiavn.com/requestLogin.php";
    final response = await http.post(Uri.parse(url),
        // body: {'LOGIN_ID': '00000', 'PASSWORD': 'lifeone0000'});
        body: {'LOGIN_ID': id, 'PASSWORD': password});

    if (response.body == "{\"error_message\":Unauthorized}[]") {
      onFailed.call();
    } else {
      if (response.statusCode == 200) {
        openBox((box) {
          box.add(jsonDecode(response.body)['TANT_CD']);
          box.values;
          onSuccess.call();
        });
      } else {
        onFailed.call();
      }
    }
  }

  void openBox(Function(Box<String>) onsuccess) async {
    final box = await Hive.openBox<String>('user');

    if (box.isOpen) {
      onsuccess.call(box);
    }
  }
}
