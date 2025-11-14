import '../repositories/khachHang_RP.dart';
import '../entities/taiKhoanKH_ETT.dart';

class dangNhapKH {
  final khachHang_RP repo;

  dangNhapKH(this.repo);

  Future<taiKhoanKH> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email và mật khẩu không được để trống');
    }
    return await repo.dangNhapKH(email, password);
  }
}