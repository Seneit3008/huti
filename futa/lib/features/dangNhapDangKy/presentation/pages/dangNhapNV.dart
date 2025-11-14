// presentation/pages/dangNhapKH_UC.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dangNhapDangKyBloc.dart';


class DangNhapNVPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập dành cho nhân viên')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is nhanVienSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Xin chào ${state.nv.name}!')),
            );

            Navigator.pushReplacementNamed(context, '/trangChuNV');
          } else if (state is nhanVienFailure) {
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
                    dangNhapNV_Event(emailController.text, passwordController.text),
                  );
                },
                child: Text('Đăng nhập'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
