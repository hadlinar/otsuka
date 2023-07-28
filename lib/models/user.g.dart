// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String,
      password_mobile: json['password_mobile'] as String,
      nama: json['nama'] as String,
      branch_id: json['branch_id'] as String,
      kategori_otsuka: json['kategori_otsuka'] as String,
      role_id: json['role_id'] as int,
      is_active: json['is_active'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password_mobile': instance.password_mobile,
      'nama': instance.nama,
      'branch_id': instance.branch_id,
      'kategori_otsuka': instance.kategori_otsuka,
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

ChangeNameResponse _$ChangeNameResponseFromJson(Map<String, dynamic> json) =>
    ChangeNameResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$ChangeNameResponseToJson(ChangeNameResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
      json['message'] as String,
      json['token'] as String,
    );

Map<String, dynamic> _$ChangePasswordResponseToJson(
        ChangePasswordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
    };

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
