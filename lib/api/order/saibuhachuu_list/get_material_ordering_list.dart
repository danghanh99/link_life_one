import "package:http/http.dart" as http;
import 'dart:convert';

class GetMaterialOrderingList {
  GetMaterialOrderingList() : super();

  Future<List<dynamic>> getMaterialOrderingList({
    required String SYOZOKU_CD,
    required String JISYA_CD,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Order/requestGetMaterialOrderingList.php?SYOZOKU_CD=00000&JISYA_CD=KPMH081A41S"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      return [];
    }
  }
}
