// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String,
      nama: json['nama'] as String,
      branch_id: json['branch_id'] as String,
      role_id: json['role_id'] as int,
      is_active: json['is_active'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'nama': instance.nama,
      'branch_id': instance.branch_id,
      'role_id': instance.role_id,
      'is_active': instance.is_active,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['message'] as String,
      User.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };