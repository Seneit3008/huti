import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

//Đăng nhập đăng ký

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



final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Data source
  sl.registerLazySingleton<khachHang_API>(() => khachHang_API());
  sl.registerLazySingleton<nhanVien_API>(() => nhanVien_API());

  // Repository
  sl.registerLazySingleton<khachHang_RP>(() => khachHang_IMPL(sl()));
  sl.registerLazySingleton<nhanVien_RP>(() => nhanVien_IMPL(sl()));

  // Use cases
  sl.registerLazySingleton(() => dangNhapKH(sl()));
  sl.registerLazySingleton(() => dangNhapNV(sl()));
  sl.registerLazySingleton(() => dangKyKH(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(DangNhapKH: sl(), DangKyKH: sl(), DangNhapNV: sl()));
}
