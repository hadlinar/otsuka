import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

@immutable
abstract class UserBlocState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadingUserState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class SuccessUserState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class FailedUserState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class NotLoggedInState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class ServerErrorState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class GetUserState extends UserBlocState{
  User getUser;
  String check;

  GetUserState(this.getUser, this.check);
}

class LogoutState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class SuccessChangeNameState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class SuccessChangePasswordState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class PasswordNotMatchedState extends UserBlocState{
  @override
  List<Object?> get props => [];
}

class WrongPasswordState extends UserBlocState{
  @override
  List<Object?> get props => [];
}