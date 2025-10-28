import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/dependency_injection.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'core/routes/app_routes.dart'; // ✅ import route riêng
import 'features/auth/presentation/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // Khởi tạo GetIt hoặc các dependency khác
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        initialRoute: AppRoutes.login, // ✅ khởi chạy vào trang Login
        onGenerateRoute: AppRoutes.onGenerateRoute, // ✅ dùng route manager
      ),
    );
  }
}
