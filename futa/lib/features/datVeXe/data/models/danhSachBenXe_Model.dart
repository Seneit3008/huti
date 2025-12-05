
import '../../domain/entities/danhSachBenXe_ETT.dart';

class danhSachBenXeModel extends danhSachBenXe {


  danhSachBenXeModel({
    required String name,
    required double lat,
    required double lng,
    required int province_id,
  }) : super(name: name, lat: lat, lng: lng, province_id: province_id);

  factory danhSachBenXeModel.fromJson(Map<String, dynamic> json) {
    return danhSachBenXeModel(
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
      province_id: json['province_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'lat': lat,
    'lng': lng,
    'province_id': province_id
  };
}
