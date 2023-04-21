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
          body: body);

      if (response.statusCode == 200) {
        await onSuccess.call();
      } else {
        await onFailed.call();
      }
    } catch(e){
      await onFailed.call();
    }

  }
}
