import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocState extends Equatable{
  const LoginBlocState();

  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginBlocState{}

class LoadingLoginState extends LoginBlocState{}

class SuccessLoginState extends LoginBlocState{}

class FailedLoginState extends LoginBlocState{}

class WrongPasswordLoginState extends LoginBlocState{}

class NotMatchedLoginState extends LoginBlocState{}

class NotLoggedInState extends LoginBlocState{}

class ServerErrorState extends LoginBlocState{}

class NewPasswordNotMatchedState extends LoginBlocState{}

class NoUsernameState extends LoginBlocState{}