import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../bloc/momo_payment_bloc.dart';
import '../bloc/momo_payment_event.dart';
import '../bloc/momo_payment_state.dart';
import '../../data/models/momo_qr_response_model.dart';

class MomoQrTestPage extends StatefulWidget {
  const MomoQrTestPage({super.key});

  @override
  State<MomoQrTestPage> createState() => _MomoQrTestPageState();
}

class _MomoQrTestPageState extends State<MomoQrTestPage> {
  late final TextEditingController _orderIdController;
  final TextEditingController _amountController =
  TextEditingController(text: '10000');
  final TextEditingController _orderInfoController =
  TextEditingController(text: 'Thanh toán đơn hàng test');

  @override
  void initState() {
    super.initState();
    _orderIdController = TextEditingController(
      text: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  @override
  void dispose() {
    _orderIdController.dispose();
    _amountController.dispose();
    _orderInfoController.dispose();
    super.dispose();
  }

  void _createQr(BuildContext context) {
    final orderId = _orderIdController.text.trim();
    final amountStr = _amountController.text.trim();
    final orderInfo = _orderInfoController.text.trim().isEmpty
        ? null
        : _orderInfoController.text.trim();

    if (orderId.isEmpty || amountStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nhập orderId và amount')),
      );
      return;
    }

    final amount = int.tryParse(amountStr);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount phải là số > 0')),
      );
      return;
    }

    context.read<MomoPaymentBloc>().add(
      CreateMomoQrPaymentEvent(
        orderId: orderId,
        amount: amount,
        orderInfo: orderInfo,
      ),
    );
  }

  Widget _buildSuccess(MomoQrResponse res) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Tạo QR thành công!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        Text('OrderId: ${res.orderId}'),
        const SizedBox(height: 16),
        if (res.qrCodeUrl.isNotEmpty)
          QrImageView(
            data: res.qrCodeUrl,
            version: QrVersions.auto,
            size: 220,
          )
        else
          const Text('Không có qrCodeUrl / payUrl trả về'),
        const SizedBox(height: 12),
        if (res.deeplink != null)
          SelectableText(
            'Deeplink: ${res.deeplink}',
            style: const TextStyle(fontSize: 12),
          ),
        const SizedBox(height: 8),
        SelectableText(
          'QR / payUrl: ${res.qrCodeUrl}',
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 8),
        const Text(
          'Dùng app MoMo quét mã này (sandbox) để test.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test thanh toán MoMo (Sandbox)'),
      ),
      body: BlocConsumer<MomoPaymentBloc, MomoPaymentState>(
        listener: (context, state) {
          if (state is MomoPaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Thông tin đơn hàng test',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _orderIdController,
                  decoration: const InputDecoration(
                    labelText: 'Order ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Số tiền (VND)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _orderInfoController,
                  decoration: const InputDecoration(
                    labelText: 'Order info (optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: state is MomoPaymentLoading
                      ? null
                      : () => _createQr(context),
                  child: state is MomoPaymentLoading
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('TẠO MÃ QR TEST'),
                ),
                const SizedBox(height: 24),
                if (state is MomoPaymentSuccess)
                  _buildSuccess(state.response)
                else if (state is MomoPaymentInitial)
                  const Text(
                    'Nhập thông tin rồi bấm "TẠO MÃ QR TEST".',
                    textAlign: TextAlign.center,
                  )
                else
                  const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
