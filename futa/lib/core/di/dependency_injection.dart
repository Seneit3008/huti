import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// ============= ĐĂNG NHẬP / ĐĂNG KÝ =============
import '../../features/dangNhapDangKy/data/datasources/khachHang_DS.dart';
import '../../features/dangNhapDangKy/data/repositories/khachHang_IMPL.dart';
import '../../features/dangNhapDangKy/domain/repositories/khachHang_RP.dart';

import '../../features/dangNhapDangKy/data/datasources/nhanVien_DS.dart';
import '../../features/dangNhapDangKy/data/repositories/nhanVien_IMPL.dart';
import '../../features/dangNhapDangKy/domain/repositories/nhanVien_RP.dart';

import '../../features/dangNhapDangKy/domain/usecases/dangNhapKH_UC.dart';
import '../../features/dangNhapDangKy/domain/usecases/dangNhapNV_UC.dart';
import '../../features/dangNhapDangKy/domain/usecases/dangKyKH_UC.dart';

import '../../features/dangNhapDangKy/presentation/bloc/dangNhapDangKyBloc.dart';

// ============= ĐẶT VÉ XE =============
import '../../features/datVeXe/presentation/bloc/datVeXeBloc.dart';
import '../../features/datVeXe/data/datasources/datVeXe_DS.dart';
import '../../features/datVeXe/data/repositories/datVeXe_IMPL.dart';
import '../../features/datVeXe/domain/repositories/datVeXe_RP.dart';
import '../../features/datVeXe/domain/usecases/banDoBenXe_UC.dart';

// ============= MOMO QR PAYMENT =============
import '../../features/momo_payment/data/datasources/momo_remote_data_source.dart';
import '../../features/momo_payment/data/repositories/momo_payment_repository_impl.dart';
import '../../features/momo_payment/domain/repositories/momo_payment_repository.dart';
import '../../features/momo_payment/domain/usecases/create_momo_qr_payment_uc.dart';
import '../../features/momo_payment/presentation/bloc/momo_payment_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ------------- ĐĂNG NHẬP / ĐĂNG KÝ -------------

  // Data sources
  sl.registerLazySingleton<khachHang_API>(() => khachHang_API());
  sl.registerLazySingleton<nhanVien_API>(() => nhanVien_API());

  // Repositories
  sl.registerLazySingleton<khachHang_RP>(() => khachHang_IMPL(sl()));
  sl.registerLazySingleton<nhanVien_RP>(() => nhanVien_IMPL(sl()));

  // Usecases
  sl.registerLazySingleton(() => dangNhapKH(sl()));
  sl.registerLazySingleton(() => dangNhapNV(sl()));
  sl.registerLazySingleton(() => dangKyKH(sl()));

  // Bloc
  sl.registerFactory(
        () => AuthBloc(
      DangNhapKH: sl(),
      DangKyKH: sl(),
      DangNhapNV: sl(),
    ),
  );

  // ------------- ĐẶT VÉ XE -------------

  // Data source
  sl.registerLazySingleton<datVeXe_API>(() => datVeXe_API());

  // Repository
  sl.registerLazySingleton<datVeXeRepository>(
        () => datVeXeRepositoryImpl(sl()),
  );

  // Usecase
  sl.registerLazySingleton(() => LayDSBenXe(sl()));

  // Bloc
  sl.registerFactory(() => DatVeXeBloc(layDSBenXe: sl()));

  // ------------- MOMO QR PAYMENT -------------

  // http client chung (dùng cho MoMo remote datasource)
  sl.registerLazySingleton<http.Client>(() => http.Client());

  // Data source MoMo
  sl.registerLazySingleton<MomoRemoteDataSource>(
        () => MomoRemoteDataSource(client: sl()),
  );

  // Repository MoMo
  sl.registerLazySingleton<MomoPaymentRepository>(
        () => MomoPaymentRepositoryImpl(remote: sl()),
  );

  // Usecase MoMo
  sl.registerLazySingleton<CreateMomoQrPaymentUC>(
        () => CreateMomoQrPaymentUC(sl()),
  );

  // Bloc MoMo
  sl.registerFactory<MomoPaymentBloc>(
        () => MomoPaymentBloc(createMomoQrPaymentUC: sl()),
  );
} // <--- dấu ngoặc đóng hàm initDependencies
