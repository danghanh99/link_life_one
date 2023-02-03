import 'package:dio/dio.dart';
import 'package:link_life_one/api/base/rest_api.dart';
import 'package:link_life_one/models/user.dart';
import 'package:link_life_one/shared/box_manager.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class InventoryAPI {
  static final InventoryAPI _instance = InventoryAPI._internal();
  static InventoryAPI get shared => _instance;
  InventoryAPI._internal();

  User user = BoxManager.user;

  Future<void> getListInventorySchedule({
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint =
        '${Constant.getListInventorySchedule}SYOZOKU_CD=${user.SYOZOKU_CD}';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      onSuccess(response);
    } else {
      onFailed(response);
    }
  }

  Future<void> updateInventorySchedule(
    int id, {
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.updateInventoryScheduleById;

    final Response response = await RestAPI.shared
        .postDataWithFormData(urlEndpoint, {'NYUKO_ID': id});

    if (response.statusCode == 200) {
      onSuccess(response);
    } else {
      onFailed(response);
    }
  }
}
