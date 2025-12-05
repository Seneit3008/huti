
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/banDoBenXe_UC.dart';
import '../../domain/entities/danhSachBenXe_ETT.dart';

part 'datVeXeEvent.dart';
part 'datVeXeState.dart';

class DatVeXeBloc extends Bloc<DatVeXeEvent, DatVeXeState> {
  final LayDSBenXe layDSBenXe;

  DatVeXeBloc({required this.layDSBenXe})
      : super(DatVeXeInitial())
  {
    on<layDSBenXe_Event>((event, emit) async {
      emit(DatVeXeLoading());
      try {
        final dsbx = await layDSBenXe(event.query);
        emit(DatVeXeSuccess(dsbx));
      } catch (e) {
        emit(DatVeXeFailure(e.toString()));
      }
    });


  }


}
