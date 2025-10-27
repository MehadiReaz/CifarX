import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends Equatable {
  final String username;
  final String password;
  final int? expiresInMins;

  const LoginRequest({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [username, password, expiresInMins];
}
