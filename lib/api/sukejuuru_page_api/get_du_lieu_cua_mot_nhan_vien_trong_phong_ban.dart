import "package:http/http.dart" as http;
import 'dart:convert';

class GetDuLieuCuaMotNhanVienTrongPhongBan {
  GetDuLieuCuaMotNhanVienTrongPhongBan() : super();

  Future<dynamic> getDuLieuCuaMotNhanVienTrongPhongBan(
      String nhanVienId, DateTime dateTime, Function(dynamic) onSuccess) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestDefaultPerson.php?ID=${nhanVienId}&YMD=${dateTime}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      throw Exception('Failed to getDuLieuCuaMotNhanVienTrongPhongBan');
    }
  }
}
