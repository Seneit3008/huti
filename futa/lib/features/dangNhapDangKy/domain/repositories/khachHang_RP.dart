import 'package:futa/features/dangNhapDangKy/domain/usecases/dangKyKH_UC.dart';
import 'package:futa/features/dangNhapDangKy/domain/usecases/dangNhapKH_UC.dart';

import '../entities/taiKhoanKH_ETT.dart';

abstract class khachHang_RP {
  Future<taiKhoanKH> dangNhapKH(String email, String password);
  Future<taiKhoanKH> dangKyKH(String name, String email, String password);
  Future<void> dangXuat();
}