// presentation/bloc/dangNhapDangKyEvent.dart
part of 'datVeXeBloc.dart';

abstract class DatVeXeEvent {}

class layDSBenXe_Event extends DatVeXeEvent {
  final String query;
  layDSBenXe_Event(this.query);
}
