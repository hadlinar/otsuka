import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// "username": "kacab",
// "password_mobile": "$2b$10$.SIWyd1R5zyWUgIaN4O5b.3L4fcrni/HnCEMOzidTn7VJhVmwDcqm",
// "nama": "Test Kacab",
// "branch_id": "19",
// "role_id": 1,
// "is_active": 1

@JsonSerializable()
class User {
  String username;
  String nama;
  String branch_id;
  int role_id;
  int is_active;

  User({
    required this.username,
    required this.nama,
    required this.branch_id,
    required this.role_id,
    required this.is_active
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class UserResponse {
  String message;
  User result;

  UserResponse(this.message, this.result);

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
}