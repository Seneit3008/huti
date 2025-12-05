import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/danhSachBenXe_Model.dart';

class datVeXe_API {
  final String baseUrl = 'http://10.0.2.2:3000/api/danhSachBenXe';

  // ⚠️ Dùng IP thật khi test trên thiết bị: VD: 'http://192.168.1.5:3000/api/auth'

  // ---------------- LOGIN ----------------
  Future<List<danhSachBenXeModel>> layDSBenXe(String query) async {
    final url = Uri.parse('$baseUrl/layDSBenXe?q=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((item) => danhSachBenXeModel.fromJson(item))
          .toList();
    } else {
      throw Exception("Lỗi API: ${response.statusCode}");
    }
  }
}
