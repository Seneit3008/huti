import '../../domain/repositories/momo_payment_repository.dart';
import '../datasources/momo_remote_data_source.dart';
import '../models/momo_qr_response_model.dart';

class MomoPaymentRepositoryImpl implements MomoPaymentRepository {
  final MomoRemoteDataSource remote;

  MomoPaymentRepositoryImpl({required this.remote});

  @override
  Future<MomoQrResponse> createQrPayment({
    required String orderId,
    required int amount,
    required String orderInfo,
  }) {
    return remote.createQrPayment(
      orderId: orderId,
      amount: amount,
      orderInfo: orderInfo,
    );
  }
}
