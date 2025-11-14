// presentation/bloc/dangNhapDangKyState.dart
part of 'dangNhapDangKyBloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}

class khachHangSuccess extends AuthState {
  final taiKhoanKH kh;
  khachHangSuccess(this.kh);
}
class khachHangFailure extends AuthState {
  final String message;
  khachHangFailure(this.message);
}

class nhanVienSuccess extends AuthState {
  final taiKhoanNV nv;
  nhanVienSuccess(this.nv);
}
class nhanVienFailure extends AuthState {
  final String message;
  nhanVienFailure(this.message);
}
