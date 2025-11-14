import '../repositories/khachHang_RP.dart';
import '../entities/taiKhoanKH_ETT.dart';

class dangKyKH {
  final khachHang_RP repo;

  dangKyKH(this.repo);

  Future<taiKhoanKH> call(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Vui lòng nhập đầy đủ thông tin');
    }
    return await repo.dangKyKH(name, email, password);
  }
}