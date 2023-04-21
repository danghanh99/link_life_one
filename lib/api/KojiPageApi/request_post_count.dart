import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/koji.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';

import '../../constants/constant.dart';

class RequestPostCount {
  RequestPostCount() : super();

  Future<dynamic> _notSuccess({
    required ymd,
    required loginId,
    required setsakiAddress,
    required jyucyuId,
    required Function() onSuccess
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().postUpdateSummarize(
          ymd: ymd,
          loginId: loginId,
          setsakiAddress: setsakiAddress,
          jyucyuId: jyucyuId
      );
      onSuccess.call();
      return res;
    }
    else{
      throw Exception('Failed');
    }
  }

  Future<void> requestPostCount(
      {required Koji koji,
      required DateTime date,
      required Function() onSuccess}) async {
    final box = await Hive.openBox<String>('user');
    String loginID = box.values.last;

    if(LocalStorageNotifier.isOfflineMode){
      return _notSuccess(
          ymd: DateFormat(('yyyy-MM-dd')).format(date),
          loginId: loginID,
          setsakiAddress: koji.setsakiAddress,
          jyucyuId: koji.jyucyuId,
          onSuccess: onSuccess
      );
    }

    try{
      final response = await http.post(
          Uri.parse(
            "${Constant.url}Request/Koji/requestPostUpdateSummarize.php",
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
        throw Exception('Failed');
      }
    }
    catch(e){
      throw Exception('Failed');
    }

  }
}
