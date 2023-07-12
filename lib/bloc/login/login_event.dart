import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocEvent extends Equatable{
  const LoginBlocEvent();
}

class LoginEvent extends LoginBlocEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
}