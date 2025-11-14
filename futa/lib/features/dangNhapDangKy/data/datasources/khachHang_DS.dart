import 'dart:convert';
import 'package:futa/features/dangNhapDangKy/domain/usecases/dangNhapKH_UC.dart';
import 'package:http/http.dart' as http;
import '../models/taiKhoanKHModel.dart';

class khachHang_API {
  final String baseUrl = 'http://10.0.2.2:3000/api/dangNhapDangKy';
  // ⚠️ Dùng IP thật khi test trên thiết bị: VD: 'http://192.168.1.5:3000/api/auth'

  Future<taiKhoanKHModel> dangNhapKH(String email, String password) async {
    final url = Uri.parse('$baseUrl/dangNhapKH');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );


    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return taiKhoanKHModel.fromJson(data['khachHang']); // data['user'] do Node.js trả về
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Đăng nhập thất bại';
      throw Exception(error);
    }
  }


  Future<taiKhoanKHModel> dangKyKH(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/dangKyKH');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return taiKhoanKHModel.fromJson(data['khachHang']);
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Đăng ký thất bại';
      throw Exception(error);
    }
  }
}
