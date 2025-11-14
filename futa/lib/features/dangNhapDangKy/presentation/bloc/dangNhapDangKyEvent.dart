// presentation/bloc/dangNhapDangKyEvent.dart
part of 'dangNhapDangKyBloc.dart';

abstract class AuthEvent {}

class dangNhapKH_Event extends AuthEvent {
  final String email;
  final String password;
  dangNhapKH_Event(this.email, this.password);
}

class dangKyKH_Event extends AuthEvent {
  final String name;
  final String email;
  final String password;
  dangKyKH_Event(this.name, this.email, this.password);
}

class dangNhapNV_Event extends AuthEvent {
  final String email;
  final String password;
  dangNhapNV_Event(this.email, this.password);
}

class dangXuat_Event extends AuthEvent {}
