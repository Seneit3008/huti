// data/models/taiKhoanKHModel.dart
import '../../domain/entities/taiKhoanNV_ETT.dart';

class taiKhoanNVModel extends taiKhoanNV {
  taiKhoanNVModel({
    required String id,
    required String email,
    required String name,
  }) : super(id: id, email: email, name: name);

  factory taiKhoanNVModel.fromJson(Map<String, dynamic> json) {
    return taiKhoanNVModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
  };
}
