import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/koji.dart';

class RequestPostCount {
  RequestPostCount() : super();

  Future<void> requestPostCount(
      {required Koji koji,
      required DateTime date,
      required Function() onSuccess}) async {
    final box = await Hive.openBox<String>('user');
    String loginID = box.values.last;
    final response = await http.post(
        Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Koji/requestPostUpdateSummarize.php",
        ),
        body: {
          'YMD': DateFormat(('yyyy-MM-dd')).format(date),
          'LOGIN_ID': loginID,
          'SETSAKI_ADDRESS': koji.setsakiAddress,
          'JYUCYU_ID': koji.jyucyuId
        });

    if (response.statusCode == 200) {
      onSuccess.call();
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
