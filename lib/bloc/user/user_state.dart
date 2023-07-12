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

  GetUserState(this.getUser);
}