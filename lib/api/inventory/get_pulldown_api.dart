import "package:http/http.dart" as http;
import 'dart:convert';

class GetPullDownApi {
  GetPullDownApi() : super();

  Future<void> getPullDown({
    required Function(List<dynamic> list) onSuccess,
    required Function onFailed,
  }) async {
    final dynamic response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Order/requestGetPullDownCategory.php"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
    } else {
      onFailed.call();
    }
  }
}
