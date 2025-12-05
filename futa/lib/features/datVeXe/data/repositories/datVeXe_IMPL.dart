// data/repositories/khachHang_IMPL.dart
import '../../domain/entities/danhSachBenXe_ETT.dart';
import '../../domain/repositories/datVeXe_RP.dart';
import '../datasources/datVeXe_DS.dart';

class datVeXeRepositoryImpl implements datVeXeRepository {
  final datVeXe_API remoteDataSource;

  datVeXeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<danhSachBenXe>> layDSBenXe(String query) async {
    return await remoteDataSource.layDSBenXe(query);
  }

}
