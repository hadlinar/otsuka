import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent{}

class GetUserEvent extends UserEvent{}

class GetUserOIEvent extends UserEvent{}

class LogoutEvent extends UserEvent{}

class ChangeNameEvent extends UserEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

  final String name;

  ChangeNameEvent(this.name);
}

class ChangePasswordEvent extends UserEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

  final String password;
  final String newPassword;
  final String retype;

  ChangePasswordEvent(this.password, this.newPassword, this.retype);
}