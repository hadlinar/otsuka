import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocEvent extends Equatable{
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends LoginBlocEvent{}

class LoginEvent extends LoginBlocEvent{

  final String username;
  final String password;

  const LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}