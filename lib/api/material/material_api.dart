import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/base/rest_api.dart';
import 'package:link_life_one/models/default_inventory.dart';
import 'package:link_life_one/models/material_take_back_model.dart';
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
    Function? onStart,
    required Function(bool) onSuccess,
    required Function(List<MaterialModel>) onSuccessList,
    required Function onFailed,
  }) async {

    if(onStart!=null) onStart.call();

    String urlEndpoint = '${Constant.checkSaveMaterial}TANT_CD=${user.TANT_CD}';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    print('response: ${response.data}');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      bool showPopup = false;
      if (data.isNotEmpty) {
        Map<String, dynamic> firstData = data.first;
        if (firstData.containsKey('show_popup')) {
          showPopup = firstData['show_popup'];
          onSuccess(showPopup);
        } else {
          List<MaterialModel> materials =
              data.map((e) => MaterialModel.fromJson(e)).toList();
          onSuccessList(materials);
        }
      }
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

  Future<void> deleteExistSave({
    required Function(String) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.deleteExistSave;

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
    print('SYUKKO_ID: $syukkoId');
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
    String urlEndpoint = '${Constant.getDataQRById}HINBAN=$zaikoId&LOGIN_ID=${user.TANT_CD}';

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

  Future<void> getListDefaultMaterialTakeBack({
    Function? onStart,
    required Function(List<MaterialTakeBackModel>) onSuccess,
    required Function onFailed,
  }) async {
    if(onStart!=null) onStart.call();
    String currentDate = DateFormat(('yyyy-MM-dd')).format(DateTime.now());
    String urlEndpoint =
        '${Constant.getListDefaultMaterialTakeBack}SYOZOKU_CD=${user.SYOZOKU_CD}&SYUKKO_DATE=$currentDate';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<MaterialTakeBackModel> materials =
          data.map((e) => MaterialTakeBackModel.fromJson(e)).toList();
      onSuccess(materials);
    } else {
      onFailed();
    }
  }

  Future<void> insertMaterialTakeBackById({
    required String syukkoId,
    required int? suryo,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.insertMaterialTakeBackById;

    final Response response = await RestAPI.shared.postDataWithFormData(
        urlEndpoint, {'SYUKKO_ID': syukkoId, 'SURYO': suryo??''});

    if (response.statusCode == 200) {
      onSuccess(response);
    } else {
      onFailed();
    }
  }

  Future<void> registerMaterialItem({
    required List<MaterialModel> items,
    required Function(String) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.registrationMaterialById;

    List<Map<String, dynamic>> materialJsonList = items.map((i) => i.toJson()).toList();
    Map<String, dynamic> body = {
      'MATERIAL_LIST': materialJsonList,
      'TANT_CD': user.TANT_CD
    };
    final Response response =
        await RestAPI.shared.postData(urlEndpoint, body, type: ResponseType.plain);
    if (response.statusCode == 200) {
      onSuccess('');
    } else {
      onFailed();
    }
  }

  void onBackMaterial({
    required List<MaterialModel> items,
    required Function() onSuccess,
    required Function() onFailed,
  }) async {
    String urlEndpoint = Constant.backMaterial;

    Map<String, dynamic> body = {
      'TANT_CD': user.TANT_CD,
      'materials': items.map((e) => e.toJson()).toList()
    };

    final Response response = await RestAPI.shared.postData(urlEndpoint, body);

    if (response.statusCode == 200) {
      onSuccess();
    } else {
      onFailed();
    }
  }
}
