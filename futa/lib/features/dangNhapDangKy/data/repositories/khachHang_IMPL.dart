// data/repositories/khachHang_IMPL.dart
import '../../domain/entities/taiKhoanKH_ETT.dart';
import '../../domain/repositories/khachHang_RP.dart';
import '../datasources/khachHang_DS.dart';
import '../models/taiKhoanKHModel.dart';

class khachHang_IMPL implements khachHang_RP {
  final khachHang_API api;

  khachHang_IMPL(this.api);

  @override
  Future<taiKhoanKH> dangNhapKH(String email, String password) async {
    return await api.dangNhapKH(email, password);
  }

  @override
  Future<taiKhoanKH> dangKyKH(String name, String email, String password) async {
    return await api.dangKyKH(name, email, password);
  }

  @override
  Future<void> dangXuat() async {
    // chưa cần thực thi logout thực
  }
}
