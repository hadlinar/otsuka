import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// "username": "kacab44",
// "password_mobile": "$2b$10$/eLycsfJX0zy0iGa4EMyheZNBi5GoD8fvLug4KFnn10vpm30ikm6q",
// "nama": "kacab44",
// "branch_id": "44",
// "kategori_otsuka": "U",
// "role_id": 1,
// "is_active": 1

@JsonSerializable()
class User {
  String username;
  String password_mobile;
  String nama;
  String branch_id;
  String kategori_otsuka;
  int role_id;
  int is_active;
  String? flg_am;

  User({
    required this.username,
    required this.password_mobile,
    required this.nama,
    required this.branch_id,
    required this.kategori_otsuka,
    required this.role_id,
    required this.is_active,
    this.flg_am
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class UserResponse {
  String message;
  String check;
  User result;

  UserResponse(this.message, this.check, this.result);

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
}

@JsonSerializable()
class ChangeNameResponse {
  String message;

  ChangeNameResponse(this.message);

  factory ChangeNameResponse.fromJson(Map<String, dynamic> json) => _$ChangeNameResponseFromJson(json);
}

@JsonSerializable()
class ChangePasswordResponse {
  String message;
  String token;

  ChangePasswordResponse(this.message, this.token);

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => _$ChangePasswordResponseFromJson(json);
}

@JsonSerializable()
class LogoutResponse {
  String message;

  LogoutResponse(this.message);

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => _$LogoutResponseFromJson(json);
}