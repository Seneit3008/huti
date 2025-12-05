import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/datVeXeBloc.dart';

class BanDoBenXe extends StatefulWidget {
  @override
  _BanDoBenXeState createState() => _BanDoBenXeState();
}

class _BanDoBenXeState extends State<BanDoBenXe> {
  final TextEditingController _searchController = TextEditingController();
  GoogleMapController? _controller;

  Set<Marker> _markers = {};
  bool _showSuggestions = false;

  /// DANH SÁCH BẾN XE ĐÃ TỪNG TÌM (Search History)
  List<dynamic> recentSearch = [];

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(21.0278, 105.8342),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bản đồ bến xe')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: (controller) => _controller = controller,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            markers: _markers,
          ),

          Positioned(
            top: 15,
            left: 15,
            right: 15,
            child: Column(
              children: [
                // ==========================================
                // 🔍 THANH TÌM KIẾM
                // ==========================================
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Nhập tên bến xe...",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  onTap: () {
                    setState(() => _showSuggestions = true);
                  },

                  onChanged: (value) {
                    setState(() {}); // trigger rebuild

                    if (value.trim().isEmpty) return;
                    context.read<DatVeXeBloc>().add(layDSBenXe_Event(value));
                  },
                ),

                // ==========================================
                // GỢI Ý: API hoặc SEARCH HISTORY
                // ==========================================
                _showSuggestions
                    ? BlocBuilder<DatVeXeBloc, DatVeXeState>(
                  builder: (context, state) {
                    final query = _searchController.text.trim();

                    // 1️⃣ Nếu chưa nhập gì -> HIỆN SEARCH HISTORY
                    if (query.isEmpty) {
                      if (recentSearch.isEmpty) {
                        return SizedBox(); // chưa có lịch sử thì ẩn
                      }

                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: Column(
                          children: recentSearch.take(5).map((bx) {
                            return _buildSuggestionItem(bx);
                          }).toList(),
                        ),
                      );
                    }

                    // 2️⃣ Đang loading kết quả API
                    if (state is DatVeXeLoading) {
                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Text("Đang tìm..."),
                      );
                    }

                    // 3️⃣ Hiển thị gợi ý từ API
                    if (state is DatVeXeSuccess) {
                      final items = state.dsbx.take(5).toList();

                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: Column(
                          children:
                          items.map((bx) => _buildSuggestionItem(bx)).toList(),
                        ),
                      );
                    }

                    return SizedBox();
                  },
                )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET GỢI Ý 1 ITEM (CÓ ICON)
  // ==========================================
  Widget _buildSuggestionItem(dynamic bx) {
    return ListTile(
      leading: Icon(Icons.directions_bus, color: Colors.blue),
      title: Text(bx.name),

      onTap: () {
        // Lưu vào Search History nếu chưa có
        if (!recentSearch.any((e) => e.name == bx.name)) {
          recentSearch.insert(0, bx); // thêm đầu danh sách
          if (recentSearch.length > 10) recentSearch.removeLast(); // giới hạn 10
        }

        // Tạo marker
        _markers = {
          Marker(
            markerId: MarkerId(bx.name),
            position: LatLng(bx.lat, bx.lng),
            infoWindow: InfoWindow(title: bx.name),
          ),
        };

        // Zoom đến vị trí
        _controller?.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(bx.lat, bx.lng), 15),
        );

        // Gán vào ô tìm kiếm
        _searchController.text = bx.name;

        // Ẩn suggestion
        setState(() => _showSuggestions = false);

        FocusScope.of(context).unfocus();
      },
    );
  }
}
