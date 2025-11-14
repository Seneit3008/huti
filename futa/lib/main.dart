import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/dependency_injection.dart';
import 'features/dangNhapDangKy/presentation/bloc/dangNhapDangKyBloc.dart';
import 'core/routes/app_routes.dart'; // ✅ import route riêng
import 'features/dangNhapDangKy/presentation/pages/dangNhapKH.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('email');
  await initDependencies(); // Khởi tạo GetIt hoặc các dependency khác
  runApp(MyApp(initialRoute: token != null ? '/trangChuNV' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(), // sl là GetIt instance
        ),
      ],
      child: MaterialApp(
        title: 'Clean Architecture Auth App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        initialRoute: initialRoute, // ✅ khởi chạy vào trang Login
        onGenerateRoute: AppRoutes.onGenerateRoute, // ✅ dùng route manager
      ),
    );
  }
}
