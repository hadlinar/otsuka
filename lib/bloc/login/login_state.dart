import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocState extends Equatable{}

class LoadingLoginState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class SuccessLoginState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class WrongPasswordLoginState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class NotMatchedLoginState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class NotLoggedInState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class ServerErrorState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class NewPasswordNotMatchedState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}

class NoAccessState extends LoginBlocState{
  @override
  List<Object?> get props => [];
}