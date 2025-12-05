// presentation/bloc/dangNhapDangKyState.dart
part of 'datVeXeBloc.dart';

abstract class DatVeXeState {}

class DatVeXeInitial extends DatVeXeState {}
class DatVeXeLoading extends DatVeXeState {}

class DatVeXeSuccess extends DatVeXeState {
  final List<danhSachBenXe> dsbx; // ✔ List
  DatVeXeSuccess(this.dsbx);
}

class DatVeXeFailure extends DatVeXeState {
  final String message;
  DatVeXeFailure(this.message);
}
