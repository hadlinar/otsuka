import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class Login {
  String username;
  String password;

  Login({
    required this.username,
    required this.password
  });

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}

@JsonSerializable()
class LoginResponse {
  String message;
  String token;

  LoginResponse(this.message, this.token);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}