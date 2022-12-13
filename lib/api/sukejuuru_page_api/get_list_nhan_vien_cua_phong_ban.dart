import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetListNhanVienCuaPhongBan {
  GetListNhanVienCuaPhongBan() : super();

  Future<List<dynamic>> getListNhanVienCuaPhongBan(
      String KOJIGYOSYA_CD, Function(List<dynamic>) onSuccess) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Schedule/requestGetListPeople.php?KOJIGYOSYA_CD=${KOJIGYOSYA_CD}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      throw Exception('Failed to GetListNhanVienCuaPhongBan');
    }
  }
}
