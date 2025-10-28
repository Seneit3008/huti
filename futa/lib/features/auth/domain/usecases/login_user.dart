import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email và mật khẩu không được để trống');
    }
    return await repository.login(email, password);
  }
}