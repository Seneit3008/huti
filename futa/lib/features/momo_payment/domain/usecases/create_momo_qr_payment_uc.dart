import '../repositories/momo_payment_repository.dart';
import '../../data/models/momo_qr_response_model.dart';

class CreateMomoQrPaymentUC {
  final MomoPaymentRepository repository;

  CreateMomoQrPaymentUC(this.repository);

  Future<MomoQrResponse> call({
    required String orderId,
    required int amount,
    required String orderInfo,
  }) {
    return repository.createQrPayment(
      orderId: orderId,
      amount: amount,
      orderInfo: orderInfo,
    );
  }
}
