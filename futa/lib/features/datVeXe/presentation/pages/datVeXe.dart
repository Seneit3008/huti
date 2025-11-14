import 'package:flutter/material.dart';
import 'package:futa/features/thongBao/presentation/pages/thongBao.dart';
import 'package:futa/features/thongtinCaNhan/presentation/pages/thongTinCaNhan.dart';
import 'package:futa/core/utils/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futa/features/dangNhapDangKy/presentation/bloc/dangNhapDangKyBloc.dart';
import 'package:intl/intl.dart';


class DatVeXe extends StatefulWidget {
  const DatVeXe({super.key});

  @override
  State<DatVeXe> createState() => _DatVeXeState();

}
class _DatVeXeState extends State<DatVeXe> {

  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  bool _isRoundTrip = false;
  DateTime? _departDate;
  DateTime? _returnDate;
  int _tickets = 1;

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _pickDepartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _departDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      setState(() {
        _departDate = picked;
        // nếu returnDate trước departDate thì clear returnDate
        if (_returnDate != null && _returnDate!.isBefore(_departDate!)) {
          _returnDate = null;
        }
      });
    }
  }

  Future<void> _pickReturnDate() async {
    if (_departDate == null) {
      // yêu cầu chọn ngày đi trước
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ngày đi trước khi chọn ngày về')),
      );
      return;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: _returnDate ?? _departDate!.add(const Duration(days: 1)),
      firstDate: _departDate!.add(const Duration(days: 1)),
      lastDate: DateTime(_departDate!.year + 2),
    );
    if (picked != null) {
      setState(() {
        _returnDate = picked;
      });
    }
  }

  void _incrementTickets() {
    setState(() {
      if (_tickets < 9) _tickets++;
    });
  }

  void _decrementTickets() {
    setState(() {
      if (_tickets > 1) _tickets--;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_departDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ngày đi')),
      );
      return;
    }

    if (_isRoundTrip && _returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ngày về')),
      );
      return;
    }

    // thêm kiểm tra ngày hợp lệ
    if (_isRoundTrip && _returnDate!.isBefore(_departDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ngày về phải sau ngày đi')),
      );
      return;
    }

    // Ở đây bạn có thể gọi API hoặc điều hướng sang màn kết quả tìm vé
    final summary = StringBuffer()
      ..writeln('Đi từ: ${_fromController.text.trim()}')
      ..writeln('Đến: ${_toController.text.trim()}')
      ..writeln('Hành trình: ${_isRoundTrip ? 'Khứ hồi' : 'Một chiều'}')
      ..writeln('Ngày đi: ${_dateFormat.format(_departDate!)}')
      ..writeln('Ngày về: ${_returnDate != null ? _dateFormat.format(_returnDate!) : '-'}')
      ..writeln('Số vé: $_tickets');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Xác nhận tìm vé'),
        content: Text(summary.toString()),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đang tìm vé... (ví dụ gọi API ở đây)')),
              );
            },
            child: const Text('Xác nhận'),
          )
        ],
      ),
    );
  }

  Widget _buildDateTile({
    required String label,
    required String? value,
    required VoidCallback onTap,
    required IconData icon,
    bool enabled = true,
  }) {
    return ListTile(
      enabled: enabled,
      onTap: enabled ? onTap : null,
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value ?? 'Chưa chọn', style: const TextStyle(color: Colors.black87)),
      trailing: const Icon(Icons.calendar_today),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt vé xe'),
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Điểm đi / Điểm đến
                TextFormField(
                  controller: _fromController,
                  decoration: InputDecoration(
                    labelText: 'Điểm đi',
                    hintText: 'Nhập thành phố hoặc bến đi',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.location_on_outlined, color: Colors.blue),
                      onPressed: () {
                        Navigator.pushNamed(context, '/danhSachDiemDi');
                      },
                    ),
                  ),
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Vui lòng nhập điểm đi' : null,
                ),


                const SizedBox(height: 12),
                TextFormField(
                  controller: _toController,
                  decoration: const InputDecoration(
                    labelText: 'Điểm đến',
                    hintText: 'Nhập thành phố hoặc bến đến',
                    prefixIcon: Icon(Icons.flag_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Vui lòng nhập điểm đến';
                    if (v.trim().toLowerCase() == _fromController.text.trim().toLowerCase()) {
                      return 'Điểm đi và điểm đến phải khác nhau';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                // Khứ hồi
                CheckboxListTile(
                  value: _isRoundTrip,
                  onChanged: (v) {
                    setState(() {
                      _isRoundTrip = v ?? false;
                      if (!_isRoundTrip) _returnDate = null;
                    });
                  },
                  title: const Text('Khứ hồi (Quay về)'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                // Ngày đi / ngày về
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      _buildDateTile(
                        label: 'Ngày đi',
                        value: _departDate != null ? _dateFormat.format(_departDate!) : null,
                        onTap: _pickDepartDate,
                        icon: Icons.flight_takeoff,
                      ),
                      const Divider(height: 1),
                      _buildDateTile(
                        label: 'Ngày về',
                        value: _returnDate != null ? _dateFormat.format(_returnDate!) : null,
                        onTap: _pickReturnDate,
                        icon: Icons.flight_land,
                        enabled: _isRoundTrip,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Số vé
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Số vé', style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _decrementTickets,
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('$_tickets', style: const TextStyle(fontSize: 16)),
                        IconButton(
                          onPressed: _incrementTickets,
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 16),

                // Button tìm vé
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text('Tìm vé', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


