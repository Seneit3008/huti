// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/di/dependency_injection.dart';
// import '../bloc/momo_payment_bloc.dart';
// import '../bloc/momo_payment_event.dart';
// import '../bloc/momo_payment_state.dart';
//
// class MomoQrPage extends StatelessWidget {
//   final String orderId;
//   final int amount;
//   final String orderInfo;
//
//   const MomoQrPage({
//     super.key,
//     required this.orderId,
//     required this.amount,
//     required this.orderInfo,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => sl<MomoPaymentBloc>()
//         ..add(CreateMomoQrPaymentEvent(
//           orderId: orderId,
//           amount: amount,
//           orderInfo: orderInfo,
//         )),
//       child: BlocBuilder<MomoPaymentBloc, MomoPaymentState>(
//         builder: (context, state) {
//           if (state is MomoPaymentLoading) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }
//
//           if (state is MomoPaymentFailure) {
//             return Scaffold(
//               appBar: AppBar(title: const Text('Thanh toán MoMo')),
//               body: Center(child: Text('Lỗi: ${state.message}')),
//             );
//           }
//
//           if (state is MomoPaymentQrLoaded) {
//             final qrUrl = state.response.qrCodeUrl;
//
//             return Scaffold(
//               appBar: AppBar(title: const Text('Quét QR MoMo')),
//               body: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Thanh toán: $amount VNĐ',
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     if (qrUrl != null)
//                       Image.network(qrUrl)
//                     else
//                       const Text('Không nhận được QR từ server'),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Mở app MoMo và quét mã QR này để thanh toán',
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//
//           // state initial
//           return const Scaffold(
//             body: Center(child: Text('Đang chuẩn bị thanh toán...')),
//           );
//         },
//       ),
//     );
//   }
// }
