import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependency_injection.dart';
import 'features/momo_payment/presentation/bloc/momo_payment_bloc.dart';
import 'features/momo_payment/presentation/pages/momo_qr_test_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MomoQrTestApp());
}

class MomoQrTestApp extends StatelessWidget {
  const MomoQrTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MomoPaymentBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test MoMo QR',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        home: const MomoQrTestPage(),
      ),
    );
  }
}
