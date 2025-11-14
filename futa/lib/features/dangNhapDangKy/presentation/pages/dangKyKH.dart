import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dangNhapDangKyBloc.dart';

class DangKyKHPage extends StatefulWidget {
  const DangKyKHPage({super.key});

  @override
  State<DangKyKHPage> createState() => _DangKyKHPageState();
}

class _DangKyKHPageState extends State<DangKyKHPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // ✅ Các điều kiện mật khẩu
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
      hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
      hasNumber = RegExp(r'[0-9]').hasMatch(password);
      hasSpecialChar = RegExp(r'[!@#\$&*~]').hasMatch(password);
    });
  }

  // ✅ Hiển thị dòng kiểm tra từng điều kiện
  Widget _buildCheckItem(bool condition, String text) {
    return Row(
      children: [
        Icon(
          condition ? Icons.check_circle : Icons.cancel,
          color: condition ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký khách hàng')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is khachHangSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('🎉 Chào mừng ${state.kh.name}!')),
            );
            Navigator.pushReplacementNamed(context, '/trangChuKH');
          } else if (state is khachHangFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Họ và tên'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                onChanged: _validatePassword,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Yêu cầu mật khẩu:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              _buildCheckItem(hasMinLength, "Ít nhất 8 ký tự"),
              _buildCheckItem(hasUpperCase, "Chứa ít nhất 1 chữ hoa (A-Z)"),
              _buildCheckItem(hasLowerCase, "Chứa ít nhất 1 chữ thường (a-z)"),
              _buildCheckItem(hasNumber, "Chứa ít nhất 1 chữ số (0-9)"),
              _buildCheckItem(
                  hasSpecialChar, "Chứa ít nhất 1 ký tự đặc biệt (!@<#\$&*~)"),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: (hasMinLength &&
                      hasUpperCase &&
                      hasLowerCase &&
                      hasNumber &&
                      hasSpecialChar)
                      ? () {
                    context.read<AuthBloc>().add(
                      dangKyKH_Event(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      ),
                    );
                  }
                      : null, // disable nếu chưa đủ điều kiện
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
