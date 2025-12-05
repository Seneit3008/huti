import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/momo_qr_response_model.dart';

class MomoRemoteDataSource {
  final http.Client client;

  MomoRemoteDataSource({required this.client});

  /// Android emulator: 10.0.2.2 ~ localhost của máy
  static const String _baseUrl = 'http://10.0.2.2:3000/api/momo';

  Future<MomoQrResponse> createQrPayment({
    required String orderId,
    required int amount,
    required String orderInfo,
  }) async {
    final uri = Uri.parse('$_baseUrl/qr');

    final res = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'orderId': orderId,
        'amount': amount,
        'orderInfo': orderInfo,
      }),
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> data =
      jsonDecode(res.body) as Map<String, dynamic>;
      return MomoQrResponse.fromJson(data);
    } else {
      throw Exception(
        'Lỗi tạo QR MoMo: ${res.statusCode} ${res.body}',
      );
    }
  }
}
