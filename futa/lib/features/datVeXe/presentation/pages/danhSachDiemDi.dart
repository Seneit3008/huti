import 'package:flutter/material.dart';
import 'package:futa/features/datVeXe/presentation/pages/banDoBenXe.dart';
import 'banDoBenXe.dart';

class DanhSachDiemDi extends StatefulWidget {
  const DanhSachDiemDi({super.key});

  @override
  State<DanhSachDiemDi> createState() => _DanhSachDiemDiState();
}

class _DanhSachDiemDiState extends State<DanhSachDiemDi> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _items = [
    "Xe khách Futa",
    "Xe Hoàng Long",
    "Xe Phương Trang",
    "Xe Mai Linh",
    "Xe Thành Bưởi",
  ];
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems =
          _items.where((e) => e.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn điểm đi'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Ô tìm kiếm có icon bản đồ
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bến xe hoặc hãng xe',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.location_on_outlined,
                      color: Colors.redAccent),
                  onPressed: () async {
                    final selected = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => BanDoBenXe()),
                    );
                    if (selected != null) {
                      Navigator.pop(context, selected);
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return ListTile(
                  leading:
                  const Icon(Icons.directions_bus, color: Colors.blueAccent),
                  title: Text(item),
                  onTap: () => Navigator.pop(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
