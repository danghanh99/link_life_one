import "package:http/http.dart" as http;
import 'dart:convert';

class GetListPhongBan {
  GetListPhongBan() : super();

  Future<List<dynamic>> getListPhongBan(
      {required Function(List<dynamic>) onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestGetListDepartment.php"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      throw Exception('Failed to get list phong ban');
    }
  }
}
