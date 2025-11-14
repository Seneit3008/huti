import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Vui lòng nhập đầy đủ thông tin');
    }
    return await repository.register(name, email, password);
  }
}