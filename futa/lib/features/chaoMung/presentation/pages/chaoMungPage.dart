import 'package:flutter/material.dart';

class ChaoMungPage extends StatelessWidget {
  const ChaoMungPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ FUTA'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🎉 Chào mừng bạn đến FUTA!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Quay lại trang login khi bấm đăng xuất
                Navigator.pushNamed(context, '/dangNhapNV');
              },
              child: const Text('Đăng nhập dành cho nhân viên'),
            ),
            ElevatedButton(
              onPressed: () {
                // Quay lại trang login khi bấm đăng xuất
                Navigator.pushNamed(context, '/dangNhapKH');
              },
              child: const Text('Đăng nhập dành cho khách hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
