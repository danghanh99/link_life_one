import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;

import '../../constants/constant.dart';
import '../../models/user.dart';

class CreateOrEditApi {
  CreateOrEditApi() : super();

  Future<void> createOrEditInventory({
    required List INVENTORY_DETAIL,
    required Function onSuccess,
    required Function onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    dynamic response = await http.post(
        Uri.parse(
            "${Constant.url}Request/Order/requesPostInventoryListWithSaved.php"),
        body: {
          'USER_INFO': {
            'LOGIN_ID': user.TANT_CD,
            'SYOZOKU_CD': user.SYOZOKU_CD
          },
          'INVENTORY_DETAIL': INVENTORY_DETAIL.toString()
        }.toString());

    if (response.statusCode == 200) {
      onSuccess.call();
    } else {
      onFailed.call();
    }
  }
}
