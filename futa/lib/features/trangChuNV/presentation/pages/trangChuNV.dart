import 'package:flutter/material.dart';
import 'package:futa/features/thongBao/presentation/pages/thongBao.dart';
import 'package:futa/features/thongtinCaNhan/presentation/pages/thongTinCaNhan.dart';
import 'package:futa/core/utils/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futa/features/dangNhapDangKy/presentation/bloc/dangNhapDangKyBloc.dart';
class TrangChuNV extends StatefulWidget {
  const TrangChuNV({super.key});

  @override
  State<TrangChuNV> createState() => _TrangChuNVState();

}
class _TrangChuNVState extends State<TrangChuNV> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Trang chủ Nhân viên"),
          automaticallyImplyLeading: false,
      ),
      body: ElevatedButton(
        onPressed: () async {
          context.read<AuthBloc>().add(dangXuat_Event());
          Navigator.pushReplacementNamed(context, '/');
        },
        child: const Text('Logout'),
      ),
    );
  }


}



