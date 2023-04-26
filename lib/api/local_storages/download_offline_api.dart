import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../../constants/constant.dart';

class DownloadOfflineAPI {
  DownloadOfflineAPI() : super();

  Future<void> getDB({
    required Function(Map<String, dynamic> response) onSuccess,
    required Function onFailed,
  }) async {

    try{
      final response = await http.get(
        Uri.parse(
            // "${Constant.url}/Request/Koji/requestOfflineDownload.php?CURRENT_DAY=2022-11-09"),
            "${Constant.url}/Request/Koji/requestOfflineDownload.php?CURRENT_DAY=${DateFormat('yyyy-MM-dd').format(DateTime.now())}"),/////////////////////////////////////////////////
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        await onSuccess.call(body);
      } else {
        await onFailed.call();
      }
    } catch(e){
      await onFailed.call();
    }

  }
}
