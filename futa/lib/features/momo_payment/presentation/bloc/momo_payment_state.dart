import 'package:equatable/equatable.dart';
import '../../data/models/momo_qr_response_model.dart';

abstract class MomoPaymentState extends Equatable {
  const MomoPaymentState();

  @override
  List<Object?> get props => [];
}

class MomoPaymentInitial extends MomoPaymentState {
  const MomoPaymentInitial();
}

class MomoPaymentLoading extends MomoPaymentState {
  const MomoPaymentLoading();
}

class MomoPaymentSuccess extends MomoPaymentState {
  final MomoQrResponse response;

  const MomoPaymentSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class MomoPaymentFailure extends MomoPaymentState {
  final String message;

  const MomoPaymentFailure(this.message);

  @override
  List<Object?> get props => [message];
}
