// data/repositories/nhanVien_IMPL.dart

import '../../domain/entities/taiKhoanNV_ETT.dart';
import '../../domain/repositories/nhanVien_RP.dart';
import '../datasources/nhanVien_DS.dart';
import '../models/taiKhoanNVModel.dart';

class nhanVien_IMPL implements nhanVien_RP {
  final nhanVien_API api;

  nhanVien_IMPL(this.api);

  @override
  Future<taiKhoanNV> dangNhapNV(String email, String password) async {
    return await api.dangNhapNV(email, password);
  }

  @override
  Future<void> dangXuat() async {
    // chưa cần thực thi logout thực
  }
}
