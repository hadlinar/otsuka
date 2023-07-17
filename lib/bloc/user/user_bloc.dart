import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_sources/repository/user_repository.dart';
import 'user_state.dart';
import 'user_event.dart';
import 'user_bloc.dart';

export 'user_state.dart';
export 'user_event.dart';
export 'user_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserBlocState> {
  final UserRepository _userRepository;
  // final LogoutRepository _logoutRepository;
  final SharedPreferences _sharedPreferences;

  // static create(UserRepository userRepository, LogoutRepository logoutRepository, SharedPreferences sharedPreferences) => UserBloc(userRepository, logoutRepository, sharedPreferences);
  static create(UserRepository userRepository, SharedPreferences sharedPreferences) => UserBloc(userRepository, sharedPreferences);

  UserBloc(this._userRepository, this._sharedPreferences) : super(LoadingUserState());

  @override
  Stream<UserBlocState> mapEventToState(UserEvent event) async* {
    if(event is GetUserEvent) {
      yield* _mapToGetUserEvent(event);
    }
    if(event is LogoutEvent) {
      yield* _logoutToState(event);
    }
  }

  Stream<UserBlocState> _mapToGetUserEvent(GetUserEvent e) async* {
    yield LoadingUserState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _userRepository.getUser("Bearer $token");
      if (response.message == "ok") {
        yield GetUserState(response.result);
      }
    } on DioException catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLoggedInState();
      }
      else {
        yield FailedUserState();
      }
    }
  }

  Stream<UserBlocState> _logoutToState(LogoutEvent e) async* {
    yield LoadingUserState();
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _userRepository.logout("Bearer $token");
      if(response.message == "you've been logged out") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("access_token");
        yield NotLoggedInState();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 400){
        yield NotLoggedInState();
      }
      yield ServerErrorState();
    }
  }
}