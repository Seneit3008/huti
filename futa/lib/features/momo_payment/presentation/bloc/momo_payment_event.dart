import 'package:equatable/equatable.dart';

abstract class MomoPaymentEvent extends Equatable {
  const MomoPaymentEvent();

  @override
  List<Object?> get props => [];
}

class CreateMomoQrPaymentEvent extends MomoPaymentEvent {
  final String orderId;
  final int amount;
  final String? orderInfo;   // <<< cho phép null

  const CreateMomoQrPaymentEvent({
    required this.orderId,
    required this.amount,
    this.orderInfo,
  });

  @override
  List<Object?> get props => [orderId, amount, orderInfo];
}
