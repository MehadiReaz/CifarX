import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;
  final int? expiresInMins;

  const LoginParams({
    required this.username,
    required this.password,
    this.expiresInMins = 1,
  });

  @override
  List<Object?> get props => [username, password, expiresInMins];
}
