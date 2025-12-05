import 'package:flutter_bloc/flutter_bloc.dart';

import 'momo_payment_event.dart';
import 'momo_payment_state.dart';
import '../../domain/usecases/create_momo_qr_payment_uc.dart';

class MomoPaymentBloc extends Bloc<MomoPaymentEvent, MomoPaymentState> {
  final CreateMomoQrPaymentUC createMomoQrPaymentUC;

  MomoPaymentBloc({required this.createMomoQrPaymentUC})
      : super(const MomoPaymentInitial()) {
    on<CreateMomoQrPaymentEvent>(_onCreateQrPayment);
  }

  Future<void> _onCreateQrPayment(
      CreateMomoQrPaymentEvent event,
      Emitter<MomoPaymentState> emit,
      ) async {
    try {
      emit(const MomoPaymentLoading());

      final res = await createMomoQrPaymentUC(
        orderId: event.orderId,
        amount: event.amount,
        orderInfo:
        event.orderInfo ?? 'Thanh toán đơn hàng #${event.orderId}',
      );

      emit(MomoPaymentSuccess(res));
    } catch (e) {
      emit(MomoPaymentFailure(e.toString()));
    }
  }
}
