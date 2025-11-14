import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// Hàm fetchPlaces đặt ở đây
Future<List<Map<String, dynamic>>> fetchPlaces(String query) async {
  if (query.isEmpty) return [];

  // Encode UTF-8 chuẩn để giữ dấu tiếng Việt
  final encodedQuery = Uri.encodeComponent(query);

  final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search'
          '?q=$encodedQuery'
          '&format=json'
          '&limit=5'
          '&countrycodes=vn'      // 🔥 Chỉ Việt Nam
          '&accept-language=vi'   // 🔥 Trả tên địa điểm bằng tiếng Việt
          '&addressdetails=1'     // nếu cần lấy tỉnh/huyện
  );

  final response = await http.get(url, headers: {
    'User-Agent': 'FlutterApp/1.0 (your@email.com)',
  });

  if (response.statusCode == 200) {
    // 🔥 BodyBytes giúp giữ UTF-8 chính xác
    final List data = json.decode(utf8.decode(response.bodyBytes));

    return data.map<Map<String, dynamic>>((item) => {
      'name': item['display_name'],
      'lat': double.tryParse(item['lat'] ?? '') ?? 0,
      'lon': double.tryParse(item['lon'] ?? '') ?? 0,
      'address': item['address'], // nếu bạn cần tỉnh/huyện
    }).toList();
  } else {
    return [];
  }
}



class FreeMapAutocomplete extends StatefulWidget {
  @override
  _FreeMapAutocompleteState createState() => _FreeMapAutocompleteState();
}

class _FreeMapAutocompleteState extends State<FreeMapAutocomplete> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _suggestions = [];

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(10.0057301, 105.7678954),
    zoom: 16,
  );

  void _onSearchChanged(String value) async {
    final results = await fetchPlaces(value);
    setState(() {
      _suggestions = results;
    });
  }

  void _onSuggestionTap(Map<String, dynamic> place) async {
    _searchController.text = place['name'];
    _suggestions = [];
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(place['lat'], place['lon']), 16),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            top: 50,
            left: 15,
            right: 15,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Tìm địa điểm...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _suggestions = [];
                        });
                      },
                    ),
                  ),
                  onChanged: _onSearchChanged, // xử lý UTF-8 bên dưới
                ),
                if (_suggestions.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final place = _suggestions[index];
                        return ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(place['name']),
                          onTap: () => _onSuggestionTap(place),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
