import "package:http/http.dart" as http;
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetImage {
  GetImage() : super();

  Future<dynamic> _notSuccess({
    required jyucyuId,
    required kojiSt,
    required Function() onSuccess
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().getPhotoSubmission(
          jyucyuId: jyucyuId,
          kojiSt: kojiSt
      );
      onSuccess.call();
      return res;
    }
    else{
      throw Exception('Failed to get list koji');
    }
  }

  Future<dynamic> getImage(
      {required String JYUCYU_ID,
      required String KOJI_ST,
      required String SHITAMI_MENU,
      required Function() onSuccess}) async {

    if(LocalStorageNotifier.isOfflineMode && LocalStorageNotifier.isChoosenToday){
      return _notSuccess(
          jyucyuId: JYUCYU_ID,
          kojiSt: KOJI_ST,
          onSuccess: onSuccess
      );
    }

    try{
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestPhotoSubmissionPreview.php?KOJI_ST=$KOJI_ST&SHITAMI_MENU=$SHITAMI_MENU&JYUCYU_ID=$JYUCYU_ID"),
      );
      // oke

      if (response.statusCode == 200) {
        final dynamic result = jsonDecode(response.body);
        onSuccess.call();
        return result;
      } else {
        throw Exception('Failed to get list koji');
      }
    } catch(e){
      throw Exception('Failed to get list koji');
    }

  }
}
