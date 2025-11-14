import 'dart:convert';
import 'package:futa/features/dangNhapDangKy/domain/usecases/dangNhapNV_UC.dart';
import 'package:http/http.dart' as http;
import '../models/taiKhoanNVModel.dart';

class nhanVien_API {
  final String baseUrl = 'http://10.0.2.2:3000/api/dangNhapDangKy';
  // ⚠️ Dùng IP thật khi test trên thiết bị: VD: 'http://192.168.1.5:3000/api/auth'

  Future<taiKhoanNVModel> dangNhapNV(String email, String password) async {
    final url = Uri.parse('$baseUrl/dangNhapNV');
    print(email);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return taiKhoanNVModel.fromJson(data['nhanVien']); // data['user'] do Node.js trả về
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Đăng nhập thất bại';
      throw Exception(error);
    }
  }

}
