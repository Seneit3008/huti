import 'package:futa/features/dangNhapDangKy/domain/usecases/dangKyKH_UC.dart';
import 'package:futa/features/dangNhapDangKy/domain/usecases/dangNhapNV_UC.dart';

import '../entities/taiKhoanNV_ETT.dart';

abstract class nhanVien_RP {
  Future<taiKhoanNV> dangNhapNV(String email, String password);
  Future<void> dangXuat();
}