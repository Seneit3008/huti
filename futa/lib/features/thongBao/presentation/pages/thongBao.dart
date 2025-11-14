import 'package:flutter/material.dart';

class thongBao extends StatelessWidget {
  const thongBao({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Không có thông báo mới",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
