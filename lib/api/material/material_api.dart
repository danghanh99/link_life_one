import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:link_life_one/api/base/rest_api.dart';
import 'package:link_life_one/models/default_inventory.dart';
import 'package:link_life_one/models/user.dart';
import 'package:link_life_one/shared/box_manager.dart';

import '../../constants/constant.dart';
import '../../models/material_model.dart';

class MaterialAPI {
  static final MaterialAPI _instance = MaterialAPI._internal();
  static MaterialAPI get shared => _instance;
  MaterialAPI._internal();

  User user = BoxManager.user;

  Future<void> checkSave({
    required Function(bool) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = '${Constant.checkSaveMaterial}TANT_CD=${user.TANT_CD}';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      bool showPopup = false;
      if (data.isNotEmpty) {
        showPopup = data.first['show_popup'];
      }
      onSuccess(showPopup);
    } else {
      onFailed();
    }
  }

  Future<void> getListDefaultFromEditMaterial({
    bool showPopup = true,
    required Function(List<MaterialModel>) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint =
        '${Constant.getListDefaultFromEditMaterial}TANT_CD=${user.TANT_CD}&show_popup=$showPopup';
    log(urlEndpoint);

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<MaterialModel> materials =
          data.map((e) => MaterialModel.fromJson(e)).toList();
      onSuccess(materials);
    } else {
      onFailed();
    }
  }

  Future<void> deleteListMaterial({
    required Function(String) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.deleteListMaterial;

    final Response response = await RestAPI.shared
        .postDataWithFormData(urlEndpoint, {'TANT_CD': user.TANT_CD});

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      String message = '';
      if (data.isNotEmpty) {
        message = data.first['message'];
      }
      onSuccess(message);
    } else {
      onFailed();
    }
  }

  Future<void> deleteMaterialById({
    required String syukkoId,
    required Function(String) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.deleteMaterialById;

    final Response response = await RestAPI.shared
        .postDataWithFormData(urlEndpoint, {'SYUKKO_ID': syukkoId});

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      String message = '';
      if (data.isNotEmpty) {
        message = data.first['message'];
      }
      onSuccess(message);
    } else {
      onFailed();
    }
  }

  Future<void> getDataQRById({
    required zaikoId,
    required Function(List<DefaultInventory>) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = '${Constant.getDataQRById}ZAIKO_ID=$zaikoId';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<DefaultInventory> materials =
          data.map((e) => DefaultInventory.fromJson(e)).toList();
      onSuccess(materials);
    } else {
      onFailed();
    }
  }
}
