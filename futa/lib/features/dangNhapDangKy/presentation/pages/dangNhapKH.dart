// presentation/pages/dangNhapKH_UC.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dangNhapDangKyBloc.dart';


class DangNhapKHPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập dành cho khách hàng')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is khachHangSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Xin chào ${state.kh.name}!')),
            );

            Navigator.pushReplacementNamed(context, '/trangChuKH');
          } else if (state is khachHangFailure) {
            print(1);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Mật khẩu'), obscureText: true),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                    dangNhapKH_Event(emailController.text, passwordController.text),
                  );
                },
                child: Text('Đăng nhập'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dangKyKH');
                },
                child: Text('Chưa có tài khoản? Đăng ký'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
