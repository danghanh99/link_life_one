import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:link_life_one/api/base/rest_api.dart';
import 'package:link_life_one/models/inventory_schedule.dart';
import 'package:link_life_one/models/material_take_back_model.dart';
import 'package:link_life_one/models/member_category.dart';
import 'package:link_life_one/models/user.dart';
import 'package:link_life_one/shared/box_manager.dart';

import '../../constants/constant.dart';
import '../../models/default_inventory.dart';

class InventoryAPI {
  static final InventoryAPI _instance = InventoryAPI._internal();
  static InventoryAPI get shared => _instance;
  InventoryAPI._internal();

  User user = BoxManager.user;

  Future<void> getListInventorySchedule({
    Function? onStart,
    required Function(List<InventorySchedule>) onSuccess,
    required Function onFailed,
  }) async {

    if(onStart!=null) onStart.call();

    String urlEndpoint =
        '${Constant.getListInventorySchedule}SYOZOKU_CD=${user.SYOZOKU_CD}';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<InventorySchedule> schedules =
          data.map((e) => InventorySchedule.fromJson(e)).toList();
      onSuccess(schedules);
    } else {
      onFailed();
    }
  }

  Future<void> updateInventorySchedule(
    String id, {
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.updateInventoryScheduleById;

    final Response response = await RestAPI.shared
        .postDataWithFormData(urlEndpoint, {'NYUKO_ID': id});

    if (response.statusCode == 200) {
      onSuccess(response);
    } else {
      onFailed();
    }
  }

  Future<void> getListMemberCategory({
    required Function(List<MemberCategory>) onSuccess,
    required Function onFailed,
  }) async {
    String urlEndpoint = Constant.getListMemberCategory;

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<MemberCategory> members =
          data.map((e) => MemberCategory.fromJson(e)).toList();
      onSuccess(members);
    } else {
      onFailed();
    }
  }

  Future<void> getListDefaultInventory({
    String categoryCode = '',
    String makerName = '',
    String jisyaCode = '',
    String syohinName = '',
    Function? onStart,
    required Function(List<DefaultInventory>) onSuccess,
    required Function onFailed,
  }) async {

    if(onStart!=null) onStart.call();

    String urlEndpoint =
        '${Constant.getListDefaultInventory}SYOZOKU_CD=${user.SYOZOKU_CD}&CTGORY_CD=$categoryCode&MAKER_CD=$makerName&JISYA_CD=$jisyaCode&SYOHIN_NAME=$syohinName';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;

      List<DefaultInventory> inventories = [];
      for(var e in data){
        DefaultInventory inventory = DefaultInventory.fromJson(e);
        bool isJisyaExist = false;
        for(DefaultInventory prevInventory in inventories){
          if(prevInventory.jisyaCode==inventory.jisyaCode){
            isJisyaExist = true;
            prevInventory.jissu = '${int.parse(prevInventory.jissu??'0') + int.parse(inventory.jissu??'0')}';
          }
        }
        if(!isJisyaExist) {
          inventories.add(inventory);
        }
      }

      // List<DefaultInventory> inventories =
      //     data.map((e) => DefaultInventory.fromJson(e)).toList();
      onSuccess(inventories);
    } else {
      onFailed();
    }
  }

  Future<void> getListInventoryByCheckList({
    required List<DefaultInventory> selectedInventories,
    required Function(List<DefaultInventory>) onSuccess,
    required Function onFailed,
  }) async {
    List<String> arrayIds =
        selectedInventories.map((e) => e.zaikoId ?? '').toList();
    String strIds = arrayIds.join(',').replaceAll(',,', ',');
    String urlEndpoint =
        '${Constant.getListInventoryByCheckList}ARRAY_ZAIKO_ID=$strIds';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      List<DefaultInventory> inventories =
          data.map((e) => DefaultInventory.fromJson(e)).toList();
      onSuccess(inventories);
    } else {
      onFailed();
    }
  }
}
