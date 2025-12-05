import '../repositories/datVeXe_RP.dart';
import '../entities/danhSachBenXe_ETT.dart';

class LayDSBenXe {
  final datVeXeRepository repository;

  LayDSBenXe(this.repository);

  Future<List<danhSachBenXe>> call(String query) {
    return repository.layDSBenXe(query);
  }
}