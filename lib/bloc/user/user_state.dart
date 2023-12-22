import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

@immutable
abstract class UserBlocState extends Equatable{
  const UserBlocState();

  @override
  List<Object> get props => [];
}

class InitialUserBlocState extends UserBlocState {}

class LoadingUserState extends UserBlocState{}

class SuccessUserState extends UserBlocState{}

class FailedUserState extends UserBlocState{}

class NotLoggedInState extends UserBlocState{}

class ServerErrorState extends UserBlocState{}

class GetUserState extends UserBlocState{
  final User getUser;
  final String check;

  const GetUserState(this.getUser, this.check);

  @override
  List<Object> get props => [getUser, check];
}

class LogoutState extends UserBlocState{}

class SuccessChangeNameState extends UserBlocState{}

class SuccessChangePasswordState extends UserBlocState{}

class PasswordNotMatchedState extends UserBlocState{}

class WrongPasswordState extends UserBlocState{}