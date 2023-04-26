import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../constants/constant.dart';

class UploadChangedDataAPI {
  UploadChangedDataAPI() : super();

  Future<void> uploadDB({
    required body,
    required Function onSuccess,
    required Function onFailed,
  }) async {

    try{
      final response = await http.post(
          Uri.parse(
            "${Constant.url}/Request/Koji/requestOfflineSync.php",
          ),

          body: json.encode(body));
      // print('res: $response');
      if (response.statusCode == 200) {
        print('res success: $response');
        await onSuccess.call();
      } else {
        print('res failed: $response');
        print('res body: ${response.body}');
        await onFailed.call();
      }
    } catch(e){
      print('catch: $e');
      await onFailed.call();
    }

  }
}
