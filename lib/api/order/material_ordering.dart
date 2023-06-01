import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/user.dart';

import '../../constants/constant.dart';

class MaterialOrdering {
  MaterialOrdering() : super();

  Future<void> postAddMaterialOrdering({
    required List<dynamic> list,
    required Function onSuccess,
    required onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String LOGIN_ID = userBox.values.last.TANT_CD;
    String LOGIN_NAME = userBox.values.last.TANT_NAME;
    String SYOZOKU_CD = userBox.values.last.SYOZOKU_CD;
    String RENKEI_YMD = DateFormat(('yyyy-MM-dd')).format(DateTime.now());

    try {
      String url =
          "${Constant.url}Request/Order/requestPostAddMaterialOrdering.php";
      final response = await http.post(
        Uri.parse(url),
        body: {
          "T_BUZAIHACYU": {
            "LOGIN_ID": "${LOGIN_ID}",
            "LOGIN_NAME": "${LOGIN_NAME}",
            "SYOZOKU_CD": "${SYOZOKU_CD}",
            "RENKEI_YMD": "${RENKEI_YMD}"
          },
          "T_BUZAIHACYUMSAI": list.toString()
        }.toString(),
      );
      if (response.statusCode == 200) {
        onSuccess.call();
        return;
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }

  Future<void> postUpdateMaterialOrdering({
    required List<dynamic> addUpdateList,
    required List<dynamic> removeList,
    required Function onSuccess,
    required onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String LOGIN_ID = userBox.values.last.TANT_CD;
    String LOGIN_NAME = userBox.values.last.TANT_NAME;
    String SYOZOKU_CD = userBox.values.last.SYOZOKU_CD;

    List<Map<String, dynamic>> removeData = removeList.map((e) => {
      'LOGIN_ID': LOGIN_ID,
      'BUZAI_HACYUMSAI_ID': e['BUZAI_HACYUMSAI_ID']
    }).toList();

    List<Map<String, dynamic>> addUpdateData = addUpdateList.map((e) => {
      "BUZAI_HACYU_ID": e['BUZAI_HACYU_ID'],
      "BUZAI_HACYUMSAI_ID": e['BUZAI_HACYUMSAI_ID'],
      "MAKER_CD": e['MAKER_CD'],
      "MAKER_NAME": e['MAKER_NAME'],
      "BUNRUI": e['BUNRUI'],
      "JISYA_CD": e['JISYA_CD'],
      "HINBAN": e['HINBAN'],
      "SYOHIN_NAME": e['SYOHIN_NAME'],
      "LOT": e['LOT'],
      "HACYU_TANKA": e['HACYU_TANKA'],
      "SURYO": e['SURYO'],
      "TANI_CD": e['TANI_CD'],
      "KINGAK": e['KINGAK']
    }).toList();

    Map<String, dynamic> body = {
      'DELETE_T_BUZAIHACYUMSAI_SAVE': removeData,
      'T_BUZAIHACYU': {
        'LOGIN_ID': LOGIN_ID,
        'TANT_NAME': LOGIN_NAME,
        'SYOZOKU_CD': SYOZOKU_CD
      },
      'T_BUZAIHACYUMSAI': addUpdateData
    };

    try {
      String url = Constant.updateMaterialOrdering;
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        onSuccess.call();
        return;
      } else {
        onFailed.call();
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
