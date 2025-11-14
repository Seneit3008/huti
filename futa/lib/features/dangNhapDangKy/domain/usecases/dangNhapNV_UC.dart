import '../repositories/nhanVien_RP.dart';
import '../entities/taiKhoanNV_ETT.dart';

class dangNhapNV {
  final nhanVien_RP repo;

  dangNhapNV(this.repo);

  Future<taiKhoanNV> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email và mật khẩu không được để trống');
    }
    return await repo.dangNhapNV(email, password);
  }
}