import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetListPhongBan {
  GetListPhongBan() : super();

  Future<List<dynamic>> getListPhongBan(
      {required Function(List<dynamic>) onSuccess}) async {
    final response = await http.get(
      Uri.parse("${Constant.url}Request/Schedule/requestGetListOffice.php"),
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
