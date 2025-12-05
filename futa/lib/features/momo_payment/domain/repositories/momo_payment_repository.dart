// lib/features/momo_payment/domain/repositories/momo_payment_repository.dart
import '../../data/models/momo_qr_response_model.dart';

abstract class MomoPaymentRepository {
  Future<MomoQrResponse> createQrPayment({
    required String orderId,
    required int amount,
    required String orderInfo,
  });
}
