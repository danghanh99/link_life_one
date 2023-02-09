import 'package:link_life_one/api/base/rest_api.dart';

import '../../constants/constant.dart';

class PostUpdateKojiReadFlg {
  PostUpdateKojiReadFlg() : super();

  Future<void> postUpdateKojiReadFlg({
    required List<String> listJYUCYU_ID,
    required Function() onSuccess,
    required Function() onFailed,
  }) async {
    try {
      var parameters = {
        'JYUCYU_ID': listJYUCYU_ID,
      };
      String endpoint =
          '${Constant.url}Request/Menu/requestPostUpdateKojiReadFlg.php';
      final response = await RestAPI.shared.postData(endpoint, parameters);
      if (response.statusCode == 200) {
        onSuccess.call();
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }
}
