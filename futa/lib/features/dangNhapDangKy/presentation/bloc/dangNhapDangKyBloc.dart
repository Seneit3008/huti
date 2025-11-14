// presentation/bloc/dangNhapDangKyBloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/dangNhapKH_UC.dart';
import '../../domain/usecases/dangKyKH_UC.dart';
import '../../domain/entities/taiKhoanKH_ETT.dart';

import '../../domain/usecases/dangNhapNV_UC.dart';
import '../../domain/entities/taiKhoanNV_ETT.dart';

import 'package:shared_preferences/shared_preferences.dart';
part 'dangNhapDangKyEvent.dart';
part 'dangNhapDangKyState.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final dangNhapKH DangNhapKH;
  final dangKyKH DangKyKH;
  final dangNhapNV DangNhapNV;

  AuthBloc({required this.DangNhapKH, required this.DangKyKH, required this.DangNhapNV})
      : super(AuthInitial())
  {

    on<dangNhapKH_Event>((event, emit) async {
      emit(AuthLoading());
      try {
        final khachHang = await DangNhapKH(event.email, event.password);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', khachHang.email);
        emit(khachHangSuccess(khachHang));
      } catch (e) {
        emit(khachHangFailure(e.toString()));
      }
    });

    on<dangKyKH_Event>((event, emit) async {
      emit(AuthLoading());
      try {
        final khachHang = await DangKyKH(event.name, event.email, event.password);
        emit(khachHangSuccess(khachHang));
      } catch (e) {
        emit(khachHangFailure(e.toString()));
      }
    });

    on<dangNhapNV_Event>((event, emit) async {
      emit(AuthLoading());
      try {
        final nhanVien = await DangNhapNV(event.email, event.password);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', nhanVien.email);
        emit(nhanVienSuccess(nhanVien));
      } catch (e) {
        emit(nhanVienFailure(e.toString()));
      }
    });

    on<dangXuat_Event>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      emit(AuthInitial());
    });
  }
}
