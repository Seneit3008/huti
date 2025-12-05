import 'package:flutter/material.dart';
import '../../features/dangNhapDangKy/presentation/pages/dangNhapKH.dart';
import '../../features/dangNhapDangKy/presentation/pages/dangNhapNV.dart';
import '../../features/dangNhapDangKy/presentation/pages/dangKyKH.dart';
import '../../features/chaoMung/presentation/pages/chaoMungPage.dart';
import '../../features/trangChuNV/presentation/pages/trangChuNV.dart';
import '../../features/trangChuKH/presentation/pages/trangChuKH.dart';
import '../../features/datVeXe/presentation/pages/datVeXe.dart';
import '../../features/datVeXe/presentation/pages/danhSachDiemDi.dart';
class AppRoutes {

  static const String chaoMung = '/';

  static const String dangNhapNV = '/dangNhapNV';
  static const String dangNhapKH = '/dangNhapKH';
  static const String dangKyKH = '/dangKyKH';


  static const String trangChuKH = '/trangChuKH';

  static const String datVeXe = '/datVeXe';
  static const String danhSachDiemDi = '/danhSachDiemDi';

  static const String trangChuNV = '/trangChuNV';


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case chaoMung:
        return MaterialPageRoute(builder: (_) => ChaoMungPage());
      case dangNhapKH:
        return MaterialPageRoute(builder: (_) => DangNhapKHPage());
      case dangNhapNV:
        return MaterialPageRoute(builder: (_) => DangNhapNVPage());
      case dangKyKH:
        return MaterialPageRoute(builder: (_) => DangKyKHPage());
      case trangChuNV:
        return MaterialPageRoute(builder: (_) => TrangChuNV());
      case trangChuKH:
        return MaterialPageRoute(builder: (_) => TrangChuKH());
      case datVeXe:
        return MaterialPageRoute(builder: (_) => DatVeXe());
      case danhSachDiemDi:
        return MaterialPageRoute(builder: (_) => DanhSachDiemDi());
      default:
        print(settings.name);
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                '❌ Route not found',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
          ),
        );
    }
  }
}
