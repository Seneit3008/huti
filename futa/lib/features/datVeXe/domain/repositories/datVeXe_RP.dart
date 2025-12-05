import '../entities/danhSachBenXe_ETT.dart';

abstract class datVeXeRepository {
  Future<List<danhSachBenXe>> layDSBenXe(String query);
}