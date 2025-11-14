// data/models/taiKhoanKHModel.dart
import '../../domain/entities/taiKhoanKH_ETT.dart';

class taiKhoanKHModel extends taiKhoanKH {
  taiKhoanKHModel({
    required String id,
    required String email,
    required String name,
  }) : super(id: id, email: email, name: name);

  factory taiKhoanKHModel.fromJson(Map<String, dynamic> json) {
    return taiKhoanKHModel(
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
