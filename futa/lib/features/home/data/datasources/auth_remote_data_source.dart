import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:3000/api/auth';
  // ⚠️ Dùng IP thật khi test trên thiết bị: VD: 'http://192.168.1.5:3000/api/auth'

  // ---------------- LOGIN ----------------
  Future<UserModel> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['user']); // data['user'] do Node.js trả về
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Đăng nhập thất bại';
      throw Exception(error);
    }
  }

  // ---------------- REGISTER ----------------
  Future<UserModel> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      final error = jsonDecode(response.body)['message'] ?? 'Đăng ký thất bại';
      throw Exception(error);
    }
  }
}
