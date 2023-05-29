import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:link_life_one/models/buzai.dart';
import 'dart:convert';
import '../../constants/constant.dart';
import '../../models/user.dart';

class GetBuzaiApi {
  GetBuzaiApi() : super();

  Future<void> getBuzai({
    String? buzaiBunrui,
    String? makerName,
    String? hinban,
    String? syohinName,
    required Function onStart,
    required Function(List<Buzai> list) onSuccess,
    required Function onFailed,
  }) async {
    onStart();
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    String SYOZOKU_CD = user.SYOZOKU_CD;
    dynamic response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetInventoryListMaterialListSearch.php?BUZAI_BUNRUI=${buzaiBunrui??''}&MAKER_NAME=${makerName??''}&HINBAN=${hinban??''}&SYOHIN_NAME=${syohinName??''}&SYOZOKU_CD=$SYOZOKU_CD"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      final List<Buzai> list = body.map((e) {
        return Buzai.fromJson(e);
      }).toList();
      onSuccess.call(list);
    } else {
      onFailed.call();
    }
  }
}
